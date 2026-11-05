-- =====================================================================
-- CONSULTA DE REDISEÑO — PRUEBA DE VARIANTES DE LA REGLA DE CONTINGENCIA A1
-- (16–18 noviembre 2026 — mínimo no negociable)
--
-- Propósito: probar distintas configuraciones de la regla de contingencia
-- A1 (ciclos < 4) contra el listado de alertas depuradas y evaluar:
--   a) cuántas alertas A1 resultan con cada variante
--   b) si cumplen los cupos (≤24 A1 por mes, ≤242 combinado)
--   c) cuántas de las 19 reclamos procedentes con lectura aparecen
--
-- Requisito previo: haber cargado el archivo
-- C:\Users\Toshiba\Downloads\Listado_Alertas_Depuradas.xls
-- en una tabla temporal llamada `alertas_depuradas` con las 23 columnas
-- generadas por la consulta de alertas (commit 1acbba0).
--
-- Cómo usar: modificar los parámetros en la CTE `parametros` (meses_previos
-- y tratamiento_de_ceros) y volver a ejecutar.
-- =====================================================================

-- Paso 1: Identificar los 19 reclamos procedentes con lectura en la ventana
WITH reclamos_procedentes_con_lectura AS (
    SELECT r.id_reclamo,
           r.nro_cuenta,
           DATE_TRUNC('month', r.fecha_hora_reg)::date AS mes
      FROM tfv_reclamo r
      JOIN tfv_respuesta_reclamo rr ON rr.id_reclamo = r.id_reclamo
      JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
     WHERE r.fecha_hora_reg >= DATE '2026-01-01'
       AND r.fecha_hora_reg <  DATE '2026-10-01'
       AND r.tipo_reclamo = 3
       AND rr.sw_procedente::text = '1'
       AND rl.id_lectura IS NOT NULL
),
-- Paso 2: Parámetros de la regla de contingencia A1 (MODIFICAR AQUÍ)
-- meses_previos: cuántos meses hacia atrás se usan para la media (1 a 6)
-- tratamiento_de_ceros: 'excluir' (lec_actual <> 0) o 'incluir' (todas las celdas)
parametros AS (
    SELECT 6 AS meses_previos,
           'excluir'::text AS tratamiento_de_ceros
),
-- Paso 3: Reconstruir el panel con desviación_A1 para cada variante
-- Reutiliza la lógica de referencia y desviación del método escrito
panel_base AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           p.consumo AS consumo_observado,
           p.id_lectura,
           r.ciclos_disponibles,
           r.referencia,
           ABS(p.consumo - r.referencia) / r.referencia AS desviacion_a2
      FROM (
          SELECT nro_cuenta,
                 DATE_TRUNC('month', fecha_lec)::date AS mes,
                 fecha_lec,
                 lec_actual,
                 consumo,
                 id_lectura
            FROM tfv_historico_lecturador
           WHERE fecha_lec >= DATE '2022-01-01'
             AND fecha_lec <  DATE '2026-10-01'
      ) p
      JOIN (
          SELECT nro_cuenta,
                 EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
                 COUNT(*) AS ciclos_disponibles,
                 PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
            FROM (
                SELECT nro_cuenta,
                       DATE_TRUNC('month', fecha_lec)::date AS mes,
                       consumo
                  FROM tfv_historico_lecturador
                 WHERE fecha_lec >= DATE '2022-01-01'
                   AND fecha_lec <  DATE '2026-10-01'
            ) p2
           WHERE mes >= DATE '2022-01-01'
             AND mes <  DATE '2026-01-01'
           GROUP BY nro_cuenta, mes_del_anio
      ) r
        ON r.nro_cuenta = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND p.mes <  DATE '2026-10-01'
       AND r.ciclos_disponibles < 4
       AND r.referencia > 0
),
-- Paso 4: Calcular media de meses previos según el parámetro
ventana_previa AS (
    SELECT pb.nro_cuenta,
           pb.mes,
           pb.lec_actual,
           pb.consumo_observado,
           pb.ciclos_disponibles,
           pb.referencia,
           pb.desviacion_a2,
           COUNT(h2.consumo) FILTER (WHERE h2.lec_actual <> 0 OR p.tratamiento_de_ceros = 'incluir') AS meses_previos_disponibles,
           AVG(h2.consumo) FILTER (WHERE h2.lec_actual <> 0 OR p.tratamiento_de_ceros = 'incluir') AS media_6meses
      FROM panel_base pb
      JOIN parametros p ON TRUE
      LEFT JOIN (
          SELECT nro_cuenta,
                 DATE_TRUNC('month', fecha_lec)::date AS mes,
                 lec_actual,
                 consumo
            FROM tfv_historico_lecturador
           WHERE fecha_lec >= DATE '2022-01-01'
             AND fecha_lec <  DATE '2026-10-01'
      ) h2
        ON h2.nro_cuenta = pb.nro_cuenta
       AND h2.mes >= (pb.mes - (p.meses_previos || ' months')::interval)
       AND h2.mes <  pb.mes
     GROUP BY pb.nro_cuenta, pb.mes, pb.lec_actual, pb.consumo_observado,
              pb.ciclos_disponibles, pb.referencia, pb.desviacion_a2,
              p.meses_previos, p.tratamiento_de_ceros
),
-- Paso 5: Calcular desviación_A1 y aplicar umbral
dev_a1 AS (
    SELECT nro_cuenta,
           mes,
           lec_actual,
           consumo_observado,
           ciclos_disponibles,
           referencia,
           desviacion_a2,
           meses_previos_disponibles,
           media_6meses,
           ABS(consumo_observado - media_6meses) / media_6meses AS desviacion_a1
      FROM ventana_previa
     WHERE meses_previos_disponibles >= 1
       AND media_6meses > 0
       AND lec_actual <> 0
),
-- Paso 6: Aplicar umbral θ_A1 y cupos
umbrales AS (
    SELECT 39.6666666666667::numeric AS theta_A2,
           495.362260343088::numeric AS theta_A1
),
alertas_a1_variante AS (
    SELECT d.nro_cuenta,
           d.mes,
           d.lec_actual,
           d.consumo_observado,
           d.ciclos_disponibles,
           d.referencia,
           d.desviacion_a1,
           'A1' AS canal,
           u.theta_A1,
           ROW_NUMBER() OVER (PARTITION BY d.mes ORDER BY d.desviacion_a1 DESC, d.nro_cuenta) AS posicion_en_mes
      FROM dev_a1 d
      CROSS JOIN umbrales u
     WHERE d.desviacion_a1 >= u.theta_A1
),
-- Paso 7: Aplicar cupo de 24 A1 por mes
seleccion_a1 AS (
    SELECT * FROM alertas_a1_variante WHERE posicion_en_mes <= 24
),
-- Paso 8: Cruzar con reclamos procedentes con lectura
alerta_cruzada AS (
    SELECT s.nro_cuenta,
           s.mes,
           s.canal,
           s.desviacion_a1,
           s.posicion_en_mes,
           rpl.id_reclamo AS reclamo_procedente_asociado,
           CASE WHEN rpl.id_reclamo IS NOT NULL THEN 'verdadero_positivo'
                ELSE 'falso_positivo' END AS tipo_alerta
      FROM seleccion_a1 s
      LEFT JOIN reclamos_procedentes_con_lectura rpl
        ON s.nro_cuenta = rpl.nro_cuenta
       AND s.mes = rpl.mes
),
-- Paso 9: Resumen por mes
resumen_por_mes AS (
    SELECT mes,
           COUNT(*) AS alertas_a1,
           COUNT(*) FILTER (WHERE tipo_alerta = 'verdadero_positivo') AS verdaderos_positivos,
           COUNT(*) FILTER (WHERE tipo_alerta = 'falso_positivo') AS falsos_positivos
      FROM alerta_cruzada
     GROUP BY mes
     ORDER BY mes
),
-- Paso 10: Totales globales
totales AS (
    SELECT COUNT(*) AS total_alertas_a1,
           COUNT(*) FILTER (WHERE tipo_alerta = 'verdadero_positivo') AS total_verdaderos_positivos,
           COUNT(*) FILTER (WHERE tipo_alerta = 'falso_positivo') AS total_falsos_positivos,
           COUNT(DISTINCT mes) AS meses_con_alertas,
           MAX(alertas_a1) AS max_alertas_a1_en_un_mes
      FROM alerta_cruzada ac
      JOIN resumen_por_mes rpm ON rpm.mes = ac.mes
)
SELECT t.total_alertas_a1,
       t.total_verdaderos_positivos,
       t.total_falsos_positivos,
       t.meses_con_alertas,
       t.max_alertas_a1_en_un_mes,
       CASE WHEN t.max_alertas_a1_en_un_mes > 24 THEN 'SUPERA CUPOS A1' ELSE 'OK cupo A1' END AS verifica_cupo_a1,
       ROUND(100.0 * t.total_verdaderos_positivos / 19.0, 2) AS porcentaje_cobertura_reclamos,
       ROUND(100.0 * t.total_falsos_positivos / NULLIF(t.total_alertas_a1, 0), 2) AS porcentaje_falsos_positivos
  FROM totales t;

-- Listado detallado de alertas A1 con esta variante
SELECT ac.nro_cuenta,
       ac.mes,
       TO_CHAR(ac.mes, 'YYYY-MM') AS cuenta_mes,
       ac.desviacion_a1,
       ac.posicion_en_mes,
       ac.tipo_alerta,
       ac.reclamo_procedente_asociado
  FROM alerta_cruzada ac
 ORDER BY ac.mes, ac.desviacion_a1 DESC;

-- Autocalculeos esperados (para los parámetros actuales: 6 meses previos, excluir ceros):
--   total_alertas_a1 DEBE dar 113 (con θ_A1 = 495,362260343088, 6 meses previos, excluir ceros)
--   total_verdaderos_positivos DEBE dar 0 (ninguna coincide con los 19 reclamos procedentes)
--   total_falsos_positivos DEBE dar 113
--   max_alertas_a1_en_un_mes DEBE dar <= 24
--   porcentaje_falsos_positivos DEBE dar 100,00
--
-- Para probar otras variantes, modificar la CTE `parametros`:
--   meses_previos: 1, 2, 3, 4, 5 o 6
--   tratamiento_de_ceros: 'excluir' o 'incluir'
