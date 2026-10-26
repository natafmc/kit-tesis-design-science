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

-- 0.5 Dominio de sw_proceso: ver qué valores distintos tiene.
--     [EXPECTATIVA FALSADA 22 oct 2026, DEC-59]: aquí se esperaba
--     1 = procedente, 2 = improcedente, 4 = improcedente administrativo,
--     que es el dominio de la columna sw_procendente DE LA HOJA. NO ES
--     ESTE CAMPO: sw_proceso devolvió 'si'/'no' —binario— y un 'no' no
--     puede representar a la vez al 2 y al 4. Además tfv_reclamo no tiene
--     sw_procendente (CONTROL 5.d). Proceso y procedente se confunden.
SELECT sw_proceso, COUNT(*)
FROM tfv_reclamo_lectura
GROUP BY 1
ORDER BY 1;

SELECT COUNT(*)  AS reclamos_2025_2026,
       COUNT(*) FILTER (WHERE rl.sw_proceso = 1) AS sw_proceso_si
FROM tfv_reclamo r
JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
WHERE r.fecha_hora_reg >= DATE '2025-01-01'
  AND r.fecha_hora_reg <  DATE '2026-10-01';
-- [EXPECTATIVA RETRACTADA 22 oct 2026, DEC-59]: decía "Esperado: 314 y 62".
-- El 314 es un conteo de reclamos y puede reproducirse; el 62 venía de
-- sw_procendente, campo que NO EXISTE en tfv_reclamo ni en
-- tfv_reclamo_lectura (CONTROL 5.d). sw_proceso='si' es OTRO campo y
-- no se publica como procedentes.

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


-- 0.6.f CORRECCIÓN DEL 0.6.e.3 - EL JOIN MULTIPLICÓ (20 oct 2026)
--     El 0.6.e.3 corrió el 20 oct 2026 y devolvió:
--         distintos 29 786 | historico nulo 44 732 | iguales 1 316 140
--     Suma: 1 390 658. Pero tfv_cobranza tiene 1 389 282 filas, de modo
--     que SOBRAN 1 376 filas. Sobran porque tfv_historico_lecturador
--     trae id_lectura repetidos y el LEFT JOIN los multiplica: es
--     exactamente la advertencia escrita en el propio 0.6.e.3, que se
--     cumplió. CONSECUENCIA: EL RESULTADO ANTERIOR NO SE PUEDE
--     INTERPRETAR. Ningún número de ahí sale a ningún documento.
--
--     Dos datos de ese resultado SÍ son fiables, porque un LEFT JOIN
--     sin match no se multiplica:
--       · 44 732 lecturas de cobranza (3,22 %) no tienen fila en
--         tfv_historico_lecturador.
--       · Las 1 376 filas de más caen TODAS en 'distintos', que es la
--         firma de un id_lectura repetido con consumo DIFERENTE, es
--         decir de una corrección. PERO ESO ES UNA SOSPECHA: hay que
--         confirmarlo con el CONTROL 3 antes de publicarlo.
--
--     Dato aritmético declarado y NO publicado: si el JOIN no
--     multiplicara, 'distintos' sería
--     1 389 282 − 1 316 140 − 44 732 = 28 410. Es una derivación con
--     supuesto —cada lectura repetida aporta una sola fila de más—,
--     de modo que se confirma con el CONTROL 4.

-- CONTROL 3 - cardinalidad de tfv_historico_lecturador
--     Mismo diseño que el CONTROL 1, aplicado a la tabla que multiplicó.
--     Debe dar filas − lecturas = 1 376. Si no da eso, el problema no
--     era el JOIN y hay que revisar antes de seguir.
--
--     ****************************************************************
--     ADVERTENCIA, 25 OCT 2026: ESTA CONSULTA NO PUEDE DAR LO QUE
--     DEC-50 REPORTÓ. Ver CONTROL 3.b, más abajo.
--
--     La subconsulta agrupa POR id_lectura ANTES de contar, así que en
--     x ya hay una fila por lectura y las dos primeras columnas salen
--     iguales: filas = COUNT(*) sobre grupos = número de id_lectura, y
--     lecturas = COUNT(DISTINCT id_lectura) = lo mismo. filas_de_mas
--     queda en 0, o en 1 si hay id nulo.
--
--     DEC-50 reportó filas 1 491 175, lecturas 1 489 791 y filas_de_mas
--     1 384: ESAS TRES NO SALEN DE AQUÍ.
--
--     NO SE MODIFICA NI SE BORRA: la corrida ya ocurrió y su resultado
--     está registrado. Se corrige el control al lado.
--     ****************************************************************
SELECT COUNT(*)                                            AS filas,
       COUNT(DISTINCT id_lectura)                          AS lecturas,
       COUNT(*) - COUNT(DISTINCT id_lectura)               AS filas_de_mas,
       MAX(n)                                              AS max_filas_por_lectura,
       COUNT(*) FILTER (WHERE n > 1)                       AS lecturas_repetidas,
       COUNT(*) FILTER (WHERE n > 1 AND consumo_distinto > 1)
                                                           AS repetidas_con_consumo_variado
FROM ( SELECT id_lectura,
              COUNT(*)                AS n,
              COUNT(DISTINCT consumo) AS consumo_distinto
       FROM tfv_historico_lecturador
       GROUP BY id_lectura ) x;


-- =====================================================================
-- CONTROL 3.b - LA VERSION CORREGIDA: MIDE LA TABLA EN BRUTO
--                                  (25 oct 2026)
--
--     QUE FALLABA. El CONTROL 3 agrupa y luego cuenta los grupos, de
--     modo que su columna `filas` no es el numero de filas de la tabla
--     sino el numero de lecturas distintas. Su propio comentario dice
--     "Debe dar filas - lecturas = 1 376", que es un resultado SOLO
--     posible contando la tabla en bruto. La consulta no puede dar lo
--     que su comentario espera.
--
--     POR QUE LAS CIFRAS DE DEC-50 SI SON COHERENTES ENTRE SI. Leidas
--     como conteo de la tabla en bruto: 1 489 791 + 1 384 = 1 491 175,
--     y "ninguna mas de dos veces" es exactamente lo que hace esa suma.
--     De las seis columnas del CONTROL 3, dos SI salen bien sobre
--     grupos -`lecturas_repetidas` = 1 384 y
--     `repetidas_con_consumo_variado` = 1 261- y por eso coinciden. Lo
--     probable es que la corrida del 20 oct usara otra consulta y la
--     del archivo se haya escrito despues. NO SE REESCRIBE LA
--     HISTORIA: se declara la diferencia y se corrige el control.
--
--     AUTOCHEQUEO 1: filas = lecturas + filas_de_mas. Por construccion.
--     AUTOCHEQUEO 2: si ninguna lectura se repite mas de dos veces,
--         filas_de_mas DEBE ser igual a lecturas_repetidas. Si difieren,
--         hay lecturas repetidas mas de dos veces y DEC-50(1) se reabre.
--     AUTOCHEQUEO 3: sin_id_lectura debe ser 0. Si no lo es, hay filas
--         sin clave y filas_de_mas las contaria como extra por error.
--     AUTOCHEQUEO 4: ESTA CORRIDA NO ES REPRODUCIBLE EN EL TIEMPO.
--         LA TABLA ES VIVA -confirmado por la tesista el 25 oct 2026:
--         la lecturacion de octubre se esta cargando ahora-, de modo
--         que `filas` sin filtro de fecha CAMBIA CADA DIA. TODA CORRIDA
--         LLEVA SU FECHA y toda cifra publicada tambien.
-- =====================================================================
SELECT (SELECT COUNT(*)                     FROM tfv_historico_lecturador) AS filas,
       (SELECT COUNT(DISTINCT id_lectura)   FROM tfv_historico_lecturador) AS lecturas,
       (SELECT COUNT(*)                     FROM tfv_historico_lecturador)
         - (SELECT COUNT(DISTINCT id_lectura)
              FROM tfv_historico_lecturador)                               AS filas_de_mas,
       (SELECT COUNT(*) FROM tfv_historico_lecturador
         WHERE id_lectura IS NULL)                                         AS sin_id_lectura,
       MAX(x.n)                                                            AS max_filas_por_lectura,
       COUNT(*) FILTER (WHERE x.n > 1)                                     AS lecturas_repetidas,
       COUNT(*) FILTER (WHERE x.n > 1 AND x.consumo_distinto > 1)          AS repetidas_con_consumo_variado
FROM ( SELECT id_lectura,
              COUNT(*)                AS n,
              COUNT(DISTINCT consumo) AS consumo_distinto
       FROM tfv_historico_lecturador
       GROUP BY id_lectura ) x;

-- CONTROL 4 - LA PRUEBA CORREGIDA, SIN MULTIPLICAR
--     h se deduplica por id_lectura ANTES del JOIN, de modo que cada
--     fila de tfv_cobranza entra UNA sola vez y el total DEBE salir
--     exactamente 1 389 282. Si no sale esa cifra, esta consulta tampoco
--     vale y hay que volver al CONTROL 3.
WITH h AS (
    SELECT id_lectura,
           COUNT(*)                AS n_filas,
           COUNT(DISTINCT consumo) AS consumo_distinto,
           MAX(consumo)            AS consumo_max
    FROM tfv_historico_lecturador
    GROUP BY id_lectura
)
SELECT CASE WHEN h.id_lectura IS NULL       THEN 'sin historico'
            WHEN h.consumo_distinto > 1     THEN 'historico con consumo variado'
            WHEN h.consumo_max <> c.consumo THEN 'distintos'
            ELSE 'iguales' END                AS comparacion,
       COUNT(*)                               AS lecturas
FROM tfv_cobranza c
LEFT JOIN h ON h.id_lectura = c.id_lectura
GROUP BY 1
ORDER BY 1;
-- AUTOCHEQUEO OBLIGATORIO: la suma de las cuatro categorías DEBE dar
-- 1 389 282. Si no cuadra, no se interpreta nada.
--
-- Si 'historico con consumo variado' da > 0, ESAS son las lecturas que
-- tienen más de un consumo registrado: el candidato a corrección manual
-- A NIVEL DE REGISTRO, que es lo que [B2] necesita para abrir A2.4.3.
-- Antes de publicar esa cifra hay que buscarla por año y cuadrarla
-- contra la hoja historico de `DATOS desde 2022.xlsx`: 9 604 en 2025 y
-- 2 180 en 2026. Si no cuadra, NO se publica.

-- 0.6.g LA PRUEBA POR AÑO - el contraste final contra la hoja (20 oct 2026)
--     El CONTROL 4 (L347) midió: distintos 28 499, con consumo variado 1 259,
--     iguales 1 314 620, sin historico 44 904. Suma 1 389 282, que cuadra
--     exacto, de modo que la consulta no multiplicó.
--     LO DECISIVO: NO SALIÓ TODO EN 'IGUALES'. Solo 94,63 % salió igual, de
--     modo que `tfv_cobranza.consumo` NO es copia desnormalizada y ESTA VIA
--     ESTA VIVA, que era el escenario en que el archivo decía que no servía.
--     Quedan 29 758 lecturas candidatas (2,14 %) contra 47 982 de la hoja
--     (3,22 %): mismo orden de magnitud, factor 1,61, pero NO coinciden.
--     El contraste que falta es POR AÑO, contra 9 604 en 2025 y 2 180 en 2026.
--
--     SALVEDAD DECLARADA ANTES DE CORRER: `gestion_fac` es el año de FACTURACIÓN
--     y la hoja `historico` agrupa por período de LECTURA. Pueden no coincidir,
--     y si no coinciden la diferencia no es un error sino una diferencia de
--     llave. Eso se declara y se comprueba, no se supone.

-- 0.6.g.1 - el cruce completo por año
WITH h AS (
    SELECT id_lectura,
           COUNT(*)                AS n_filas,
           COUNT(DISTINCT consumo) AS consumo_distinto,
           MAX(consumo)            AS consumo_max
    FROM tfv_historico_lecturador
    GROUP BY id_lectura
)
SELECT c.gestion_fac                        AS gestion,
       CASE WHEN h.id_lectura IS NULL       THEN 'sin historico'
            WHEN h.consumo_distinto > 1     THEN 'historico con consumo variado'
            WHEN h.consumo_max <> c.consumo THEN 'distintos'
            ELSE 'iguales' END              AS comparacion,
       COUNT(*)                             AS lecturas
FROM tfv_cobranza c
LEFT JOIN h ON h.id_lectura = c.id_lectura
GROUP BY 1, 2
ORDER BY 1, 2;
-- AUTOCHEQUEO: la suma de TODA la tabla debe dar 1 389 282. Si no cuadra,
-- esta consulta tampoco vale y hay que volver al CONTROL 4.

-- 0.6.g.2 - el total de candidatos por año, listo para comparar de un vistazo
WITH h AS (
    SELECT id_lectura,
           COUNT(DISTINCT consumo) AS consumo_distinto,
           MAX(consumo)            AS consumo_max
    FROM tfv_historico_lecturador
    GROUP BY id_lectura
)
SELECT c.gestion_fac                                        AS gestion,
       COUNT(*)                                             AS lecturas,
       COUNT(*) FILTER (WHERE h.consumo_distinto > 1
                          OR h.consumo_max <> c.consumo)    AS candidatos_a_correccion,
       COUNT(*) FILTER (WHERE h.id_lectura IS NULL)         AS sin_historico
FROM tfv_cobranza c
LEFT JOIN h ON h.id_lectura = c.id_lectura
GROUP BY 1
ORDER BY 1;
-- COMPARAR contra la hoja `historico` de `DATOS desde 2022.xlsx`:
--     2022  8 509   2023 10 230   2024 17 459   2025 9 604   2026 2 180
--     Total hoja 47 982. Total de registro 29 758. NO CUADRAN y eso se
--     declara. Lo que se busca aquí es el PATRÓN POR AÑO, no la igualdad.
--     Si el patrón tampoco se parece, la vía cierra y la hoja queda como
--     única fuente de las correcciones, con su linaje ya declarado.

-- 0.6.g.3 POR AÑO DE LECTURA - la llave declarada, no la de facturacion (21 oct 2026)
--     El 0.6.g.2 (L417) agrupo por `gestion_fac`, que es el anio de FACTURACION.
--     La hoja `historico` agrupa por periodo de LECTURA. Esa diferencia de llave
--     quedo declarada ANTES de correr, y este bloque es su comprobacion.
--     No se supone: se mide.
--
--     SALVEDAD SOBRE LA ELECCION: una lectura repetida puede tener dos
--     `fecha_lec` distintas -la original y la de la correccion-. Se toma MIN,
--     porque la correccion pertenece al periodo de la LECTURA ORIGINAL, que es
--     como agrupa la hoja. Es una eleccion y se declara, no es un dato.
--
--     AUTOCHEQUEO: la suma de `lecturas_con_historico` mas el `sin historico`
--     del 0.6.g.2 debe dar 1 389 282 (la cifra autorizada del CONTROL 4).
--     ATENCION: el 0.6.g.2 sumo 1 389 283, una fila de mas en `sin historico`.
--     Esa fila se identifica antes de publicar cualquier total.
WITH h AS (
    SELECT id_lectura,
           MIN(fecha_lec)           AS fecha_lectura,
           COUNT(DISTINCT consumo)  AS consumo_distinto,
           MAX(consumo)             AS consumo_max
    FROM tfv_historico_lecturador
    GROUP BY id_lectura
)
SELECT EXTRACT(YEAR FROM h.fecha_lectura)      AS anio_lectura,
       COUNT(*)                                 AS lecturas_con_historico,
       COUNT(*) FILTER (WHERE h.consumo_distinto > 1
                          OR h.consumo_max <> c.consumo) AS candidatos
FROM tfv_cobranza c
JOIN h ON h.id_lectura = c.id_lectura
GROUP BY 1
ORDER BY 1;

-- 0.6.g.4 ¿CUANTA DISTANCIA HAY ENTRE AÑO DE LECTURA Y AÑO DE FACTURACION?
--     Esta es la diagnostica de la llave. Si las dos llaves coinciden, la masa
--     esta en la DIAGONAL y entonces el desacople del 0.6.g.2 NO se explica por
--     la llave, sino que las dos mediciones son distintas de verdad.
--     Si hay masa FUERA de la diagonal, la diferencia de llave si explica el
--     desacople y el 0.6.g.2 se vuelve a correr con la llave correcta.
--     Las dos salidas se leen juntas: esta consulta dice SI la llave explica
--     el desacople, y la anterior dice cuanto cambia el patron al usarla.
WITH h AS (
    SELECT id_lectura, MIN(fecha_lec) AS fecha_lectura
    FROM tfv_historico_lecturador
    GROUP BY id_lectura
)
SELECT EXTRACT(YEAR FROM h.fecha_lectura) AS anio_lectura,
       c.gestion_fac                      AS anio_facturacion,
       COUNT(*)                           AS lecturas
FROM tfv_cobranza c
JOIN h ON h.id_lectura = c.id_lectura
GROUP BY 1, 2
ORDER BY 1, 2;

-- 0.7 EL CATÁLOGO DE IRREGULARIDADES - nombre confirmado por la tesista 6 oct 2026
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
--        [ETIQUETA CORREGIDA 22 oct 2026, DEC-59]: lo que aquí se llamaba
--        "procedentes" NO son procedentes. `tfv_reclamo` no tiene ninguna
--        columna sw_procendente (CONTROL 5.d): el dominio 1/2/4 de la hoja
--        no está en la base. `sw_proceso` es binario y es OTRO campo,
--        probablemente "procesado". Estas cifras se publican como
--        sw_proceso='si', no como procedentes, hasta identificar el campo.
SELECT EXTRACT(YEAR FROM r.fecha_hora_reg)::int AS anio,
       COUNT(*)                                 AS reclamos,
       COUNT(*) FILTER (WHERE rl.sw_proceso = 1) AS sw_proceso_si,
       COUNT(DISTINCT r.nro_cuenta)              AS cuentas_afectadas
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
GROUP BY 1
ORDER BY 1;

-- A2.1.c Reclamos por tipo de lectura y por sw_proceso. [DESBLOQUEADO 7 oct 2026]
--        [ETIQUETA CORREGIDA 22 oct 2026, DEC-59]: "procedencia" era un
--        nombre prestado de la hoja. Aquí se agrupa sw_proceso, que es un
--        campo binario DISTINTO de sw_procendente.
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
-- [EXPECTATIVA RETRACTADA 22 oct 2026, DEC-59 — SUPERADA 24 oct 2026, DEC-61]:
-- la hoja publica 174 procedentes con dominio 1/2/4, y entonces se constató
-- que ese campo NO está ni en tfv_reclamo ni en tfv_reclamo_lectura
-- (CONTROL 5.d), de modo que la hoja quedaba como única fuente. YA NO LO ES:
-- el CONTROL 5.g lo ubicó en tfv_respuesta_reclamo, enlazada con tfv_reclamo
-- por id_reclamo. El 174, el 16,52 % y el 78,16 % se reproducen ahora desde
-- DOS orígenes independientes, en CONTROL 5.j, con autocalculos 1 053 / 174
-- / 136. Esta consulta agrupa sw_proceso, que es binario y es OTRO campo: sus
-- cifras NO son procedentes.
-- LO PRIMERO QUE SE REPRODUJO EXACTO, y sin una unidad de diferencia:
-- CONTROL 5.e, en la ventana 2022-01 a 2026-09, da
-- 996 (tipo 1) + 11 (tipo 2) + 46 (tipo 3) = 1 053 reclamos.

-- CONTROL 5 - CARDINALIDAD DE tfv_reclamo_lectura (22 oct 2026)
--     A2.1.b dio 14 164 reclamos; la hoja publica 1 053 (factor 13,45).
--     Mismo patrón que el 0.6.f: COUNT(*) sobre un LEFT JOIN MULTIPLICA.
--     ANTES de creer cualquier total de A2.1 se cuenta la cardinalidad.
--     AUTOCHEQUEO: reclamos_con_fila + reclamos_sin_fila = reclamos_total,
--     y reclamos_total menos filas_excedentes = reclamos_distintos.
WITH rl AS (
    SELECT id_reclamo,
           COUNT(*)                   AS n_filas,
           COUNT(DISTINCT id_lectura) AS n_lecturas
    FROM tfv_reclamo_lectura
    GROUP BY id_reclamo
)
SELECT (SELECT COUNT(*) FROM tfv_reclamo)                AS reclamos_total,
       COUNT(*) FILTER (WHERE rl.n_filas IS NOT NULL)    AS reclamos_con_fila,
       COUNT(*) FILTER (WHERE rl.n_filas IS NULL)        AS reclamos_sin_fila,
       COALESCE(SUM(rl.n_filas), 0)                      AS filas_en_reclamo_lectura,
       COALESCE(SUM(rl.n_filas) FILTER (WHERE rl.n_filas > 1), 0) AS filas_de_reclamos_repetidos,
       COALESCE(SUM(rl.n_filas - 1), 0)                  AS filas_excedentes,
       MAX(rl.n_filas)                                   AS max_filas_por_reclamo,
       COUNT(*) FILTER (WHERE rl.n_filas > 1)            AS reclamos_con_varios
FROM tfv_reclamo r
LEFT JOIN rl ON rl.id_reclamo = r.id_reclamo;

-- CONTROL 5.b EL CONTEO REAL, SIN MULTIPLICAR (22 oct 2026)
--     Reemplaza a A2.1.b si el CONTROL 5 confirma multiplicación: cuenta
--     reclamos DISTINTOS, no filas del join.
--     SAVEDAD SOBRE sw_proceso: A2.1.c lo devolvió como 'si'/'no' y A2.1.b
--     lo consultó como = 1; ambas dan los mismos 1 000, de modo que el
--     mapeo 1 <-> 'si' queda confirmado empíricamente. Si esta consulta
--     devolviera 0, cambiar 'si' por 1 y volver a correr.
--     [ETIQUETA CORREGIDA 22 oct 2026, DEC-59]: NO son procedentes.
--     sw_proceso es binario y tfv_reclamo no tiene sw_procendente; el
--     dominio 1/2/4 de la hoja es OTRO campo. Aquí se cuenta sw_proceso='si'.
--     AUTOCHEQUEO: con_lectura + sin_lectura = reclamos_distintos.
SELECT COUNT(DISTINCT r.id_reclamo)                                        AS reclamos_distintos,
       COUNT(DISTINCT r.id_reclamo) FILTER (WHERE rl.sw_proceso = 'si')    AS sw_proceso_si,
       COUNT(DISTINCT r.id_reclamo) FILTER (WHERE rl.sw_proceso = 'no')    AS sw_proceso_no,
       COUNT(DISTINCT r.id_reclamo) FILTER (WHERE rl.id_lectura IS NULL)   AS sin_lectura,
       COUNT(DISTINCT r.id_reclamo) FILTER (WHERE rl.id_lectura IS NOT NULL) AS con_lectura,
       COUNT(DISTINCT r.id_reclamo) FILTER (WHERE rl.fecha_odeco IS NOT NULL) AS con_fecha_odeco
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo;

-- CONTROL 5.c HUECOS DE ENLACE (22 oct 2026)
--     A2.1.a dio 1 140 registros con id_lectura; A2.1.c enlaza 1 069.
--     La diferencia de 71 son reclamos con id_lectura que NO encuentran
--     fila en tfv_lectura. Se mide, no se supone.
SELECT COUNT(*)                                   AS filas_reclamo_lectura,
       COUNT(*) FILTER (WHERE id_lectura IS NULL)     AS sin_id_lectura,
       COUNT(*) FILTER (WHERE id_lectura IS NOT NULL) AS con_id_lectura,
       COUNT(*) FILTER (WHERE id_lectura IS NOT NULL
                          AND id_lectura NOT IN
                              (SELECT id_lectura FROM tfv_lectura)) AS huerfanas_en_tf_lectura
FROM tfv_reclamo_lectura;

-- CONTROL 5.d COLUMNAS DE LAS DOS TABLAS DE RECLAMOS (22 oct 2026)
--     CONTROL 5.c dio 0 huérfanos, de modo que está DESCARTADA la idea de
--     que A2.1.c perdió 71 por no encontrar su fila en tfv_lectura: el
--     enlace existe.
--     Toca mirar las columnas. A2.1.b agrupó por año desde una fecha que
--     aquí todavía no se nombra, y el dominio 1/2/4 de "procedente" que
--     tiene la hoja pertenece a una columna que no se ha identificado.
--     NO SE DEDUCE EL NOMBRE DE NINGUNA COLUMNA: se lista y se pregunta.
SELECT table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name IN ('tfv_reclamo', 'tfv_reclamo_lectura')
ORDER BY table_name, ordinal_position;

-- CONTROL 5.e POR QUÉ A2.1.c PERDIÓ 71 (22 oct 2026)
--     CONTROL 5.b da 1 071 con sw_proceso='si'; A2.1.c dio 1 000: faltan 71.
--     Los 69 con sw_proceso='no' coinciden EXACTOS entre las dos consultas,
--     de modo que los 71 perdidos son todos con sw_proceso='si'.
--     CONTROL 5.c dio 0 huérfanos en tfv_lectura, así que no es el
--     enlace. Sospecha: tipo_lectura vuelve NULO y el GROUP BY de A2.1.c
--     los descarta.
--     AUTOCHEQUEO: la suma de reclamos debe dar 1 140.
--     [NOTA 24 oct 2026, DEC-61]: DEC-59 publicó esta misma consulta
--     FILTRADA A LA VENTANA DE LA HOJA —2022-01 a 2026-09— dando
--     996 + 11 + 46 = 1 053, pero ese WHERE no quedó guardado en este
--     archivo, de modo que tal como está aquí NO reproduce lo que DEC-59
--     dice haber corrido. No se parchea esta consulta: la ventana con sus
--     tres autocalculos vive ahora en CONTROL 5.j, más abajo, junto con
--     sw_procendente.
SELECT t.tipo_lectura,
       COUNT(DISTINCT r.id_reclamo)                                     AS reclamos,
       COUNT(DISTINCT r.id_reclamo) FILTER (WHERE rl.sw_proceso = 'si') AS sw_proceso_si,
       COUNT(DISTINCT r.id_reclamo) FILTER (WHERE rl.sw_proceso = 'no') AS sw_proceso_no
FROM tfv_reclamo r
JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
LEFT JOIN tfv_lectura t     ON t.id_lectura  = rl.id_lectura
GROUP BY t.tipo_lectura
ORDER BY t.tipo_lectura NULLS FIRST;

-- CONTROL 5.f RECLAMOS POR AÑO, SIN FILTRO, PARA EL Δ112 (22 oct 2026)
--     A2.1.b dio 14 164 agrupando 2022-2026; CONTROL 5 dio 14 276 sin
--     filtrar: Δ 112. CONTROL 5.d devuelve fecha_hora_reg como NOT NULL,
--     de modo que el GROUP BY NO pudo descartar ninguna fila por fecha nula
--     —ya se descartó por deducción, sin consulta—.
--     Quedan dos explicaciones: reclamos anteriores a 2022, porque la tabla
--     puede empezar antes, o crecimiento en caliente como tfv_cobranza.
--     AUTOCHEQUEO: la suma de todas las filas debe dar 14 276.
SELECT EXTRACT(YEAR FROM r.fecha_hora_reg)::int               AS anio,
       COUNT(*)                                               AS reclamos,
       COUNT(*) FILTER (WHERE rl.id_lectura IS NOT NULL)      AS con_lectura
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
GROUP BY 1
ORDER BY 1;

-- CONTROL 5.g DÓNDE ESTÁ sw_procendente (22 oct 2026)
--     CONTROL 5.d demostró que tfv_reclamo NO tiene sw_procendente y que
--     sw_proceso es binario, así que no puede representar el dominio 1/2/4
--     de la hoja. ANTES de concluir que el campo no existe, se busca en
--     TODO el esquema.
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE column_name ILIKE '%procend%'
   OR column_name ILIKE '%proceso%'
   OR column_name ILIKE '%odeco%'
ORDER BY table_name, column_name;

-- CONTROL 5.h DOMINIOS QUE FALTAN (22 oct 2026)
--     sw_proceso se consulta indistintamente como = 1 (A2.1.b) y como
--     'si'/'no' (A2.1.c) y las dos dan el mismo resultado. Se mide qué
--     guarda realmente. Y se abren tipo_reclamo y forma_presentacion:
--     son los dos campos NOT NULL de tfv_reclamo cuyo dominio se ignora.
SELECT 'sw_proceso'              AS campo, sw_proceso::text          AS valor, COUNT(*) AS filas
FROM tfv_reclamo_lectura GROUP BY 2
UNION ALL
SELECT 'tipo_reclamo',            tipo_reclamo::text,                COUNT(*) FROM tfv_reclamo GROUP BY 2
UNION ALL
SELECT 'forma_presentacion',      forma_presentacion::text,          COUNT(*) FROM tfv_reclamo GROUP BY 2
ORDER BY 1, 2;


-- CONTROL 5.i CARDINALIDAD DE tfv_respuesta_reclamo (24 oct 2026)
--     Respondido por la tesista con el CONTROL 5.g: la tabla que trae
--     sw_procendente es tfv_respuesta_reclamo, relacionada con tfv_reclamo
--     por id_reclamo, y su campo sw_procendente indica si el reclamo tiene
--     pronunciamiento procedente o improcedente.
--     SE MIDE LA CARDINALIDAD ANTES DE CONTAR NADA, porque el 0.6.f, el
--     CONTROL 3 y el CONTROL 5 enseñaron que un JOIN multiplicado devuelve
--     cifras falsas. Nada de esto sale a un documento si no cuadra.
--     AUTOCHEQUEO 1: si max_filas_por_reclamo = 1 y reclamos_con_varios = 0,
--     la tabla es 1:1 con tfv_reclamo, igual que tfv_reclamo_lectura y
--     tfv_cobranza (DEC-58). filas_respuesta debe ser igual a
--     filas_excedentes + reclamos_con_respuesta.
--     AUTOCHEQUEO 2: con_valores_discrepantes debe ser 0. Si no lo es, hay
--     reclamos con dos respuestas y valores distintos, y ENTONCES no se cuenta
--     por sw_procendente hasta saber cuál manda: se detiene y se pregunta.
WITH rr AS (
    SELECT id_reclamo,
           COUNT(*)                      AS n_filas,
           COUNT(DISTINCT sw_procendente) AS n_valores
    FROM tfv_respuesta_reclamo
    GROUP BY id_reclamo
)
SELECT (SELECT COUNT(*) FROM tfv_respuesta_reclamo) AS filas_respuesta,
       COUNT(*)                                     AS reclamos_con_respuesta,
       MAX(n_filas)                                 AS max_filas_por_reclamo,
       COUNT(*) FILTER (WHERE n_filas > 1)          AS reclamos_con_varios,
       SUM(n_filas - 1)                             AS filas_excedentes,
       COUNT(*) FILTER (WHERE n_valores > 1)        AS con_valores_discrepantes
FROM rr;


-- CONTROL 5.j LOS 174 Y LOS 136 DESDE LA BASE, NO SOLO DESDE LA HOJA (24 oct 2026)
--     Motivo: hasta hoy 174 / 16,52 % / 78,16 % tenían UNA SOLA FUENTE —la
--     hoja— porque DEC-59 encontró que tfv_reclamo no tiene sw_procendente.
--     El CONTROL 5.g ubicó el campo en tfv_respuesta_reclamo, y esto es lo
--     que convierte esas cifras en reproducibles desde dos orígenes.
--     VENTANA: 57 meses de la hoja, 2022-01-01 inclusive a 2026-10-01
--     exclusivo, sobre r.fecha_hora_reg, la misma fecha que usa A2.1.a.
--     TRES LEFT JOIN: ningún reclamo se descarta en silencio, que fue el
--     defecto que costó 71 reclamos a A2.1.c (DEC-58(4)). Lo que falte sale
--     rotulado '(sin respuesta)' o '(sin tipo)' y se ve en la salida.
--     COUNT(DISTINCT): el recuento sigue siendo correcto aunque la
--     cardinalidad no resulte 1:1; el 5.i dice cuál es.
--     AUTOCHEQUEO 1 (principal): la suma de la columna reclamos debe dar
--     1 053. Si no da, LA VENTANA ESTÁ APLICADA A LA FECHA EQUIVOCADA: se
--     prueba con rl.fecha_odeco y con la fecha de tfv_lectura antes de
--     publicar nada. No se ajusta la ventana para que cuadre.
--     AUTOCHEQUEO 2: agrupando solo por sw_procendente debe dar 174 con
--     procedente y 878 + 1 con los improcedentes.
--     AUTOCHEQUEO 3: entre los procedentes, tipo 1 debe dar 136, que es
--     78,16 % de 174 en los 57 meses.
SELECT COALESCE(rr.sw_procendente::text, '(sin respuesta)') AS sw_procendente,
       COALESCE(t.tipo_lectura::text,  '(sin tipo)')       AS tipo_lectura,
       COUNT(DISTINCT r.id_reclamo)                        AS reclamos
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl   ON rl.id_reclamo = r.id_reclamo
LEFT JOIN tfv_lectura t            ON t.id_lectura  = rl.id_lectura
LEFT JOIN tfv_respuesta_reclamo rr ON rr.id_reclamo = r.id_reclamo
WHERE r.fecha_hora_reg >= DATE '2022-01-01'
  AND r.fecha_hora_reg <  DATE '2026-10-01'
GROUP BY 1, 2
ORDER BY 1, 2;


-- CONTROL 5.k LOS 8 QUE FALTAN: TIENEN LECTURA PERO tipo_lectura SALE NULO (25 oct 2026)
--     DEC-65: la ventana 2022-01 a 2026-09 tiene 1 053 reclamos con lectura
--     —igual que la hoja— y el 5.j solo 1 045 con tipo, así que los 8 están
--     en la fila «(sin tipo)». NO ES LA VENTANA: es el tipo el que no está,
--     y mover el filtro no habría servido para nada.
--     AUTOCHEQUEO 1: por año debe dar 71 en 2021, que son los ya identificados
--     con el 5.e, y la suma de 2022 en adelante debe dar 8.
--     AUTOCHEQUEO 2: con_lectura_con_tipo + con_lectura_sin_tipo = con_lectura
--     en cada año, y con_lectura debe reproducir los 104 / 326 / 309 / 213 de
--     la hoja y 117 en 2026 —que es 101 de la hoja más 16 de octubre, porque
--     este control no filtra—.
--     AUTOCHEQUEO 3: sin_lectura + con_lectura = reclamos de cada año.
SELECT EXTRACT(YEAR FROM r.fecha_hora_reg)::int             AS anio,
       COUNT(*) FILTER (WHERE rl.id_lectura IS NOT NULL
                          AND t.tipo_lectura IS NULL)        AS con_lectura_sin_tipo,
       COUNT(*) FILTER (WHERE rl.id_lectura IS NOT NULL
                          AND t.tipo_lectura IS NOT NULL)    AS con_lectura_con_tipo,
       COUNT(*) FILTER (WHERE rl.id_lectura IS NULL)         AS sin_lectura,
       COUNT(*)                                              AS reclamos
FROM tfv_reclamo r
LEFT JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
LEFT JOIN tfv_lectura t          ON t.id_lectura  = rl.id_lectura
GROUP BY 1
ORDER BY 1;


-- CONTROL 5.l HUERFANAS DE tfv_lectura, SIN LA TRAMPA DE NOT IN (25 oct 2026)
--     El 5.c usa `id_lectura NOT IN (SELECT id_lectura FROM tfv_lectura)`.
--     NOT IN devuelve 0 filas si la subconsulta contiene UN SOLO NULL, haya
--     o no huérfanas, de modo que el 0 que dio puede ser un 0 real o un 0
--     silencioso. El «0 huérfanos» de DEC-58(3) se apoya en eso, y sobre él
--     se sostuvo la retractación de los «71 huérfanos» de DEC-56.
--     NO se concluye que esté mal: se corren las DOS versiones a la vez y se
--     comparan en la misma salida.
--     AUTOCHEQUEO: filas_lectura debe seguir dando 1 140.
--       - Si las dos dan 0, el del 5.c era real y DEC-58(3) se sostiene.
--       - Si NOT EXISTS da más de 0 y NOT IN da 0, el 5.c estaba enmascarando
--         huérfanas y hay que reabrir DEC-56 y DEC-58(3).
SELECT COUNT(*)                                            AS filas_lectura,
       COUNT(*) FILTER (WHERE rl.id_lectura IS NULL)       AS sin_id_lectura,
       COUNT(*) FILTER (WHERE rl.id_lectura IS NOT NULL
                          AND NOT EXISTS
                            (SELECT 1 FROM tfv_lectura tl
                              WHERE tl.id_lectura = rl.id_lectura)) AS huerfanas_not_exists,
       COUNT(*) FILTER (WHERE rl.id_lectura IS NOT NULL
                          AND rl.id_lectura NOT IN
                            (SELECT id_lectura FROM tfv_lectura))   AS huerfanas_not_in
FROM tfv_reclamo_lectura rl;


-- =====================================================================
-- CONTROL 9 — ¿LOS 8 O LOS 16? EL 5.j Y EL 5.k NO MIDEN LO MISMO
--                                  (25 oct 2026)
--
--     LO QUE SE VIO AL CRUZAR LAS SALIDAS DE HOY:
--       · 5.k, ventana, filas con tipo         -> 1 037
--       · 5.k, ventana, filas sin tipo         ->    16
--       · 5.k, ventana, filas con lectura      -> 1 053  == la hoja
--       · 5.j, ventana, RECLAMOS con tipo      -> 1 045
--       · DEC-65 dedujo sin tipo por resta     ->     8  (1 053 - 1 045)
--
--     LA CONTRADICCIÓN: 5.j da 1 045 y 5.k da 1 037 con la MISMA
--     ventana y el mismo JOIN. COUNT(DISTINCT) NUNCA puede dar más
--     que COUNT(*), así que o uno de los dos no filtra igual, o
--     miden poblaciones distintas. Y la cifra 8 aparece dos veces con
--     signo contrario: falta 8 en «con tipo» y sobran 8 en «sin
--     tipo».
--
--     LAS TRES HIPÓTESIS, en orden de lo que cambiaría:
--       (a) SON 8 RECLAMOS CON DOS ENLACES CADA UNO. Cuentan 16 filas
--           y 8 reclamos; los dos controles tendrían razón y lo que
--           habría que corregir es el recuento de DEC-65, no los
--           datos.
--       (b) SON 16 RECLAMOS DISTINTOS. Entonces DEC-65 está corto en
--           8 y el 5.j es el que no cuadra.
--       (c) ES UN EFECTO DE LA TABLA VIVA. El 5.j se corrió el 24 oct
--           y el 5.k el 25 oct; entre las dos corridas cambió algo
--           dentro de una ventana que se supone cerrada. Sería el
--           segundo indicio —después de octubre en A2.3— de que
--           «cerrado» no significa «inmóvil».
--
--     AUTOCHEQUEO 1: reclamos_con_lectura DEBE dar 1 053, la misma
--         cifra de la hoja y la del propio 5.j.
--     AUTOCHEQUEO 2: filas_sin_tipo DEBE dar 16 y filas_con_tipo
--         DEBE dar 1 037, que es lo que produjo el 5.k. Si no lo
--         dan, el 5.k no se reproduce y se repite antes de usarlo.
--     AUTOCHEQUEO 3: lo que falta es reclamos_sin_tipo. Si da 8, se
--         sostiene DEC-65 y se anota que el 5.k contaba filas. Si da
--         16, se rectifica DEC-65.
-- =====================================================================

WITH wl AS (
    SELECT rl.id_reclamo,
           t.tipo_lectura
      FROM tfv_reclamo r
      JOIN tfv_reclamo_lectura rl ON rl.id_reclamo = r.id_reclamo
      LEFT JOIN tfv_lectura t     ON t.id_lectura  = rl.id_lectura
     WHERE r.fecha_hora_reg >= DATE '2022-01-01'
       AND r.fecha_hora_reg <  DATE '2026-10-01'
)
SELECT COUNT(*) FILTER (WHERE tipo_lectura IS NULL)    AS filas_sin_tipo,
       COUNT(DISTINCT id_reclamo)
              FILTER (WHERE tipo_lectura IS NULL)      AS reclamos_sin_tipo,
       COUNT(*) FILTER (WHERE tipo_lectura IS NOT NULL) AS filas_con_tipo,
       COUNT(DISTINCT id_reclamo)
              FILTER (WHERE tipo_lectura IS NOT NULL)  AS reclamos_con_tipo,
       COUNT(DISTINCT id_reclamo)                      AS reclamos_con_lectura
  FROM wl;


-- =====================================================================
-- A2.3 — PANEL DE CONSUMO: una fila por cuenta y mes
-- Sin esto no hay detección: las tablas agregadas no permiten calcular
-- desviaciones por cuenta.
--
--     VENTANA OBLIGATORIA, 25 OCT 2026: 2022-01-01 a 2026-09-30.
--     La tesis cubre 57 meses, enero de 2022 a septiembre de 2026, y
--     EL CIERRE ES OBLIGATORIO POR DOS MOTIVOS:
--       (a) La lecturación de octubre está EN CURSO, así que ese mes
--           está incompleto y meterlo desplaza toda la serie.
--       (b) LA TABLA ES VIVA —lo confirmó la tesista el 25 oct 2026—:
--           crece mientras se lee. Un panel sin fecha de cierre no es
--           reproducible, y una desviación calculada contra un panel
--           que cambió ayer no es auditable.
--     Dos corridas de la tesista el 25 oct 2026 lo demuestran:
--       · sin cierre (>= 2022-01-01)              → 1 519 833 filas
--       · con cierre (2022-01-01 a 2026-09-30)    → 1 491 175 filas
--       · diferencia = 28 658, que es la lecturación de octubre
--     La segunda coincide exacto con las 1 491 175 del CONTROL 3 del
--     20 oct: el histórico del periodo de la tesis no cambió.
--
--     El ~1,7 millones de abajo es UNA ESTIMACIÓN DE ESQUEMA
--     —57 meses x 29 750 cuentas = 1 695 750— y NO es una
--     comprobación. La comprobación es el CONTROL A2.3.a, más abajo.
-- =====================================================================

SELECT nro_cuenta,
       DATE_TRUNC('month', fecha_lec)::date AS mes,
       lec_actual,
       consumo,
       id_lectura,
       fecha_lec
FROM tfv_historico_lecturador
WHERE fecha_lec >= DATE '2022-01-01'
  AND fecha_lec <  DATE '2026-10-01'
ORDER BY nro_cuenta, fecha_lec;


-- =====================================================================
-- A2.3.a CONTROL DEL PANEL — el contrato de A2.3 contra lo que sale
--                                  (25 oct 2026)
--
--     DOS PROBLEMAS QUE SE LEEN DEL ARCHIVO. EL (2) QUEDÓ RESUELTO EL
--     25 OCT POR LA TESISTA —DEC-69—; EL (1) SIGUE ABIERTO Y ES EL
--     QUE HACE CORRER ESTE CONTROL.
--
--     (1) A2.3 DECLARA «una fila por cuenta y mes» PERO NO LO HACE.
--         Viene SIN GROUP BY y SIN DISTINCT: devuelve una fila POR
--         LECTURA. Si una cuenta se leyó dos veces en un mes, ese mes
--         sale dos veces y la desviación de E7a se calcularía contra una
--         referencia duplicada. Que hoy no haya duplicados no arregla la
--         consulta: solo la hace funcionar por suerte.
--
--     (2) LA CIFRA NO CUADRABA CON EL CONTROL 3 — RESUELTO EL 25 OCT
--         POR LA TESISTA. DEC-69.
--         Dos corridas suyas el mismo día:
--           · >= 2022-01-01, SIN cierre            → 1 519 833
--           · 2022-01-01 a 2026-09-30, CON cierre  → 1 491 175
--         El resto —28 658 filas— ES LA LECTURACIÓN DE OCTUBRE, QUE
--         ESTÁ EN CURSO, y LA TABLA ES VIVA: ella misma lo declara.
--         La ventana cerrada coincide exacto con las 1 491 175 del
--         CONTROL 3 del 20 oct, de modo que EL HISTÓRICO DEL PERÍODO
--         DE LA TESIS NO HA CAMBIADO. La contradicción no estaba en
--         los datos: estaba en que A2.3 no traía fecha de cierre.
--         CONSECUENCIA: EL PANEL SE CORRE SIEMPRE CON CIERRE
--         2026-09-30. Un panel sin cierre no es reproducible.
--
--     A2.3 TAMBIÉN NO TIENE AUTOCALCULO. Lo único escrito es «~1,7
--     millones de filas», que es una ESTIMACIÓN —57 meses x 29 750
--     cuentas = 1 695 750—, no una comprobación. Este control la pone.
--
--     AUTOCHEQUEO 1: filas_ventana DEBE dar lo que devolvió A2.3.
--         Si no lo da, A2.3 se corrió en otra fecha y manda esta corrida
--         con su sello.
--     AUTOCHEQUEO 2: filas_totales >= filas_ventana. Si NO se
--         cumple, ninguna de las dos cifras es utilizable y se repite
--         las dos seguidas en la misma sesión antes de escribir nada.
--     AUTOCHEQUEO 3: cuentas_mes_distintas == filas_ventana ES LA
--         CONDICIÓN DE QUE EL PANEL CUMPLA SU CONTRATO. Si es menor,
--         A2.3 se corrige con GROUP BY ANTES de usarla, y la diferencia
--         está en lecturas_sobrantes.
--     AUTOCHEQUEO 4: fecha_maxima dice hasta cuándo llega el histórico.
--         E7a exige CUATRO ciclos anuales completos (E4 §4.2). Si no
--         alcanza, la A2 no se puede calcular en los términos elegidos y
--         la contingencia A1 gana terreno.
--     AUTOCHEQUEO 5: filas_totales = filas_anteriores_2022 +
--         filas_ventana + filas_octubre + fecha_nula. Debe cerrar exacto.
-- =====================================================================
WITH h AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec) AS mes,
           fecha_lec
      FROM tfv_historico_lecturador
)
SELECT COUNT(*)                                               AS filas_totales,
       COUNT(*) FILTER (WHERE fecha_lec >= DATE '2022-01-01' AND fecha_lec < DATE '2026-10-01') AS filas_ventana,
       COUNT(*) FILTER (WHERE fecha_lec >= DATE '2026-10-01') AS filas_octubre,
       COUNT(*) FILTER (WHERE fecha_lec < DATE '2022-01-01')  AS filas_anteriores_2022,
       COUNT(*) FILTER (WHERE fecha_lec IS NULL)              AS fecha_nula,
       MIN(fecha_lec)                                         AS fecha_minima,
       MAX(fecha_lec)                                         AS fecha_maxima,
       COUNT(DISTINCT nro_cuenta)                             AS cuentas,
       COUNT(DISTINCT mes)                                    AS meses,
       (SELECT COUNT(*)
          FROM (SELECT 1
                  FROM h
                 WHERE fecha_lec >= DATE '2022-01-01' AND fecha_lec < DATE '2026-10-01'
                 GROUP BY nro_cuenta, mes) cm)                AS cuentas_mes_distintas,
       (COUNT(*) FILTER (WHERE fecha_lec >= DATE '2022-01-01' AND fecha_lec < DATE '2026-10-01'))
         - (SELECT COUNT(*)
              FROM (SELECT 1
                      FROM h
                     WHERE fecha_lec >= DATE '2022-01-01' AND fecha_lec < DATE '2026-10-01'
                     GROUP BY nro_cuenta, mes) cm2)           AS lecturas_sobrantes
  FROM h;


-- =====================================================================
-- CONTROL 7 — LA FECHA IMPOSIBLE: fecha_minima CON AÑO 0023
--                                  (25 oct 2026, sobre A2.3.a)
--
--     QUÉ DIO A2.3.a QUE OBLIGA A ESTE CONTROL:
--       · fecha_minima            = 12/5/0023   -> AÑO 0023
--       · filas_anteriores_2022   = 184 732
--       · meses                   = 68
--       · fecha_maxima            = 22/10/2026
--
--     POR QUÉ NO SE PASA POR ALTO. La ventana del panel es
--     2022-01-01 a 2026-09-30 y el filtro es `fecha_lec >=
--     2022-01-01`. UNA FILA CON EL AÑO MAL ESCRITO CAE FUERA DE LA
--     VENTANA aunque su lectura corresponda a 2023. Eso no ensucia el
--     panel: LO DEJA INCOMPLETO, que es peor, porque una fila ausente
--     no se ve en ningún autocalculeo —los cinco de A2.3.a cierran
--     exacto aunque esa fila esté fuera—.
--
--     DOS HIPÓTESIS, Y LAS DOS IMPORTAN:
--       (a) ES DATO REAL ANTIGUO. La tabla trae lecturas previas a
--           2022 y una de ellas tiene el año mal escrito. Efecto
--           sobre el panel: NINGUNO; solo hay que declararlo.
--       (b) ES UNA LECTURA DE 2023 CON EL AÑO DE DOS DÍGITOS —clásico
--           `23` leído como año 23 en vez de 2023—. Efecto: ESA FILA
--           FALTA EN EL PANEL, y si el patrón se repite faltan más.
--           Habría que corregir el año ANTES de calcular cualquier
--           desviación, porque una cuenta con un mes de menos en su
--           serie no es una cuenta con un dato faltante: es una
--           cuenta cuyo ciclo anual está roto.
--
--     AUTOCHEQUEO 1 (7.a): la suma de `filas` por año DEBE cerrar
--         exacto con filas_totales del A2.3.a = 1 704 565.
--     AUTOCHEQUEO 2 (7.b): filas_anteriores_2000. Si es 0, manda la
--         hipótesis (a); si es mayor que 0, manda la (b).
--     AVISO: la tabla es viva —toda corrida lleva sello de fecha.
-- =====================================================================

-- 7.a PERFIL COMPLETO POR AÑO — incluye los años imposibles
SELECT EXTRACT(YEAR FROM fecha_lec)::int AS anio,
       COUNT(*)                          AS filas,
       COUNT(DISTINCT nro_cuenta)        AS cuentas,
       MIN(fecha_lec)                    AS fecha_minima,
       MAX(fecha_lec)                    AS fecha_maxima
  FROM tfv_historico_lecturador
 GROUP BY 1
 ORDER BY 1;
-- Esperar años de 2021 a 2026. Si aparece algún año por debajo de
-- 2000, ese es el problema. AUTOCHEQUEO 1: SUM(filas) = 1 704 565.

-- 7.b CUÁNTAS FILAS TIENEN EL AÑO ANTES DE 2000
SELECT COUNT(*) AS filas_anteriores_2000
  FROM tfv_historico_lecturador
 WHERE fecha_lec < DATE '2000-01-01';

-- 7.c ESAS FILAS, EN BRUTO
SELECT fecha_lec, nro_cuenta, lec_actual, consumo, id_lectura
  FROM tfv_historico_lecturador
 WHERE fecha_lec < DATE '2000-01-01'
 ORDER BY fecha_lec
LIMIT 50;
-- QUÉ MIRAR: si `lec_actual` sigue la escala de las lecturas de 2023
-- de ESA MISMA cuenta, el año está mal escrito y la fila le
-- pertenece a 2023 —hipótesis (b)—. Si el número es coherente con
-- lecturas muy antiguas, es dato real y solo hay que declararlo
-- —hipótesis (a)—.


-- =====================================================================
-- CONTROL 8 — LOS 5 619: LA FORMA REAL DE LOS DUPLICADOS DEL PANEL
--                                  (25 oct 2026, sobre A2.3.a)
--
--     QUÉ DIO A2.3.a — AUTOCHEQUEO 3 NO CIERRÓ:
--       · filas_ventana            = 1 491 175
--       · cuentas_mes_distintas    = 1 485 556
--       · lecturas_sobrantes       =     5 619   <- exacto
--
--     El contrato de A2.3 es «una fila por cuenta y mes» y NO SE
--     CUMPLE: hay 5 619 filas de más, lecturas repetidas dentro de un
--     mismo mes. POR ESO A2.3 NO SE USA TAL COMO ESTÁ —el defecto
--     estaba declarado desde su cabecera, ahora está medido—.
--
--     QUÉ FALTA ANTES DE CORREGIRLA CON GROUP BY. Agrupar exige
--     DECIDIR QUÉ SE HACE CON LAS FILAS QUE COLLAPSAN, y esa decisión
--     no se toma a ciegas:
--       · si las duplicadas traen EL MISMO consumo, da igual cuál se
--         quede y basta con DISTINCT;
--       · si traen CONSUMOS DISTINTOS, hay que elegir —la lectura
--         más reciente del mes, la mayor, la del lec_actual vigente—
--         Y LA ELECCIÓN CAMBIA LA DESVIACIÓN DE E7a. Por eso se mide
--         antes de decidir, y no al revés.
--
--     AUTOCHEQUEO 1 (8.a): filas_sobrantes DEBE dar 5 619, la misma
--         cifra que A2.3.a en esta misma sesión. Si no coincide, una
--         de las dos corridas no es la misma y se repiten las dos
--         seguidas antes de escribir nada.
--     AUTOCHEQUEO 2 (8.a): con_consumo_identico + con_consumo_distinto
--         DEBE cerrar con cuentas_mes_con_mas_de_una.
--     AUTOCHEQUEO 3 (8.a): filas_en_grupos_duplicados =
--         cuentas_mes_con_mas_de_una + filas_sobrantes.
--     AVISO: la ventana se corre con cierre 2026-09-30, igual que
--         A2.3 y A2.3.a. Una corrida con otra fecha no compara.
-- =====================================================================

WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec) AS mes,
           consumo,
           lec_actual
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
d AS (
    SELECT nro_cuenta,
           mes,
           COUNT(*)                                        AS n_filas,
           (COUNT(*) - 1)                                  AS filas_sobrantes,
           (COUNT(DISTINCT consumo) <= 1)                  AS consumo_identico,
           (COUNT(DISTINCT lec_actual) <= 1)               AS lec_actual_identico,
           COUNT(*) FILTER (WHERE consumo IS NULL)         AS consumos_nulos
      FROM w
     GROUP BY nro_cuenta, mes
    HAVING COUNT(*) > 1
)
SELECT COUNT(*)                                              AS cuentas_mes_con_mas_de_una,
       SUM(filas_sobrantes)                                  AS filas_sobrantes,
       SUM(n_filas)                                          AS filas_en_grupos_duplicados,
       SUM(CASE WHEN consumo_identico THEN 1 ELSE 0 END)     AS con_consumo_identico,
       SUM(CASE WHEN consumo_identico THEN 0 ELSE 1 END)     AS con_consumo_distinto,
       SUM(CASE WHEN lec_actual_identico THEN 1 ELSE 0 END)  AS con_lec_actual_identico,
       SUM(consumos_nulos)                                   AS consumos_nulos,
       MAX(n_filas)                                          AS max_filas_por_cuenta_mes
  FROM d;

-- 8.b DIEZ EJEMPLOS DE DOBLE LECTURA, PARA VER QUÉ SON
WITH dup AS (
    SELECT nro_cuenta, DATE_TRUNC('month', fecha_lec) AS mes
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
     GROUP BY 1, 2
    HAVING COUNT(*) > 1
)
SELECT h.nro_cuenta,
       DATE_TRUNC('month', h.fecha_lec)::date AS mes,
       h.fecha_lec,
       h.lec_actual,
       h.consumo,
       h.id_lectura
  FROM tfv_historico_lecturador h
  JOIN dup d ON d.nro_cuenta = h.nro_cuenta
            AND d.mes = DATE_TRUNC('month', h.fecha_lec)
 ORDER BY h.nro_cuenta, h.fecha_lec
LIMIT 20;
-- QUÉ MIRAR: si las dos filas del mismo mes traen el mismo consumo,
-- la corrección es trivial. Si traen consumos distintos, ver si la
-- más reciente es siempre la mayor —eso sería una corrección al
-- alza— o si el orden es azar, porque el criterio de colapso depende
-- de eso y no de mi preferencia.


-- =====================================================================
-- CONTROL 6 — R3.4: ¿LA RUTA EXISTE EN EL DATO?
--                                  (25 oct 2026)
--
--     DICTAMEN DE LA TESISTA, 25 OCT 2026 — CADENA DECLARADA:
--         tfv_ruta (id_ruta)
--             ^ tfv_cliente (id_cliente, id_ruta, nro_cuenta)
--                     ^ tfv_lectura (nro_cuenta)
--     Y para el método lo que manda es su variante sobre el PANEL:
--         tfv_historico_lecturador.nro_cuenta -> tfv_cliente.nro_cuenta
--                                              -> tfv_ruta.id_ruta
--
--     POR QUÉ SE VERIFICA Y NO SE TOMA LA PALABRA. R3.4 pide que el
--     campo con el que se agrupa EXISTA EN EL DATO. Que las tablas
--     existan es solo la primera de cuatro condiciones; las otras
--     tres son las que hacen que la agrupación sea posible:
--
--       (1) COBERTURA — ¿toda cuenta del panel tiene fila en
--           tfv_cliente? Una cuenta sin fila es una cuenta sin ruta,
--           y una alerta sin ruta no se puede agrupar. DEC-57
--           establece que la agrupación es PARTE DEL MÉTODO y no un
--           agregado posterior, así que una alerta huérfana de ruta
--           rompe el método, no solo el informe.
--       (2) UNICIDAD — ¿cada cuenta cae en UN SOLO id_ruta? Si
--           tfv_cliente tuviera dos filas para la misma cuenta con
--           rutas distintas, «la ruta de la cuenta» no estaría
--           definida. **LA REGLA YA ESTÁ FIJADA —DEC-71, 25 OCT
--           2026—: MANDA LA RUTA VIGENTE EN tfv_cliente.** Lo que
--           falta por ver no es la regla, es si la tabla puede
--           aplicarla, y eso lo dice la 6.a.
--       (3) NO NULIDAD — id_ruta nulo es lo mismo que sin ruta.
--       (4) GRANULARIDAD — cuántas rutas hay y cómo se reparten las
--           cuentas. No es un dato decorativo: la revisión es de 1 a
--           3 técnicos con 3 a 4 horas TOPE (DEC-57), de modo que una
--           ruta que acapara la mitad de la ciudad y una con doscientas
--           cuentas no son la misma unidad de trabajo.
--
--     AUTOCHEQUEO 1 (6.d): cuentas_en_panel = cuentas_sin_fila +
--         cuentas_sin_id_ruta + cuentas_de_una_ruta +
--         cuentas_con_varias_rutas. Los cuatro cubos son excluyentes
--         y deben cerrar el total.
--     AUTOCHEQUEO 2 (6.e): la suma de `cuentas` por ruta debe ser
--         exactamente `cuentas_de_una_ruta` del 6.d.
--     AUTOCHEQUEO 3 (6.c): cuentas_con_varias_rutas debe ser 0. Si no
--         lo es NO se agrupa todavía, pero **TAMPOCO SE VUELVE A
--         PREGUNTAR**: manda DEC-71 —la ruta vigente en tfv_cliente—
--         y lo que hay que comprobar es que la 6.a encuentre la
--         columna que expresa esa vigencia.
--     AUTOCHEQUEO 4 (6.b): id_ruta_nulo y nro_cuenta_nulo deben ser 0.
--     AVISO: tfv_ruta y tfv_cliente pueden ser tablas vivas como las
--         demás —toda corrida lleva sello de fecha.
-- =====================================================================

-- 6.a Las dos tablas existen y estas son sus columnas
SELECT table_name, column_name, data_type
  FROM information_schema.columns
 WHERE table_name IN ('tfv_ruta', 'tfv_cliente')
 ORDER BY table_name, ordinal_position;
-- Si una de las dos no aparece, o si a tfv_cliente le falta
-- `nro_cuenta` o `id_ruta`, R3.4 NO se cumple y R3 se reabre.
-- BUSCAR TAMBIÉN, EN LA COLUMNA `column_name`, QUÉ CAMPO EXPRESA LA
-- VIGENCIA DE UNA FILA —estado, baja, fecha fin, vigencia—. Es lo
-- que hace implementable DEC-71, que manda la ruta vigente. La
-- tesista declaró `id_cliente, id_ruta, nro_cuenta` y «otros campos»
-- sin nombrarlos. Si entre esos otros no hay ninguno que distinga la
-- fila en pie, «la ruta vigente» no está definida y DEC-71 queda
-- escrita pero SIN IMPLEMENTAR: en ese caso se vuelve con la tesista
-- a elegir entre las que sí se pueden calcular —la del periodo
-- leído, la que más veces aparece—.

-- 6.b UNICIDAD EN BRUTO de tfv_cliente
SELECT COUNT(*)                                 AS filas_cliente,
       COUNT(DISTINCT nro_cuenta)               AS cuentas,
       COUNT(DISTINCT id_ruta)                  AS rutas,
       COUNT(*) FILTER (WHERE id_ruta IS NULL)     AS id_ruta_nulo,
       COUNT(*) FILTER (WHERE nro_cuenta IS NULL)  AS nro_cuenta_nulo
  FROM tfv_cliente;
-- filas_cliente > cuentas no es un error por sí mismo: una cuenta
-- puede tener varios clientes. LO ES cuando además tienen rutas
-- distintas, y eso lo decide el 6.c.

-- 6.c LA CONDICIÓN QUE ZANJA: cada cuenta cae en UNA sola ruta
SELECT COUNT(*)                                    AS cuentas,
       COUNT(*) FILTER (WHERE n_rutas = 1)         AS cuentas_de_una_ruta,
       COUNT(*) FILTER (WHERE n_rutas > 1)         AS cuentas_con_varias_rutas,
       COUNT(*) FILTER (WHERE n_rutas = 0)         AS cuentas_con_ruta_nula,
       MAX(n_rutas)                                AS max_rutas_por_cuenta
  FROM ( SELECT nro_cuenta, COUNT(DISTINCT id_ruta) AS n_rutas
           FROM tfv_cliente
          WHERE nro_cuenta IS NOT NULL
          GROUP BY nro_cuenta ) c;
-- cuentas_con_varias_rutas > 0 => la ruta de la cuenta NO está
-- definida en el dato. **NO ES UNA PARADA QUE OBLIGUE A VOLVER A
-- PREGUNTAR: LA REGLA YA ESTÁ —DEC-71— Y MANDA LA RUTA VIGENTE EN
-- tfv_cliente.** La parada que queda es comprobar, con la salida de
-- la 6.a, que esa vigencia se puede calcular con las columnas que la
-- tabla tiene.

-- 6.d COBERTURA DEL PANEL — la que decide si se puede agrupar
WITH panel AS (
    SELECT DISTINCT nro_cuenta
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
cli AS (
    SELECT nro_cuenta,
           COUNT(DISTINCT id_ruta) AS n_rutas
      FROM tfv_cliente
     WHERE nro_cuenta IS NOT NULL
     GROUP BY nro_cuenta
)
SELECT (SELECT COUNT(*) FROM panel)                        AS cuentas_en_panel,
       COUNT(*) FILTER (WHERE c.nro_cuenta IS NULL)        AS cuentas_sin_fila,
       COUNT(*) FILTER (WHERE c.n_rutas = 0)               AS cuentas_sin_id_ruta,
       COUNT(*) FILTER (WHERE c.n_rutas = 1)               AS cuentas_de_una_ruta,
       COUNT(*) FILTER (WHERE c.n_rutas > 1)               AS cuentas_con_varias_rutas
  FROM panel p
  LEFT JOIN cli c ON c.nro_cuenta = p.nro_cuenta;

-- 6.e GRANULARIDAD: cómo se reparten las cuentas del panel por ruta
--     OJO: el `HAVING COUNT(DISTINCT id_ruta) = 1` deja FUERA a las
--     cuentas con más de una ruta. Está así a propósito, para que el
--     autocalculeo 2 cierre exacto contra `cuentas_de_una_ruta` del
--     6.d. **PERO SI EL 6.c DA > 0, ESTE 6.e MIDE MENOS DE LO QUE EL
--     MÉTODO VA A AGRUPAR** y hay que reescribirlo aplicando DEC-71
--     —la ruta vigente— en lugar del HAVING. No se reescribe ahora:
--     hacerlo a ciegas sería inventar la columna que decide cuál es
--     la vigente.
WITH panel AS (
    SELECT DISTINCT nro_cuenta
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
cli AS (
    SELECT nro_cuenta, MIN(id_ruta) AS id_ruta
      FROM tfv_cliente
     WHERE nro_cuenta IS NOT NULL
       AND id_ruta IS NOT NULL
     GROUP BY nro_cuenta
    HAVING COUNT(DISTINCT id_ruta) = 1
)
SELECT c.id_ruta,
       COUNT(*)                                              AS cuentas,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)    AS pct
  FROM panel p
  JOIN cli c ON c.nro_cuenta = p.nro_cuenta
 GROUP BY c.id_ruta
 ORDER BY cuentas DESC;
-- MIRAR LA FORMA, NO SOLO EL TOTAL. Si unas pocas rutas acaparan
-- casi todas las cuentas, agrupar por ruta no nivela la carga de los
-- 1 a 3 técnicos; si hay rutas con poquísimas, cada alerta se revisa
-- casi aislada. La forma del reparto decide si la agrupación sirve
-- para REPARTIR el trabajo o solo para ORDENARLO, y eso se traduce a
-- E7c.


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
       COUNT(*) FILTER (WHERE rl.sw_proceso = 1)    AS sw_proceso_si,
       COUNT(*) FILTER (WHERE rl.sw_proceso <> 1)   AS sw_proceso_no
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
-- [B3] CERRADO: NO EQUIVALEN (DEC-59, 22 oct 2026), y el campo fue
--      localizado el 24 oct 2026 (DEC-61): sw_procendente está en
--      tfv_respuesta_reclamo, enlazada con tfv_reclamo por id_reclamo.
--      sw_proceso es OTRO campo, binario, y no lo sustituye.
--      El recuento reproducible desde la base está en CONTROL 5.j;
--      la cardinalidad, en CONTROL 5.i.
-- =====================================================================
