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
--   tfv_codigo_irregular(id_cod_irre, desc_cod_irre, sw_aviso, estado,
--                        codigo, tipo_lectura)          <- A2, 6 oct 2026
--   tfv_lectura(tipo_lectura)                           <- 0.6, 7 oct 2026 (DEC-36)
--   tfv_lec_irregular(id_cod_irre)                      <- 0.6, 7 oct 2026 (DEC-36)
--
-- BLOQUEOS DECLARADOS (ver al final):
--   [B1] RESUELTO el 7 oct 2026 por el resultado del 0.6, CORREGIDO el
--        mismo día por la tesista (DEC-36):
--        · tipo_lectura POR LECTURA: esta en tfv_lectura, por id_lectura.
--          -> A2.1.c DESBLOQUEADO y escrito sin placeholders.
--        · id_cod_irre POR LECTURA: esta en tfv_lec_irregular, por
--          id_lectura. -> 0.7.b ESCRITO y ejecutable; quedan pendientes
--          de correr sus DOS CONTROLES antes de dar nada por bueno.
--   [B2] LA TABLA CANDIDATA EXISTE — 0.6.d ejecutado 9 oct 2026 (DEC-39):
--        tfv_cobranza, 34 columnas, con id_lectura NOT NULL, consumo,
--        periodo_fac y gestion_fac. Quedan tres cosas que el esquema no
--        dice y que resuelve el 0.6.e. A2.4.3 sigue bloqueado hasta
--        entonces: NO se rellenan sus placeholders todavía.
--   [B5] La tesista declaró el 6 oct 2026 que tipo_lectura = 1 es lectura
--        SIN código de irregularidad (DEC-30), y con eso se publicaron
--        0,88 % y 99,12 %. El 0.7.b es la CONFIRMACIÓN con dato, no un
--        prerequisito: si lo impugna, se suspenden las cifras y se
--        vuelve a ENDE. Si las confirma, la salvedad de DEC-30 se cierra.
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

-- 0.6 DESCUBRIMIENTO DEL ESQUEMA — RESUELTO el 7 oct 2026 (DEC-36)
--     Resultado de la tesista, 7 oct 2026:
--       · tfv_lec_irregular contiene id_cod_irre
--       · tfv_lectura contiene tipo_lectura
--     La consulta sigue aquí para que el descubrimiento sea reproducible.
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND ( column_name ILIKE '%tipo_lect%'
     OR column_name ILIKE '%irreg%'
     OR column_name ILIKE '%id_cod_irre%' )
ORDER BY table_name, ordinal_position;

-- 0.6.b Qué tablas se enlazan por id_lectura — para ubicar la de lecturas
--     Resultado 7 oct 2026 (DEC-36), CORREGIDO el mismo día por la tesista:
--       tfv_lectura, tfv_cobranza, tfv_historico_lecturador,
--       tfv_lec_irregular, tfv_reclamo_lectura
--     La primera respuesta omitía tfv_lec_irregular y tfv_reclamo_lectura.
--     Se deja anotado porque importa: la lista incompleta NO permitía
--     deducir nada, y estuvo bien no rellenar con ella el ON de 0.7.b.
--     Ahora sí queda cerrada la clave de enlace: id_lectura.
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND column_name ILIKE '%lectura%'
ORDER BY table_name, ordinal_position;

-- 0.6.c COLUMNAS DE tfv_lectura Y tfv_lec_irregular — DIAGNÓSTICO
--     Ya NO bloquea al 0.7.b: la clave de enlace quedó confirmada el
--     7 oct 2026 con el 0.6.b corregido — id_lectura—, y 0.7.b está escrito
--     más abajo. Esta query queda por dos cosas que siguen interesando:
--       (a) si tfv_lectura trae nro_cuenta —para contar cuentas distintas—
--           y si trae alguna fecha, para poder recortar la ventana;
--       (b) qué más trae tfv_lec_irregular, sobre todo columnas que puedan
--           duplicar filas por reclamo, cobranza o histórico.
SELECT table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND table_name IN ('tfv_lec_irregular', 'tfv_lectura')
ORDER BY table_name, ordinal_position;

-- 0.6.d CANDIDATA A LECTURA FACTURADA — levanta [B2]
--     El 0.6.b devolvió tfv_cobranza entre las tablas enlazables por
--     id_lectura. Es la candidata natural a <TABLA_FACTURADA> de A2.4.3,
--     pero todavía no se ha escrito ninguna de sus columnas: se mira aquí
--     antes de tocar A2.4.3.
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND table_name = 'tfv_cobranza'
ORDER BY ordinal_position;


-- 0.6.e QUÉ TRAE tfv_cobranza — para decidir si levanta [B2] (9 oct 2026)
--     El 0.6.d devolvió 34 columnas. Las que interesan para A2.4.3:
--       · id_lectura   bigint   NOT NULL -> clave contra tfv_historico_lecturador
--       · nro_cuenta   integer  NOT NULL
--       · consumo      numeric  NOT NULL -> candidata a lectura facturada
--       · periodo_fac  numeric  NOT NULL
--       · gestion_fac  numeric  NOT NULL -> fecha de facturacion (no es timestamp)
--     LA PREGUNTA DE [B2] QUEDA RESPONDIDA EN DOS DE SUS TRES PARTES:
--       · la tabla existe y su clave ES id_lectura                -> SI
--       · su columna de fecha NO es un timestamp: es gestion_fac
--         + periodo_fac. OJO: los cinco timestamps de la tabla —
--         fecha_emitida, emision_fecha, fecha_anulada, fecha_pago,
--         pago_fecha— son TODOS anulables, por eso no sirven como eje
--         de agrupacion; periodo_fac y gestion_fac son NOT NULL.
--     LO QUE EL ESQUEMA NO PUEDE DECIR, Y NO SE DEDUCE:
--       (a) si tfv_cobranza.consumo es la lectura CORREGIDA o una copia
--           desnormalizada de tfv_historico_lecturador.consumo. A2.4.3
--           compara contra lec_actual, pero tfv_cobranza NO trae
--           columna de lectura: trae consumo. Si las dos columnas
--           consumo son iguales siempre, esta via NO sirve;
--       (b) si una lectura genera UNA o VARIAS cobranzas — fecha_anulada,
--           id_nota, sw_nota, obs_fac_saltada y cant_imprime sugieren
--           varias—. Si son varias, el JOIN multiplica filas y multiplica
--           tambien las correcciones;
--       (c) si la tabla cubre 2022-2026.
--     Tres preguntas, tres queries. Correrlas ANTES de escribir A2.4.3.

-- 0.6.e.1 Cardinalidad, ventana temporal e integridad
SELECT COUNT(*)                                            AS filas,
       COUNT(DISTINCT id_lectura)                          AS lecturas,
       COUNT(*) - COUNT(DISTINCT id_lectura)               AS filas_de_mas,
       MIN(gestion_fac)                                    AS gestion_min,
       MAX(gestion_fac)                                    AS gestion_max,
       MIN(periodo_fac)                                    AS periodo_min,
       MAX(periodo_fac)                                    AS periodo_max,
       COUNT(*) FILTER (WHERE fecha_anulada IS NOT NULL)   AS anuladas,
       COUNT(*) FILTER (WHERE id_factura IS NULL)          AS sin_factura,
       COUNT(*) FILTER (WHERE consumo IS NULL)             AS consumo_nulo
FROM tfv_cobranza;
-- Si filas = lecturas, tfv_cobranza es 1:1 con la lectura y el JOIN de
-- A2.4.3 es seguro. Si no, hay que agregar antes de cruzar.

-- 0.6.e.2 Dominios de las columnas cortas — estado_fac y los sw_*
SELECT 'estado_fac'   AS columna, estado_fac::text   AS valor, COUNT(*) AS filas FROM tfv_cobranza GROUP BY 2
UNION ALL SELECT 'sw_odeco',    sw_odeco,          COUNT(*) FROM tfv_cobranza GROUP BY 2
UNION ALL SELECT 'sw_contafac', sw_contafac,       COUNT(*) FROM tfv_cobranza GROUP BY 2
UNION ALL SELECT 'sw_nota',     sw_nota,           COUNT(*) FROM tfv_cobranza GROUP BY 2
UNION ALL SELECT 'cant_imprime', cant_imprime::text, COUNT(*) FROM tfv_cobranza GROUP BY 2
ORDER BY 1, 2;

-- 0.6.e.3 LA PRUEBA — ¿tfv_cobranza.consumo difiere de lo leído?
--     OJO antes de correrla: si el 0.6.e.1 da filas <> lecturas en
--     tfv_cobranza, o si tfv_historico_lecturador tiene varios id_lectura
--     repetidos, este JOIN multiplica y el conteo NO vale. Mirar eso primero.
--     Si sale TODO en 'iguales', consumo es copia desnormalizada y ESTA VIA
--     NO SIRVE para derivar correcciones: habría que buscar la lectura
--     facturada en otra parte.
--     Si sale 'distintos' > 0, esas diferencias son el CANDIDATO a
--     corrección manual, y habría que cuadrarlas contra la hoja historico
--     de `DATOS desde 2022.xlsx`: 9 604 en 2025 y 2 180 en 2026.
SELECT CASE WHEN h.consumo = c.consumo THEN 'iguales'
            WHEN h.consumo IS NULL     THEN 'historico nulo'
            WHEN c.consumo  IS NULL     THEN 'cobranza nulo'
            ELSE 'distintos' END                        AS comparacion,
       COUNT(*)                                         AS lecturas
FROM tfv_cobranza c
LEFT JOIN tfv_historico_lecturador h ON h.id_lectura = c.id_lectura
GROUP BY 1
ORDER BY 1;


-- 0.7 EL CATÁLOGO DE IRREGULARIDADES — nombre confirmado por la tesista 6 oct 2026
--     Fuente externa: CODIGOS_IRREGULARES.xlsx (6 oct 2026, 10 169 bytes),
--     hoja codigo_irregular, encabezados en fila 1, 48 filas, id 0 a 47.
--     Debe reproducirse tal cual.
SELECT COUNT(*) AS codigos FROM tfv_codigo_irregular;
-- Esperado: 48

SELECT tipo_lectura, COUNT(*) AS codigos, MIN(id_cod_irre) AS id_min, MAX(id_cod_irre) AS id_max
FROM tfv_codigo_irregular
GROUP BY 1 ORDER BY 1;
-- Esperado: tipo 0 -> 4, tipo 1 -> 30, tipo 2 -> 6, tipo 3 -> 8; ids 0 y 47.

SELECT sw_aviso, COUNT(*) AS codigos
FROM tfv_codigo_irregular
GROUP BY 1 ORDER BY 1;
-- Esperado: no -> 16, si -> 32.

SELECT estado, COUNT(*) AS codigos
FROM tfv_codigo_irregular
GROUP BY 1 ORDER BY 1;
-- Esperado: estado 1 -> 48 (todos activos).


-- 0.7.b LA CONSULTA QUE CIERRA B5 CON DATO Y NO CON INTERPRETACIÓN
--     Declaración de la tesista, 6 oct 2026:
--       «Los datos de DATOS.xlsx con lecturas tipo_lectura=1 son lecturas
--        SIN código irregular. La lista de códigos irregulares es la lista
--        que manda la AETN.»
--     El catálogo, en cambio, asocia 29 códigos reales (44 SOSPECHA DE ROBO,
--     37 USUARIO CLANDESTINO, 25 PUENTE BAJO, ...) a tipo_lectura = 1.
--     Publicadas por DEC-30 (declaración de la tesista, 6 oct 2026).
--     Este cruce las confirma o las impugna con dato:
--       · si TODA lectura tipo 1 tiene el código en NULL o 0 -> la
--         declaración queda confirmada empíricamente y la salvedad
--         de DEC-30 se cierra;
--       · si HAY lecturas tipo 1 con id_cod_irre > 0 -> se SUSPENDEN
--         0,88 % y 99,12 % y se vuelve a ENDE antes de publicar nada.
--     Esquema confirmado el 7 oct 2026 (DEC-36): tipo_lectura vive en
--     tfv_lectura y el id_cod_irre por lectura vive en tfv_lec_irregular,
--     y AMBAS enlazan por id_lectura —0.6.b corregido el mismo día por la
--     tesista—. Con eso la consulta queda ESCRITA, sin placeholders.
--     NO SE HA EJECUTADO TODAVÍA: leer los dos controles de abajo antes
--     de dar nada por bueno.
--
--     Diseño: la agrupación va en una CTE para que cada lectura entre UNA
--     sola vez. Si tfv_lec_irregular trae varios códigos por lectura, un
--     LEFT JOIN directo multiplicaría filas y DISTORSIONARÍA exactamente
--     los porcentajes que esta consulta viene a verificar.
--
WITH cod AS (
    SELECT id_lectura,
           MAX(id_cod_irre) AS codigo_max,   -- > 0 = código real
           COUNT(*)         AS n_filas       -- control de cardinalidad
    FROM tfv_lec_irregular
    GROUP BY id_lectura
)
SELECT l.tipo_lectura,
       CASE WHEN c.id_lectura IS NULL THEN 'sin codigo'
            WHEN c.codigo_max  = 0    THEN 'codigo 0'
            ELSE 'codigo real'              END AS estado_codigo,
       COUNT(*)                                AS lecturas
FROM tfv_lectura l
LEFT JOIN cod c ON c.id_lectura = l.id_lectura
GROUP BY 1, 2
ORDER BY 1, 2;

-- CONTROL 1 — cardinalidad. La CTE ya absorbe el caso 1:N, pero hay que
-- saberlo y ANOTARLO, porque cambia cómo se lee el resultado.
SELECT MAX(n_filas)                   AS max_codigos_por_lectura,
       COUNT(*) FILTER (WHERE n_filas > 1) AS lecturas_con_varios
FROM ( SELECT id_lectura, COUNT(*) AS n_filas
       FROM tfv_lec_irregular
       GROUP BY id_lectura ) x;
-- Si max_codigos_por_lectura = 1, tfv_lec_irregular es 1:1 con la lectura.

-- CONTROL 2 — reproducción de las cifras ya publicadas.
--     Si tfv_lectura cubre exactamente ene 2022 – sep 2026, estos totales
--     DEBEN cuadrar con la hoja tipo_lectura de `DATOS desde 2022.xlsx`:
--       tipo 0 -> 177 784 · tipo 1 -> 1 377 641 · tipo 2+3 -> 12 300
--       facturable (1+2+3) -> 1 389 941 · total -> 1 567 725
SELECT tipo_lectura, COUNT(*) AS lecturas
FROM tfv_lectura
GROUP BY 1
ORDER BY 1;
-- Si no cuadra: PRIMERO se mira la ventana —¿trae tfv_lectura fecha, y
-- cubre esos 57 meses? es lo que responde el 0.6.c— y solo después se
-- cuestiona la cifra publicada. Si cuadra, 0,88 % y 99,12 % quedan
-- reproducidos desde la base de datos y no solo desde la hoja de cálculo.


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

-- A2.1.c Reclamos por tipo de lectura y procedencia. [DESBLOQUEADO 7 oct 2026]
--        De aquí sale la cifra 74,19 % (46 de 62 procedentes en Tipo 1),
--        y con 57 meses su equivalente 78,16 % (136 de 174).
--        La tabla era tfv_lectura: confirmada por el 0.6 el 7 oct 2026 (DEC-36),
--        y el 0.6.b la lista entre las enlazables por id_lectura.
--        El catálogo tfv_codigo_irregular NO sirve para esto: es el
--        diccionario de códigos, no el dato por lectura.
--        Si el 0.6.c devolviera el id_lectura de tfv_lectura con otro nombre,
--        se ajusta SOLO el ON de esta consulta.
SELECT EXTRACT(YEAR FROM r.fecha_hora_reg)::int AS anio,
       rl.sw_proceso,
       t.tipo_lectura,
       COUNT(*)                                  AS reclamos
FROM tfv_reclamo r
JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
JOIN tfv_lectura        t   ON t.id_lectura  = rl.id_lectura
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;
-- Esperado: en 57 meses, 174 procedentes de los cuales 136 en tipo 1 (78,16 %);
-- en la ventana 2025+2026, 62 procedentes de los cuales 46 en tipo 1 (74,19 %).
-- Si no cuadra, el error está en esta consulta, no en la cifra publicada.


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
-- [B1] RESUELTO el 7 oct 2026 con el 0.6, CORREGIDO el mismo día (DEC-36).
--      · tipo de lectura POR LECTURA: ESTÁ en tfv_lectura, por id_lectura.
--        A2.1.c DESBLOQUEADO y escrito sin placeholders — es el indicador 1
--        de E6: 136 de 174 = 78,16 % en 57 meses, y 46 de 62 = 74,19 % en
--        la ventana 2025+2026.
--      · id_cod_irre POR LECTURA: ESTÁ en tfv_lec_irregular, y su clave de
--        enlace ES id_lectura — confirmado con el 0.6.b corregido—. 0.7.b
--        queda ESCRITO y ejecutable.
--      Lo que falta ya no es esquema: es EJECUCIÓN. Correr 0.7.b y sus DOS
--      CONTROLES. Control 1, cardinalidad de tfv_lec_irregular —si una
--      lectura admite varios códigos, la CTE del 0.7.b ya lo absorbe, pero
--      hay que anotarlo—. Control 2, reproducción desde la base de
--      0,88 % y 99,12 %: 177 784 · 1 377 641 · 12 300 · 1 389 941 · 1 567 725.
--      Hasta que los dos controles cuadren, la salvedad de DEC-30 sigue
--      abierta y ninguna de las dos cifras se republica.
--
-- [B2] LA TABLA CANDIDATA EXISTE — 0.6.d EJECUTADO EL 9 OCT 2026 (DEC-39).
--      tfv_cobranza tiene 34 columnas, entre ellas:
--        id_lectura   bigint   NOT NULL -> SI es la clave contra
--                                          tfv_historico_lecturador
--        nro_cuenta   integer  NOT NULL
--        consumo      numeric  NOT NULL -> candidata a lectura facturada
--        periodo_fac  numeric  NOT NULL
--        gestion_fac  numeric  NOT NULL -> fecha de facturacion: NO es un
--                                          timestamp, es año + periodo
--      La pregunta de arriba queda respondida en DOS de sus TRES partes.
--      LO QUE EL ESQUEMA NO PUEDE DECIR, y por eso no se rellena todavía
--      <TABLA_FACTURADA> ni <FECHA_FACTURACION>:
--        (a) si tfv_cobranza.consumo es la lectura CORREGIDA o una copia
--            desnormalizada de tfv_historico_lecturador.consumo. A2.4.3
--            compara contra lec_actual, pero tfv_cobranza NO trae columna
--            de lectura: trae consumo;
--        (b) si una lectura genera UNA o VARIAS cobranzas — fecha_anulada,
--            id_nota, sw_nota y obs_fac_saltada sugieren varias—;
--        (c) si la tabla cubre 2022-2026.
--      Lo resuelve el 0.6.e (tres queries, ver arriba). Hasta entonces
--      A2.4.3 SIGUE BLOQUEADO. Regla que ya valió en DEC-36: con una lista
--      de esquema incompleta no se deduce nada y se pregunta.
--      NOTA: en `00_estado.md` B2 aparece como cerrado el 5 oct (DEC-24),
--      pero allí se cerró por los AGREGADOS — 242,2 = 2 180/9 y 800,3 =
--      9 604/12, reproducibles desde la hoja historico—. Lo que sigue
--      abierto es el nivel de REGISTRO, que es lo que pide A2.4.3.
--
-- [B3] CONFIRMAR si sw_proceso es el campo de procedencia que en la
--      extracción de DATOS.xlsx apareció como sw_procedente (1/2/4).
-- =====================================================================
