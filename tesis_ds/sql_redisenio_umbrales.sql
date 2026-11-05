-- =====================================================================
-- CONSULTA DE REDISEÑO — E8 Formativa por simulación
-- (16–18 noviembre 2026 — mínimo no negociable)
--
-- Propósito: probar diferentes valores de umbrales θ_A2 y θ_A1 contra
-- el listado de alertas depuradas (1 515 filas) y evaluar:
--   a) cuántas alertas resultan con cada umbral candidato
--   b) si cumplen los cupos (≤218 A2, ≤24 A1, ≤242 combinado por mes)
--   c) cuántas de las 19 reclamos procedentes con lectura aparecen
--
-- Requisito previo: haber cargado el archivo
-- C:\Users\Toshiba\Downloads\Listado_Alertas_Depuradas.xls
-- en una tabla temporal llamada `alertas_depuradas` con las 23 columnas
-- generadas por la consulta de alertas (commit 1acbba0).
--
-- Cómo usar: reemplazar los valores de θ_A2 y θ_A1 en la CTE `umbrales`
-- por los valores candidatos que quiera probar, ejecutar y revisar el
-- resultado.
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
-- Paso 2: Umbrales candidatos (MODIFICAR AQUÍ LOS VALORES A PROBAR)
umbrales AS (
    SELECT 39.6666666666667::numeric AS theta_A2,   -- valor actual DEC-119
           495.362260343088::numeric AS theta_A1    -- valor actual DEC-120
),
-- Paso 3: Filtrar alertas según los umbrales candidatos
alertas_por_umbral AS (
    SELECT a.cuenta,
           a.mes,
           a.canal_alerta,
           a.magnitud_desviacion,
           u.theta_A2,
           u.theta_A1,
           CASE
             WHEN a.canal_alerta = 'A2' AND a.magnitud_desviacion >= u.theta_A2
               THEN 'alerta_A2'
             WHEN a.canal_alerta = 'A1' AND a.magnitud_desviacion >= u.theta_A1
               THEN 'alerta_A1'
             ELSE 'sin_alerta'
           END AS estado_alerta,
           rpl.id_reclamo AS reclamo_procedente_asociado
      FROM alertas_depuradas a
      CROSS JOIN umbrales u
      LEFT JOIN reclamos_procedentes_con_lectura rpl
        ON a.cuenta = rpl.nro_cuenta
       AND a.mes = rpl.mes
),
-- Paso 4: Resumen por mes y canal (verificar cupos)
resumen_por_mes AS (
    SELECT mes,
           COUNT(*) FILTER (WHERE estado_alerta = 'alerta_A2') AS alertas_a2,
           COUNT(*) FILTER (WHERE estado_alerta = 'alerta_A1') AS alertas_a1,
           COUNT(*) FILTER (WHERE estado_alerta IN ('alerta_A2','alerta_A1')) AS alertas_totales,
           COUNT(*) FILTER (WHERE reclamo_procedente_asociado IS NOT NULL) AS coinciden_con_reclamo
      FROM alertas_por_umbral
     WHERE estado_alerta IN ('alerta_A2','alerta_A1')
     GROUP BY mes
     ORDER BY mes
),
-- Paso 5: Totales globales
totales AS (
    SELECT COUNT(*) FILTER (WHERE estado_alerta = 'alerta_A2') AS total_a2,
           COUNT(*) FILTER (WHERE estado_alerta = 'alerta_A1') AS total_a1,
           COUNT(*) FILTER (WHERE estado_alerta IN ('alerta_A2','alerta_A1')) AS total_alertas,
           COUNT(*) FILTER (WHERE reclamo_procedente_asociado IS NOT NULL) AS coinciden_con_reclamo,
           COUNT(DISTINCT mes) AS meses_con_alertas
      FROM alertas_por_umbral
)
SELECT t.total_a2,
       t.total_a1,
       t.total_alertas,
       t.coinciden_con_reclamo AS cobertura_reclamos_procedentes,
       ROUND(100.0 * t.coinciden_con_reclamo / 19.0, 2) AS porcentaje_cobertura,
       ROUND(100.0 * (t.total_alertas - t.coinciden_con_reclamo) / NULLIF(t.total_alertas, 0), 2) AS porcentaje_falsos_positivos,
       t.meses_con_alertas,
       -- Verificar cupos: ningún mes supera 218 A2 ni 24 A1
       CASE WHEN MAX(r.alertas_a2) > 218 THEN 'SUPERA CUPOS A2' ELSE 'OK cupos A2' END AS verifica_cupo_a2,
       CASE WHEN MAX(r.alertas_a1) > 24  THEN 'SUPERA CUPOS A1' ELSE 'OK cupos A1' END AS verifica_cupo_a1,
       CASE WHEN MAX(r.alertas_totales) > 242 THEN 'SUPERA TECHO 242' ELSE 'OK techo 242' END AS verifica_techo_242
  FROM totales t
  CROSS JOIN resumen_por_mes r;

-- Paso 6: Listado detallado de alertas que coinciden con reclamos procedentes
-- (útil para revisar individualmente cuáles se capturan con cada umbral)
SELECT ac.cuenta,
       ac.mes,
       TO_CHAR(ac.mes, 'YYYY-MM') AS cuenta_mes,
       ac.canal_alerta,
       ac.magnitud_desviacion,
       ac.estado_alerta,
       ac.reclamo_procedente_asociado
  FROM alertas_por_umbral ac
 WHERE ac.estado_alerta IN ('alerta_A2','alerta_A1')
 ORDER BY ac.mes, ac.canal_alerta, ac.magnitud_desviacion DESC;

-- Autocalculeos esperados (escritos antes de correr, para los umbrales actuales):
--   total_a2 DEBE dar 1 402 (con θ_A2 = 39,6666666666667)
--   total_a1 DEBE dar 113 (con θ_A1 = 495,362260343088)
--   total_alertas DEBE dar 1 515
--   coinciden_con_reclamo DEBE dar 0 (cobertura 0 %)
--   porcentaje_falsos_positivos DEBE dar 100,00
--   Ningún mes DEBE superar 218 A2 ni 24 A1
--
-- Para probar otros umbrales, modificar la CTE `umbrales` y volver a ejecutar.
-- Ejemplo: θ_A2 = 30, θ_A1 = 400 para ver si aumentan las coincidencias.
