-- =====================================================================
-- COPIA PARA CORRER - A2.1.d SALIDA 2 (4 nov 2026)
--     Es una copia EXACTA de las lineas 4631 a 4710 de
--     sql_a2_extraccion.sql, hecha para no tener que buscarla dentro de
--     4 843 lineas. SI LAS DOS COPIAS DIFIEREN, MANDA EL ORIGINAL.
--
--     QUE DEVUELVE: UNA fila con DIECISIETE columnas, en este orden:
--       filas_en_procedente, valor_procedente, procedentes_57_meses,
--       grupos_en_el_dominio, reclamos_ventana,
--       reclamos_ventana_con_lectura, reclamos_ventana_sin_lectura,
--       procedentes_ventana_con_lectura, procedentes_ventana_sin_lectura,
--       procedentes_ventana, parcialmente_procedentes_ventana,
--       reclamos_ventana_sin_respuesta, meses_medidos,
--       meses_medidos_con_lectura, reclamos_de_mas_en_marcados,
--       reclamos_con_varias_respuestas, reclamos_con_varias_lecturas.
--
--     LO QUE DEBE DAR, escrito antes de correr: 1, 1, 177, 4, 2 713,
--     109, 2 604, 19, 1 824, 1 843, 0, 0, 9, 9, 0, 0, 0.
-- =====================================================================

-- A2.1.d SALIDA 2 - las diecisiete columnas de la muestra, en una fila
WITH dominio AS (
    SELECT rr.sw_procendente,
           COUNT(DISTINCT r.id_reclamo) FILTER (WHERE r.fecha_hora_reg >= DATE '2022-01-01'
                                                 AND r.fecha_hora_reg <  DATE '2026-10-01'
                                                 AND rl.id_lectura IS NOT NULL) AS en_57_meses
      FROM tfv_reclamo r
      LEFT JOIN tfv_respuesta_reclamo rr ON rr.id_reclamo = r.id_reclamo
      LEFT JOIN tfv_reclamo_lectura   rl ON rl.id_reclamo = r.id_reclamo
     WHERE r.fecha_hora_reg >= DATE '2022-01-01'
       AND r.fecha_hora_reg <  DATE '2026-10-01'
     GROUP BY rr.sw_procendente
),
procedente AS (
    SELECT sw_procendente
      FROM dominio
     WHERE sw_procendente::text = '1'
),
reclamos_ventana AS (
    SELECT r.id_reclamo,
           DATE_TRUNC('month', r.fecha_hora_reg)::date AS mes
      FROM tfv_reclamo r
     WHERE r.fecha_hora_reg >= DATE '2026-01-01'
       AND r.fecha_hora_reg <  DATE '2026-10-01'
),
marcados AS (
    SELECT rv.id_reclamo,
           rv.mes,
           (rr.sw_procendente IS NOT DISTINCT FROM p.sw_procendente) AS es_procedente,
           rr.sw_procendente::text                                   AS valor,
           rl.id_lectura
      FROM reclamos_ventana rv
      JOIN procedente p ON TRUE
      LEFT JOIN tfv_reclamo_lectura rl   ON rl.id_reclamo = rv.id_reclamo
      LEFT JOIN tfv_respuesta_reclamo rr ON rr.id_reclamo = rv.id_reclamo
)
SELECT (SELECT COUNT(*) FROM procedente)                             AS filas_en_procedente,
       (SELECT MAX(sw_procendente::text) FROM procedente)            AS valor_procedente,
       (SELECT COALESCE(MAX(d.en_57_meses), 0)
          FROM dominio d
          JOIN procedente p
            ON d.sw_procendente IS NOT DISTINCT FROM p.sw_procendente) AS procedentes_57_meses,
       (SELECT COUNT(*) FROM dominio)                                AS grupos_en_el_dominio,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados)             AS reclamos_ventana,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados
         WHERE id_lectura IS NOT NULL)                               AS reclamos_ventana_con_lectura,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados
         WHERE id_lectura IS NULL)                                   AS reclamos_ventana_sin_lectura,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados
         WHERE es_procedente AND id_lectura IS NOT NULL)             AS procedentes_ventana_con_lectura,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados
         WHERE es_procedente AND id_lectura IS NULL)                 AS procedentes_ventana_sin_lectura,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados
         WHERE es_procedente)                                        AS procedentes_ventana,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados
         WHERE valor = '3')                                          AS parcialmente_procedentes_ventana,
       (SELECT COUNT(DISTINCT id_reclamo) FROM marcados
         WHERE valor IS NULL)                                        AS reclamos_ventana_sin_respuesta,
       (SELECT COUNT(DISTINCT mes) FROM marcados)                    AS meses_medidos,
       (SELECT COUNT(DISTINCT mes) FROM marcados
         WHERE id_lectura IS NOT NULL)                               AS meses_medidos_con_lectura,
       (SELECT COUNT(*) FROM (SELECT id_reclamo FROM marcados
                               GROUP BY id_reclamo
                              HAVING COUNT(*) > 1) x)                AS reclamos_de_mas_en_marcados,
       (SELECT COUNT(*) FROM (SELECT rr.id_reclamo
                                 FROM tfv_reclamo r
                                 JOIN tfv_respuesta_reclamo rr
                                   ON rr.id_reclamo = r.id_reclamo
                                WHERE r.fecha_hora_reg >= DATE '2026-01-01'
                                  AND r.fecha_hora_reg <  DATE '2026-10-01'
                                GROUP BY rr.id_reclamo
                              HAVING COUNT(*) > 1) y)                AS reclamos_con_varias_respuestas,
       (SELECT COUNT(*) FROM (SELECT rl.id_reclamo
                                 FROM tfv_reclamo r
                                 JOIN tfv_reclamo_lectura rl
                                   ON rl.id_reclamo = r.id_reclamo
                                WHERE r.fecha_hora_reg >= DATE '2026-01-01'
                                  AND r.fecha_hora_reg <  DATE '2026-10-01'
                                GROUP BY rl.id_reclamo
                              HAVING COUNT(*) > 1) z)                AS reclamos_con_varias_lecturas;
