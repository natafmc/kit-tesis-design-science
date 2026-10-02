-- =====================================================================
-- Extracción A2 — ampliación a 2022 y salidas para E7c y E8
-- Base: PostgreSQL. Esquema confirmado por la tesista el 2 oct 2026.
--
-- ADVERTENCIA: consultas escritas sin ejecutar. Ejecutar primero el
-- BLOQUE 0 (verificación) y leer sus resultados antes de cualquier otra.
-- Si el Bloque 0 no devuelve lo esperado, no continuar.
--
-- Tablas confirmadas:
--   tfv_historico_lecturador(id_histo_lecturador, nro_cuenta, lec_actual,
--                            consumo, id_lectura, fecha_lec)
--   tfv_reclamo(id_reclamo, nro_reclamo, nro_cuenta, tipo_reclamo, fecha_hora_reg)
--   tfv_reclamo_lectura(id_reclamo_lectura, id_reclamo, id_lectura, sw_proceso,
--                       importe, lectura_actual, fecha_odeco)
--
-- BLOQUEOS DECLARADOS (ver al final):
--   [B1] Falta la tabla que porta tipo de lectura (0/1/2/3) y código
--        de irregularidad, enlazable por id_lectura.
--   [B2] Falta la tabla que porta la lectura FACTURADA, necesaria para
--        derivar las correcciones manuales.
-- =====================================================================


-- =====================================================================
-- BLOQUE 0 — VERIFICACIÓN. Ejecutar esto primero y leerlo con calma.
-- =====================================================================

-- 0.1 Cobertura temporal de cada tabla
SELECT 'tfv_historico_lecturador' AS tabla,
       MIN(fecha_lec)             AS desde,
       MAX(fecha_lec)             AS hasta,
       COUNT(*)                   AS filas
FROM tfv_historico_lecturador
UNION ALL
SELECT 'tfv_reclamo',
       MIN(fecha_hora_reg),
       MAX(fecha_hora_reg),
       COUNT(*)
FROM tfv_reclamo
UNION ALL
SELECT 'tfv_reclamo_lectura',
       MIN(fecha_odeco),
       MAX(fecha_odeco),
       COUNT(*)
FROM tfv_reclamo_lectura;

-- 0.2 Reclamos por año — ¿realmente llegan a 2022?
SELECT EXTRACT(YEAR FROM fecha_hora_reg)::int AS anio,
       COUNT(*)                               AS reclamos
FROM tfv_reclamo
GROUP BY 1
ORDER BY 1;

-- 0.3 Lecturas por año — ¿el histórico llega a 2022?
SELECT EXTRACT(YEAR FROM fecha_lec)::int AS anio,
       COUNT(*)                          AS lecturas,
       COUNT(DISTINCT nro_cuenta)        AS cuentas
FROM tfv_historico_lecturador
GROUP BY 1
ORDER BY 1;

-- 0.4 PRUEBA DE REPRODUCIBILIDAD contra DATOS.xlsx
--     Esperado: 314 reclamos entre 2025-01 y 2026-09, de los cuales 62 procedentes.
--     IMPORTANTE: puede no coincidir en el primer intento si el filtro original
--     no fue fecha_hora_reg. Si no coincide, no es un error de los datos: es que
--     hay que descubrir con qué fecha y con qué campo de procedencia se contó
--     originalmente. NO publicar hasta cuadrar.
SELECT COUNT(*) AS reclamos_2025_2026
FROM tfv_reclamo
WHERE fecha_hora_reg >= DATE '2025-01-01'
  AND fecha_hora_reg <  DATE '2026-10-01';

-- 0.5 Procedencia: ver qué valores distintos tiene sw_proceso
--     Se espera 1 = procedente, 2 = improcedente, 4 = improcedente administrativo.
SELECT sw_proceso, COUNT(*)
FROM tfv_reclamo_lectura
GROUP BY 1
ORDER BY 1;

SELECT COUNT(*)  AS reclamos_2025_2026,
       COUNT(*) FILTER (WHERE rl.sw_proceso = 1) AS procedentes
FROM tfv_reclamo r
JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
WHERE r.fecha_hora_reg >= DATE '2025-01-01'
  AND r.fecha_hora_reg <  DATE '2026-10-01';
-- Esperado: 314 y 62.


-- =====================================================================
-- A2.1 — RECLAMOS A NIVEL DE REGISTRO (verdad de referencia de E8)
-- Requiere: que cada reclamo permita ubicar cuenta y mes.
-- Confirmado por la tesista el 2 oct 2026: sí.
-- =====================================================================

-- A2.1.a Reclamos con su lectura asociada
SELECT r.id_reclamo,
       r.nro_reclamo,
       r.nro_cuenta,
       r.tipo_reclamo,
       r.fecha_hora_reg,
       DATE_TRUNC('month', r.fecha_hora_reg)::date AS mes_reclamo,
       rl.id_reclamo_lectura,
       rl.id_lectura,
       rl.sw_proceso,
       rl.importe,
       rl.lectura_actual,      -- solo tiene valor cuando es procedente
       rl.fecha_odeco
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
ORDER BY r.fecha_hora_reg;

-- A2.1.b Total de reclamos disponibles como verdad de referencia, por año
SELECT EXTRACT(YEAR FROM r.fecha_hora_reg)::int AS anio,
       COUNT(*)                                 AS reclamos,
       COUNT(*) FILTER (WHERE rl.sw_proceso = 1) AS procedentes,
       COUNT(DISTINCT r.nro_cuenta)              AS cuentas_afectadas
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
GROUP BY 1
ORDER BY 1;

-- A2.1.c [BLOQUEADO por B1] Reclamos por tipo de lectura y procedencia.
--        De aquí sale la cifra 74,19 % (46 de 62 procedentes en Tipo 1).
--        NO EJECUTABLE hasta saber la tabla que porta tipo/código por id_lectura.
-- SELECT EXTRACT(YEAR FROM r.fecha_hora_reg)::int AS anio,
--        rl.sw_proceso,
--        <TABLA_FALTA>.tipo_lectura,
--        COUNT(*)
-- FROM tfv_reclamo r
-- JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
-- JOIN <TABLA_FALTA>        t  ON t.id_lectura  = rl.id_lectura
-- GROUP BY 1, 2, 3;


-- =====================================================================
-- A2.3 — PANEL DE CONSUMO: una fila por cuenta y mes
-- Sin esto no hay detección: las tablas agregadas no permiten calcular
-- desviaciones por cuenta. Volumen estimado ~1,7 millones de filas.
-- =====================================================================

SELECT nro_cuenta,
       DATE_TRUNC('month', fecha_lec)::date AS mes,
       lec_actual,
       consumo,
       id_lectura,
       fecha_lec
FROM tfv_historico_lecturador
WHERE fecha_lec >= DATE '2022-01-01'
ORDER BY nro_cuenta, fecha_lec;


-- =====================================================================
-- A2.4 — AGREGADOS MENSUALES (los tres de DATOS.xlsx, extendidos a 2022)
-- =====================================================================

-- A2.4.1 Lecturas y cuentas por mes
SELECT DATE_TRUNC('month', fecha_lec)::date AS mes,
       COUNT(*)                             AS lecturas,
       COUNT(DISTINCT nro_cuenta)           AS cuentas,
       SUM(consumo)                         AS consumo_total
FROM tfv_historico_lecturador
WHERE fecha_lec >= DATE '2022-01-01'
GROUP BY 1
ORDER BY 1;

-- A2.4.2 Reclamos por mes
SELECT DATE_TRUNC('month', r.fecha_hora_reg)::date AS mes,
       COUNT(*)                                    AS reclamos,
       COUNT(*) FILTER (WHERE rl.sw_proceso = 1)    AS procedentes,
       COUNT(*) FILTER (WHERE rl.sw_proceso <> 1)   AS improcedentes
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
WHERE r.fecha_hora_reg >= DATE '2022-01-01'
GROUP BY 1
ORDER BY 1;

-- A2.4.3 [BLOQUEADO por B2] Correcciones manuales por mes.
--        Vía declarada por la tesista: comparar la lectura facturada contra
--        tfv_historico_lecturador.lec_actual. Falta la tabla de la lectura
--        facturada. Esperado al ejecutarlo: 1 507/mes ene-may 2025,
--        295/mes jun-dic 2025, 242,2/mes en 2026.
-- SELECT DATE_TRUNC('month', <FECHA_FACTURACION>)::date AS mes,
--        COUNT(*)
-- FROM <TABLA_FACTURADA> f
-- JOIN tfv_historico_lecturador h ON h.id_lectura = f.id_lectura  -- clave por confirmar
-- WHERE f.lectura_facturada <> h.lec_actual
--   AND <FECHA_FACTURACION> >= DATE '2022-01-01'
-- GROUP BY 1;


-- =====================================================================
-- CONSULTA 2.3 — TIEMPO DE RESPUESTA EN LA ODECO (pendiente desde E2)
-- Hipótesis: fecha_hora_reg = registro del reclamo,
--            fecha_odeco    = respuesta al ODECO.
-- CONFIRMAR el significado de fecha_odeco antes de publicar el resultado.
-- =====================================================================

SELECT EXTRACT(YEAR FROM r.fecha_hora_reg)::int AS anio,
       COUNT(*)                                 AS reclamos,
       ROUND(AVG(rl.fecha_odeco - r.fecha_hora_reg), 1)          AS dias_promedio,
       ROUND(MAX(rl.fecha_odeco - r.fecha_hora_reg)::numeric, 0)  AS dias_maximo,
       COUNT(*) FILTER (WHERE rl.fecha_odeco - r.fecha_hora_reg > 15) AS fuera_de_plazo_15d
FROM tfv_reclamo r
JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
WHERE rl.fecha_odeco IS NOT NULL
GROUP BY 1
ORDER BY 1;


-- =====================================================================
-- BLOQUEOS
--
-- [B1] FALTA LA TABLA DEL TIPO DE LECTURA Y EL CÓDIGO DE IRREGULARIDAD.
--      tfv_historico_lecturador y tfv_reclamo_lectura comparten id_lectura,
--      pero ninguna de las dos trae el tipo de lectura (0/1/2/3) ni el
--      código de irregularidad. Sin ella NO se puede reproducir el
--      indicador 1 de E6 (46 de 62 = 74,19 %) ni la segmentación por
--      familia de código que exige la Opción 2.
--      Pregunta: ¿qué tabla guarda tipo y código, y se enlaza por id_lectura?
--
-- [B2] FALTA LA TABLA DE LA LECTURA FACTURADA.
--      Sin ella no se derivan las ~242,2 correcciones mensuales y el
--      criterio de carga queda sin línea base reproducible.
--      Pregunta: ¿en qué tabla está la lectura que se factura, y cuál es
--      su clave contra tfv_historico_lecturador?
--
-- [B3] CONFIRMAR si sw_proceso es el campo de procedencia que en la
--      extracción de DATOS.xlsx apareció como sw_procedente (1/2/4).
-- =====================================================================
