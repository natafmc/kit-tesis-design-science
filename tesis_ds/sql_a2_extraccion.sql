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
--          id_lectura. -> 0.7.b ESCRITO y ejecutable; CORRIDO EL 20 OCT
--          2026 JUNTO CON SUS DOS CONTROLES (DEC-48 y DEC-49).
--   [B2] CERRADO. Y A2.4.3, RETIRADO — DEC-82, 27 oct 2026:
--        tfv_cobranza existe (0.6.d, 9 oct, DEC-39), pero la via por
--        consumo CERRO en DEC-53, y lo que la forma agregada daria ya
--        esta en la Prueba 2 de consultas_base_datos.md. A2.4.3 NO se
--        reformula: SE RETIRA. Sus tres motivos estan en DEC-82.
--        LO QUE QUEDA ABIERTO NO ES SQL: se llama «definición de
--        lecturas_diferentes» y es una consulta a ENDE, que es quien
--        elaboró la hoja historico de DATOS desde 2022.xlsx —declarado
--        por la tesista el 27 oct, DEC-83; la consulta ya está redactada
--        y sin enviar, en 00_estado.md—. La hoja no tiene NINGUNA
--        fórmula y no nombra el segundo campo, así que no puede
--        responderlo nadie que solo lea el archivo.
--        Declara además el descuadre de 185: la hoja suma 1 491 360 y la
--        ventana de la base 1 491 175. NO toca el 242,2 —que es 2 180
--        dividido 9 y no usa total_lecturas—; sí toca las tasas anuales.
--        Pendiente de localizar mes a mes por DEC-73/P4: no desbloquea.
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

-- 0.6.d CANDIDATA A LECTURA FACTURADA — levantó [B2] (cabecera histórica)
--     El 0.6.b devolvió tfv_cobranza entre las tablas enlazables por
--     id_lectura. Fue la candidata a <TABLA_FACTURADA> de A2.4.3 —cuya
--     consulta está hoy RETIRADA, DEC-82— y así se escribió esta nota.
--     Se conserva como registro de por qué existía.
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
  AND table_name = 'tfv_cobranza'
ORDER BY ordinal_position;


-- 0.6.e QUÉ TRAE tfv_cobranza — para decidir si levanta [B2] (9 oct 2026)
--     El 0.6.d devolvió 34 columnas. Las que interesaban para A2.4.3
--     —consulta RETIRADA en DEC-82, esta nota queda como registro—:
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
--           habría comparado contra lec_actual, pero tfv_cobranza NO
--           trae columna de lectura: trae consumo. Si las dos columnas
--           consumo son iguales siempre, esta via NO sirve;
--       (b) si una lectura genera UNA o VARIAS cobranzas — fecha_anulada,
--           id_nota, sw_nota, obs_fac_saltada y cant_imprime sugieren
--           varias—. Si son varias, el JOIN multiplica filas y multiplica
--           tambien las correcciones;
--       (c) si la tabla cubre 2022-2026.
--     Tres preguntas, tres queries. Se corrieron: 0.6.e.1 y 0.6.e.2 el
--     20 oct (DEC-48), 0.6.e.3 inválido —el JOIN multiplicó 1 376
--     filas— y sustituido por el CONTROL 4 (DEC-51). Lo que «antes de
--     escribir A2.4.3» ya no aplica: esa consulta está RETIRADA (DEC-82).

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
-- Si filas = lecturas, tfv_cobranza es 1:1 con la lectura y un JOIN
-- habría sido seguro. Si no, habría que agregar antes de cruzar.
-- RESULTADO (DEC-48): filas = lecturas = 1 389 282, o sea 1:1. La
-- condición se cumplió, pero A2.4.3 quedó RETIRADO igual (DEC-82): lo
-- que lo mató no fue la cardinalidad, fue DEC-53.

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
-- A NIVEL DE REGISTRO, que era lo que [B2] necesitaba para abrir A2.4.3
-- —consulta hoy RETIRADA, DEC-82—.
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
--     CORRIDO EL 20 OCT 2026 (DEC-48): el tipo 1 salió SOLO con «sin
--     codigo» y «codigo 0», sin ninguna lectura tipo 1 con código real,
--     de modo que DEC-30 quedó CERRADA CON DATO. Los dos controles de
--     abajo cerraron también: el Control 1 dio max_codigos_por_lectura
--     = 1 y lecturas_con_varios = 0, y el Control 2 reprodujo las cinco
--     cifras desde la base.
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
-- A2.3.b — EL PANEL COLLAPSADO: LA REGLA DE COLAPSO, APLICADA
--                     (26 oct 2026 — DEC-75, regla fijada ANTES de correr)
--
--     POR QUÉ EXISTE ESTA CONSULTA:
--     A2.3.a demostró que A2.3 declara «una fila por cuenta y mes» y NO
--     LO HACE: en la ventana hay 1 491 175 filas contra 1 485 556
--     (cuenta, mes), es decir 5 619 de más. El 26 oct la tesista fijó la
--     regla de colapso —DEC-75, P1 = (a)— y A2.3.b ES ESA REGLA
--     APLICADA. La regla se escribe antes de ver la salida, como manda
--     la trazabilidad, y no después de mirar qué número conviene.
--
--     LA REGLA — DEC-75, P1 = (a), dictada por la tesista:
--       dentro de cada (cuenta, mes) MANDA LA LECTURA DE FECHA MÁS
--       RECIENTE. Si las dos fechas coinciden —lo usual según 8.b—,
--       desempata el id_lectura MÁS ALTO, o sea lo cargado después.
--       Ese segundo criterio no es una decisión de contenido: esas dos
--       filas traen el mismo consumo y lo único que hace es dejar la
--       corrida determinista.
--
--     LO QUE LA REGLA NO DECIDE, Y POR QUÉ SE MIDE EN VEZ DE CREERSE:
--       en las cuentas con dos fechas distintas el consumo puede subir
--       o bajar indistintamente, y A2.3.b los cuenta por separado
--       —`colapso_al_alza` contra `colapso_a_la_baja`— para que la
--       cifra esté medida y no supuesta. El 8.b ya mostró un caso en
--       el que la regla BAJA el consumo: cuenta 100009, abril de 2022,
--       con 10/4 y 62 contra 12/4 y 45, de modo que manda la de 45.
--       Sin consumos nulos —lo midió 8.a— la comparación no puede
--       quedarse sin cubo.
--
--     AUTOCHEQUEOS — cada uno se comprueba contra OTRA corrida:
--       1. filas_originales = 1 491 175 = filas_ventana de A2.3.a.
--       2. filas_colapsadas = 5 619 = lecturas_sobrantes de A2.3.a
--          = filas_sobrantes del CONTROL 8.
--       3. filas_finales = 1 485 556 = cuentas_mes_distintas.
--       4. filas_de_mas = 0 — el contrato de A2.3, cumplido aquí POR
--          CONSTRUCCIÓN y no por declaración: es exactamente el control
--          que falló en A2.3.a.
--       5. cuentas = 30 411 = cifra del 6.d, medida contra otra tabla.
--       6. meses = 57 — la ventana entera, enero de 2022 a septiembre
--          de 2026.
--       7. grupos_con_consumo_distinto = 1 689 = cifra del 8.a.
--       8. colapso_al_alza + colapso_a_la_baja = 1 689.
--       9. carga_duplicada + relecturas = 5 619 = grupos_duplicados.
--       10. fecha_minima >= 2022-01-01 — la fila con año 0023 no entró
--           por el filtro de ventana y aquí se ve que no entró.
--
--     PENDIENTE RESUELTO — DEC-79, 27 oct 2026: el 7.e CORRIÓ Y NO LE
--     FALTA MAYO DE 2023 —12 de 12 filas, mayo incluido: 14/5/2023,
--     lec_actual 823816, id_lectura 595803—. P3 NO SE ACTIVA: el año no
--     se corrige y el panel no se rehace. Esta corrida es definitiva en
--     regla y definitiva también en ese aspecto.
--     RESULTADO DE A2.3.b, 27 oct 2026 (DEC-80): LOS DOCE AUTOCALCUELOS
--     CIERRAN. filas_de_mas = 0 cierra R9.1 y meses = 57 cierra R9.2.
-- =====================================================================

-- A2.3.b SALIDA — EL PANEL: una fila por cuenta y mes, ya real
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
)
SELECT DISTINCT ON (nro_cuenta, mes)
       nro_cuenta,
       mes,
       fecha_lec  AS fecha_de_la_lectura_que_manda,
       lec_actual,
       consumo,
       id_lectura
  FROM w
 ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC;


-- A2.3.b AUTOCALCULEO — los diez contra otras corridas
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
g AS (
    SELECT nro_cuenta,
           mes,
           MAX(consumo)              AS consumo_maximo,
           MIN(consumo)              AS consumo_minimo,
           COUNT(DISTINCT consumo)   AS consumos_distintos,
           COUNT(DISTINCT fecha_lec) AS fechas_distintas
      FROM w
     GROUP BY nro_cuenta, mes
    HAVING COUNT(*) > 1
)
SELECT (SELECT COUNT(*) FROM w)                                     AS filas_originales,
       (SELECT COUNT(*) FROM p)                                     AS filas_finales,
       (SELECT COUNT(*) FROM w) - (SELECT COUNT(*) FROM p)          AS filas_colapsadas,
       (SELECT COUNT(*)
          FROM (SELECT 1
                  FROM p
                 GROUP BY nro_cuenta, mes
                HAVING COUNT(*) > 1) dm)                            AS filas_de_mas,
       (SELECT COUNT(DISTINCT nro_cuenta) FROM p)                   AS cuentas,
       (SELECT COUNT(DISTINCT mes) FROM p)                          AS meses,
       (SELECT MIN(fecha_lec) FROM p)                               AS fecha_minima,
       (SELECT MAX(fecha_lec) FROM p)                               AS fecha_maxima,
       COUNT(*)                                                     AS grupos_duplicados,
       COUNT(*) FILTER (WHERE g.consumos_distintos > 1)              AS grupos_con_consumo_distinto,
       COUNT(*) FILTER (WHERE g.consumos_distintos > 1
                          AND pk.consumo = g.consumo_maximo)         AS colapso_al_alza,
       COUNT(*) FILTER (WHERE g.consumos_distintos > 1
                          AND pk.consumo = g.consumo_minimo)         AS colapso_a_la_baja,
       COUNT(*) FILTER (WHERE g.fechas_distintas = 1)                AS carga_duplicada,
       COUNT(*) FILTER (WHERE g.fechas_distintas > 1)                AS relecturas
  FROM g
  JOIN p pk ON pk.nro_cuenta = g.nro_cuenta AND pk.mes = g.mes;


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

-- 7.d DÓNDE CAE 1601 EN LA CADENA DE LA CUENTA 110589
--     La fila imposible es UNA SOLA —cuenta 110589, lec_actual 1601,
--     consumo 282, id_lectura 1308446—. Se ordena por `lec_actual` y
--     no por fecha, precisamente para que la fila mal fechada no se
--     escape al principio: lo que importa es EN QUÉ PUNTO DE LA
--     ÍNDICE se mete y qué lecturas la rodean.
SELECT fecha_lec, lec_actual, consumo, id_lectura
  FROM tfv_historico_lecturador
 WHERE nro_cuenta = 110589
 ORDER BY lec_actual;

-- 7.e ¿LA CUENTA 110589 TIENE LECTURA DE MAYO DE 2023?
--     Esta es la consulta que zanja. Se filtra por 2023, así que la
--     fila mal fechada QUEDA FUERA por construcción:
--       · SI LE FALTA MAYO —y 1601 cae en la serie entre las lecturas
--         de 2023—, ESA FILA ES LA DE MAYO DE 2023 con el año mal
--         escrito: FALTA EN EL PANEL y se decide P3.
--       · SI MAYO ESTÁ, la fila no es de 2023: es un resto ajeno y
--         solo hay que declararla.
--     AUTOCHEQUEO: contar las filas. Con 12 la cuenta tiene su año
--     completo y la fila imposible no le falta; con 11, le falta una.
SELECT fecha_lec, lec_actual, consumo, id_lectura,
       COUNT(*) OVER () AS filas_del_anio
  FROM tfv_historico_lecturador
 WHERE nro_cuenta = 110589
   AND fecha_lec >= DATE '2023-01-01'
   AND fecha_lec <  DATE '2024-01-01'
 ORDER BY fecha_lec;


-- 7.f LAS FILAS CON ÍNDICE CERO DENTRO DE LA VENTANA
--     Salió sin buscarla: al correr el 7.d apareció que la cuenta
--     110589 trae el 14/12/2025 con lec_actual = 0 y consumo =
--     948455, donde la cadena de la propia cuenta pide 59403 y
--     7858 —67166 menos 7763 da el cierre de diciembre, y 59403
--     menos 51545 da su consumo—.
--
--     NO CORRER ANTES QUE A2.3.b: no desbloquea nada (DEC-73, P4).
--     A2.3.b no filtra por consumo, así que esta fila no mueve
--     ninguno de los diez autocalculeos ni ningún punto del gate.
--
--     QUÉ DEBE DECIDIR: si es UN CASO AISLADO, se declara como
--     anomalía de una sola cuenta en las limitaciones. Si son
--     VARIAS, es una clase de suciedad —tercera después del año
--     0023 y de las manchas de 2000-2001— y hay que medirla antes
--     de calibrar θ, porque el techo de 242 alertas/mes se mide
--     contra consumos y estos dos números no lo son.
--
--     AUTOCHEQUEO: la cuenta 110589 tiene que aparecer con su fila
--     del 14/12/2025. Si no aparece, el filtro está mal escrito.
SELECT nro_cuenta,
       fecha_lec,
       lec_actual,
       consumo,
       id_lectura,
       COUNT(*) OVER () AS filas_con_indice_cero
  FROM tfv_historico_lecturador
 WHERE fecha_lec >= DATE '2022-01-01'
   AND fecha_lec <  DATE '2026-10-01'
   AND lec_actual = 0
 ORDER BY nro_cuenta, fecha_lec;

-- 7.g ¿CUÁNTAS CELDAS DEL PANEL GANA UNA FILA CON ÍNDICE CERO?
--     El 7.f dio 39 064 filas con lec_actual = 0 DENTRO de la ventana:
--     no es un caso aislado, es una clase. La rama del encabezado del
--     7.f que decía «si son varias, es una clase de suciedad» es la que
--     queda elegida.
--
--     NO BLOQUEABA A2.3.b —que no filtra por lec_actual—, pero SÍ
--     CONDICIONA θ: la calibración se hace sobre el consumo del panel,
--     y antes de fijar un umbral hay que saber cuántas celdas del
--     panel traen un consumo cuyo índice de contador es cero. El
--     alcance de DEC-79, punto 5, queda rectificado por DEC-81.
--
--     QUÉ MIDE, y por qué en este orden:
--       · celdas_indice_cero — cuántas celdas del panel quedaron
--         GANADAS por una fila con índice cero DESPUÉS del colapso.
--         Las 39 064 del 7.f son filas crudas; algunas se descartan al
--         colapsar, y solo las que mandan importan para θ.
--       · cuentas_afectadas y meses_afectados — si es un puñado de
--         cuentas o un fenómeno de toda la base, y si está repartido o
--         concentrado en uno o dos meses.
--       · el perfil de consumo de esas celdas contra el del resto.
--         Si los dos promedios son del mismo orden, el índice cero no
--         contamina el consumo y θ se calibra igual. Si el de las
--         celdas con índice cero se despega, no se calibra hasta que
--         se decida qué hacer con ellas.
--
--     AUTOCHEQUEO OBLIGATORIO: celdas_total DEBE dar 1 485 556, la
--     misma cifra que filas_finales del A2.3.b. Si no la da, la
--     construcción del panel está mal escrita aquí y no se interpreta
--     nada de esta salida.
--
--     LA DECISIÓN QUE ESTA SALIDA PREPARA QUEDA PENDIENTE A PROPÓSITO:
--     las opciones se registran en DEC-81 y no se eligen antes de ver
--     el dato, igual que hizo DEC-75 con P2.
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
)
SELECT COUNT(*)                                                   AS celdas_total,
       COUNT(*) FILTER (WHERE p.lec_actual = 0)                   AS celdas_indice_cero,
       COUNT(DISTINCT p.nro_cuenta)
              FILTER (WHERE p.lec_actual = 0)                     AS cuentas_afectadas,
       COUNT(DISTINCT p.mes)
              FILTER (WHERE p.lec_actual = 0)                     AS meses_afectados,
       MIN(p.mes) FILTER (WHERE p.lec_actual = 0)                 AS mes_minimo,
       MAX(p.mes) FILTER (WHERE p.lec_actual = 0)                 AS mes_maximo,
       ROUND(AVG(p.consumo) FILTER (WHERE p.lec_actual = 0), 1)   AS consumo_prom_cero,
       ROUND(AVG(p.consumo) FILTER (WHERE p.lec_actual <> 0), 1)  AS consumo_prom_resto,
       MIN(p.consumo) FILTER (WHERE p.lec_actual = 0)             AS consumo_min_cero,
       MAX(p.consumo) FILTER (WHERE p.lec_actual = 0)             AS consumo_max_cero
  FROM p;


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

-- 8.c LOS 5 619 MES A MES: DÓNDE SE PRODUCEN, NO SI HAY QUE ARREGLARLOS
--                     (26 oct 2026 — alcance cambiado por DEC-76, Q2 = (b))
--
--     QUÉ CAMBIÓ DESDE QUE SE ESCRIBIÓ: al principio esta consulta
--     servía para decidir si hacía falta una regla general de colapso.
--     La tesista respondió Q2 = (b): LA REGLA SE APLICA A TODOS LOS
--     MESES IGUAL, YA ESTÁ ESCRITA EN A2.3.b Y NO DEPENDE DE ESTA
--     SALIDA. Cambiar una regla por ver qué número sale sería
--     exactamente lo que la trazabilidad viene a evitar, y por eso la
--     regla se escribió antes de correr nada.
--
--     ENTONCES, PARA QUÉ SIRVE AHORA: para declarar la CAUSA en las
--     limitaciones con la distribución medida y no supuesta. La nota
--     de la tesista apunta a febrero de 2022 —cuando cargaron el
--     archivo de enero por error—, y 8.c dice si efectivamente está
--     ahí y si se queda solo en uno o dos meses. EL RESULTADO NO MUEVE
--     NINGUNA REGLA NI NINGÚN PANEL: entra a la tesis como hallazgo y
--     como explicación, y nada más.
--
--     AUTOCHEQUEO: la suma de cuentas_mes_duplicadas DEBE dar 5 619,
--         igual que 8.a y que A2.3.a. Si no da, una de las corridas
--         no es la misma.
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec) AS mes,
           consumo
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
d AS (
    SELECT nro_cuenta,
           mes,
           (COUNT(DISTINCT consumo) <= 1) AS consumo_identico
      FROM w
     GROUP BY nro_cuenta, mes
    HAVING COUNT(*) > 1
)
SELECT mes::date,
       COUNT(*)                                  AS cuentas_mes_duplicadas,
       COUNT(*) FILTER (WHERE consumo_identico)  AS consumo_identico,
       COUNT(*) FILTER (WHERE NOT consumo_identico) AS consumo_distinto
  FROM d
 GROUP BY mes
 ORDER BY mes;


-- =====================================================================
-- A2.3.c — LA REFERENCIA Y LA DESVIACIÓN, APLICADAS AL PANEL ENTERO
--                                  (28 oct 2026 — gate de E7c, punto 1)
--
--     QUÉ CIERRA. Es el autocalculeo de cierre del punto 1 del gate de
--     E7c. La fórmula está escrita en 07c_diseno_artefacto.md §3.1 con
--     las tres decisiones de DEC-90 dentro: mediana (P3 = b), cuatro
--     ciclos previos solo donde existen (P1 = a) y la restricción
--     referencia > 0, que era la que faltaba escrita.
--
--     LA FÓRMULA, EN TRES PASOS:
--       A. referencia(c,m) = mediana de los consumo de esa cuenta en
--          ese mismo mes de 2022, 2023, 2024 y 2025.
--          Con cuatro valores exactos, la mediana es el promedio de
--          los dos centrales ordenados.
--       B. desviacion(c,m) = ABS(consumo_observado - referencia)
--                            / referencia
--          solo para enero-septiembre de 2026.
--       C. CUATRO SALIDAS EXCLUYENTES, que cubren el panel entero:
--            1 valor calculado
--            2 declaracion A1  - le faltan ciclos previos
--            3 declaracion sin referencia - no positiva
--            4 declaracion fuera del universo de deteccion
--
--     CRITERIO FIJADO ANTES DE CORRER — no se ajusta después:
--       · "Tiene los cuatro ciclos" significa QUE EXISTE LA CELDA DE
--         ESA MISMA CUENTA EN ESE MISMO MES DE ESE AÑO. No se pide el
--         año completo: eso es el entregable 3.4 y sigue abierto. La
--         fórmula no lo necesita para aplicarse.
--       · "Le faltan ciclos" es ciclos_disponibles < 4, contado sobre
--         las celdas del panel, no sobre filas crudas.
--       · Lo que no recibe valor recibe DECLARACIÓN. No hay relleno
--         de ningún tipo, ni ceros ni promedios sustitutos.
--       · PERCENTILE_CONT(0.5) devuelve la media de los dos centrales
--         cuando hay cuatro valores pares, que es exactamente lo que
--         dice la fórmula de §3.1.
--
--     AUTOCALCUELOS DE CIERRE — los cuatro de §3.1:
--       1. suma_las_cuatro DEBE dar 1 485 556. Si no la da, la
--          clasificación no cubre el panel y no se interpreta nada.
--       2. diferencia_contra_el_panel DEBE dar 0. Es lo mismo que el
--          punto 1 visto al revés: ningún hueco, ningún solape.
--       3. diferencia_celdas_2026 DEBE dar 0. Ninguna celda de 2026
--          se pierde por filtro ni por un LEFT JOIN sin coincidencia.
--       4. con_valor + con_a1 + con_referencia_no_positiva DEBE dar
--          celdas_2026_en_el_panel. Las tres dentro del universo son
--          excluyentes y lo cubren todo.
--
--     AVISO SOBRE LOS DOS CAMPOS QUE USA: consumo y mes. No pide
--     ninguno que A2.3.b no traiga, que era la condición del
--     autocalculeo —aplicarse sin definir variables nuevas—.
--
--     LA TABLA ES VIVA: el panel se corre con cierre 2026-09-30
--     (DEC-69) y toda corrida lleva sello de fecha.
-- =====================================================================

-- A2.3.c SALIDA — las cuatro salidas, una fila por salida
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
clasif AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           p.consumo AS consumo_observado,
           r.ciclos_disponibles,
           r.referencia,
           CASE
             WHEN p.mes < DATE '2026-01-01'
               THEN '4 fuera del universo de deteccion'
             WHEN r.nro_cuenta IS NULL OR r.ciclos_disponibles < 4
               THEN '2 A1 - le faltan ciclos'
             WHEN r.referencia <= 0
               THEN '3 sin referencia - no positiva'
             ELSE '1 valor calculado'
           END AS salida,
           CASE
             WHEN p.mes >= DATE '2026-01-01'
              AND r.nro_cuenta IS NOT NULL
              AND r.ciclos_disponibles >= 4
              AND r.referencia > 0
               THEN ABS(p.consumo - r.referencia) / r.referencia
           END AS desviacion
      FROM p
      LEFT JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
)
SELECT salida,
       COUNT(*)                            AS celdas,
       COUNT(DISTINCT nro_cuenta)          AS cuentas,
       MIN(mes)::text                      AS mes_minimo,
       MAX(mes)::text                      AS mes_maximo,
       MIN(desviacion)                     AS desviacion_minima,
       MAX(desviacion)                     AS desviacion_maxima,
       ROUND(AVG(desviacion)::numeric, 6)  AS desviacion_media
  FROM clasif
 GROUP BY salida
 ORDER BY salida;


-- A2.3.c AUTOCALCUELO — los cuatro contra el panel
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
clasif AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           p.consumo AS consumo_observado,
           r.ciclos_disponibles,
           r.referencia,
           CASE
             WHEN p.mes < DATE '2026-01-01'
               THEN '4 fuera del universo de deteccion'
             WHEN r.nro_cuenta IS NULL OR r.ciclos_disponibles < 4
               THEN '2 A1 - le faltan ciclos'
             WHEN r.referencia <= 0
               THEN '3 sin referencia - no positiva'
             ELSE '1 valor calculado'
           END AS salida,
           CASE
             WHEN p.mes >= DATE '2026-01-01'
              AND r.nro_cuenta IS NOT NULL
              AND r.ciclos_disponibles >= 4
              AND r.referencia > 0
               THEN ABS(p.consumo - r.referencia) / r.referencia
           END AS desviacion
      FROM p
      LEFT JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
)
SELECT (SELECT COUNT(*) FROM p)                                                     AS celdas_panel,
       SUM(CASE WHEN salida = '1 valor calculado'                  THEN 1 ELSE 0 END) AS con_valor,
       SUM(CASE WHEN salida = '2 A1 - le faltan ciclos'           THEN 1 ELSE 0 END) AS con_a1,
       SUM(CASE WHEN salida = '3 sin referencia - no positiva'    THEN 1 ELSE 0 END) AS con_referencia_no_positiva,
       SUM(CASE WHEN salida = '4 fuera del universo de deteccion' THEN 1 ELSE 0 END) AS fuera_del_universo,
       COUNT(*)                                                                       AS suma_las_cuatro,
       COUNT(*) - (SELECT COUNT(*) FROM p)                                            AS diferencia_contra_el_panel,
       (SELECT COUNT(*) FROM p WHERE mes >= DATE '2026-01-01')                        AS celdas_2026_en_el_panel,
       SUM(CASE WHEN mes >= DATE '2026-01-01' THEN 1 ELSE 0 END)                      AS celdas_2026_clasificadas,
       SUM(CASE WHEN mes >= DATE '2026-01-01' THEN 1 ELSE 0 END)
         - (SELECT COUNT(*) FROM p WHERE mes >= DATE '2026-01-01')                    AS diferencia_celdas_2026,
       COUNT(DISTINCT nro_cuenta)                                                     AS cuentas
  FROM clasif;


-- =====================================================================
-- A2.3.d — EL LUGAR DE LAS CELDAS CON ÍNDICE CERO EN EL RANKING (P2)
--                                  (28 oct 2026 — gate de E7c, punto 2)
--
--     QUÉ RESUELVE. DEC-81, punto 5, dejó tres ramas abiertas sobre
--     las 38 969 celdas con lec_actual = 0 y advirtió que NO ESTABA
--     MEDIDO su lugar en el ranking de desviación porque para eso
--     hacía falta la referencia del ciclo anual, que es A2.3.c.
--     A2.3.c la acaba de producir, así que P2 se puede medir.
--
--     SALVEDAD ESCRITA ANTES DE CORRER — y cambia cómo se lee:
--       las 38 969 son una cifra de 57 MESES (DEC-86). La desviación
--       solo existe para los nueve de 2026, así que AQUÍ NO SE MIDE
--       AQUELLAS 38 969: se mide EL SUBCONJUNTO DE 2026 QUE CAE EN
--       "valor calculado". Si el subconjunto resulta chico, esa es en
--       sí una hallazgo y se declara, no se esconde.
--
--     CRITERIO FIJADO ANTES DE CORRER — no se ajusta después:
--       se comparan los dos grupos por SU MEDIANA de desviación,
--       porque la media se arrastraría con los extremos que midió
--       DEC-86 —mismo motivo por el que P3 eligió la mediana—.
--       Se considera que contaminan si la mediana del grupo con
--       índice cero es AL MENOS EL DOBLE de la del resto.
--       El factor 2 se fija aquí, con el mismo criterio de comparación
--       que usó el 7.g —«se despegan o no se despegan»—, y NO se
--       mueve después de ver la salida.
--       · menos de 2x  -> el índice cero no desplaza la distribución
--       · 2x o más     -> sí la desplaza
--       Las dos lecturas se llevan a la tesista con el dato en
--       pantalla para elegir entre (a), (b) y (c). EL UMBRAL NO ELIGE
--       LA RAMA: mide y para ahí.
-- =====================================================================

-- A2.3.d SALIDA — los dos grupos, sobre las desviaciones calculables
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
calculable AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           ABS(p.consumo - r.referencia) / r.referencia AS desviacion
      FROM p
      JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND p.mes <  DATE '2026-10-01'
       AND r.ciclos_disponibles >= 4
       AND r.referencia > 0
)
SELECT CASE
         WHEN lec_actual IS NULL THEN '3 indice nulo'
         WHEN lec_actual = 0     THEN '1 indice cero'
         ELSE                          '2 indice normal'
       END                                              AS grupo,
       COUNT(*)                                          AS celdas,
       COUNT(DISTINCT nro_cuenta)                        AS cuentas,
       ROUND((PERCENTILE_CONT(0.5)
              WITHIN GROUP (ORDER BY desviacion))::numeric, 6) AS mediana_desviacion,
       ROUND(MIN(desviacion)::numeric, 6)                AS minima,
       ROUND(MAX(desviacion)::numeric, 6)                AS maxima
  FROM calculable
 GROUP BY 1
 ORDER BY 1;


-- =====================================================================
-- A2.3.e — EL ÍNDICE DE CONTADOR EN LAS TRES SALIDAS DE 2026 (P2, cierre)
--                                  (28 oct 2026 — gate de E7c, punto 2)
--
--     POR QUÉ EXISTE. A2.3.d midió que las celdas con lec_actual = 0
--     tienen mediana de desviación 5,666667 contra 0,434783 del resto
--     —13,0 veces—, muy por encima del umbral de 2× fijado antes de
--     correr. PERO solo 541 celdas de ese grupo resultaron
--     calculables, y la propia salida no puede decir si esas 541 son
--     casi todas las celdas con índice cero de 2026 o una fracción
--     pequeña, porque el resto pudo caer en "2 A1" o en
--     "3 sin referencia", que A2.3.d descarta por construccion.
--
--     POR QUÉ NO SE ELIGE LA RAMA SIN ESTO. Elegir entre depurar y
--     declarar sobre un subconjunto de tamaño desconocido seria
--     decidir a medias. Si 541 son casi el total, la medicion de
--     A2.3.d es representativa y manda. Si el total de 2026 fuera,
--     digamos, seis mil, entonces 541 es el 9 % y la mediana de
--     A2.3.d describe a una minoria, no a la clase.
--
--     CRITERIO FIJADO ANTES DE CORRER:
--       · no se comparan medianas aqui; se CUENTA. Es un censo del
--         indice dentro del universo de 2026, y nada mas.
--       · las tres salidas y los tres grupos de indice son
--         excluyentes entre si, asi que la tabla tiene NUEVE filas
--         como maximo —no todas tienen por que existir—.
--       · el orden de lectura es por salida primero y por indice
--         despues, para que se vea de un vistazo donde se concentra
--         el indice cero.
--
--     AUTOCALCUEO OBLIGATORIO: la suma de `celdas` de las nueve
--     filas DEBE dar 264 384, la misma cifra que celdas_2026_en_el_panel
--     del A2.3.c. Si no la da, esta consulta filtro distinto y no se
--     interpreta.
-- =====================================================================

-- A2.3.e SALIDA — censo del indice de contador dentro del universo 2026
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
clasif AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           p.consumo AS consumo_observado,
           r.ciclos_disponibles,
           r.referencia,
           CASE
             WHEN p.mes < DATE '2026-01-01'
               THEN '4 fuera del universo de deteccion'
             WHEN r.nro_cuenta IS NULL OR r.ciclos_disponibles < 4
               THEN '2 A1 - le faltan ciclos'
             WHEN r.referencia <= 0
               THEN '3 sin referencia - no positiva'
             ELSE '1 valor calculado'
           END AS salida
      FROM p
      LEFT JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
)
SELECT salida,
       CASE
         WHEN lec_actual IS NULL THEN '3 indice nulo'
         WHEN lec_actual = 0     THEN '1 indice cero'
         ELSE                          '2 indice normal'
       END                        AS grupo_indice,
       COUNT(*)                   AS celdas,
       COUNT(DISTINCT nro_cuenta) AS cuentas
  FROM clasif
 WHERE mes >= DATE '2026-01-01'
   AND mes <  DATE '2026-10-01'
 GROUP BY 1, 2
 ORDER BY 1, 2;


-- =====================================================================
-- A2.3.f — DÓNDE APLICA LA DEPURACIÓN: EL HISTÓRICO, LA OBSERVADA, O LOS DOS
--                                  (28 oct 2026 — gate de E7c, punto 2)
--
--     POR QUÉ EXISTE. DEC-98 eligió la rama (a): se depura, y la
--     depuración es paso del método. Pero la regla todavía no está
--     escrita porque su alcance tiene dos lecturas y las dos cuestan
--     cosas distintas:
--       (i)  depurar SOLO la celda observada, la de 2026, dejando el
--            historial de 2022 a 2025 intacto;
--       (ii) depurar TAMBIEN el historial, sacando del ciclo previo
--            cualquier celda con lec_actual = 0.
--
--     POR QUÉ NO SE ELIGE A CIEGAS — DOS MOTIVOS MEDIDOS:
--       1. Con cuatro valores la mediana es (v2 + v3) / 2. UN ciclo
--          corrupto cae a la posicion 4 y no la toca —100, 110, 130,
--          59563 da 120—. DOS la destruyen —100, 110, 59563, 60000
--          da 29836—. La pregunta es de CONTEO, no de criterio.
--       2. Depurar el historial rompe la garantia de cuatro ciclos de
--          P1 = (a): una cuenta que pierde un ciclo cae en A1, que ya
--          lleva el 28,49 % del universo de 2026 (DEC-96).
--
--     CRITERIO FIJADO ANTES DE CORRER:
--       · se cuenta sobre el PANEL COLLAPSADO —p— y no sobre filas
--         crudas, igual que todo lo de A2.3.
--       · "corrupto" es lec_actual = 0. No se mira el consumo para
--         decidirlo: la regla es determinista y no admite umbral.
--       · "grupo" es (cuenta, mes_del_anio), que es la unidad sobre
--         la que se construye la referencia.
--       · "pierde los cuatro" es tener ciclos_disponibles >= 4 y
--         ciclos_disponibles - ciclos_corruptos < 4, o sea que la
--         limpieza baja el grupo por debajo del mínimo que exige
--         P1 = (a). Los grupos que YA empezaron con menos de cuatro
--         no se cuentan como perdidos: ya estaban en A1.
--
--     AUTOCALCUELOS:
--       1. sin_corrupcion + un_corrupto + dos_o_mas_corruptos DEBE dar
--          grupos_cuenta_mes. Los tres cubos son excluyentes.
--       2. celdas_indice_cero DEBE dar 36 211 — las 38 969 de DEC-86
--          menos las 2 758 del universo de 2026 que censo A2.3.e en
--          DEC-97. Es una comprobación CONTRA OTRA CORRIDA: si no da,
--          una de las dos medidas no es del mismo panel y se repiten
--          las dos seguidas antes de interpretar nada.
-- =====================================================================

-- A2.3.f SALIDA — el índice cero dentro del historial que construye la referencia
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           lec_actual
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
g AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*)                               AS ciclos_disponibles,
           COUNT(*) FILTER (WHERE lec_actual = 0) AS ciclos_corruptos
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
)
SELECT COUNT(*)                                                       AS grupos_cuenta_mes,
       SUM(ciclos_corruptos)                                          AS celdas_indice_cero,
       COUNT(*) FILTER (WHERE ciclos_corruptos = 0)                   AS sin_corrupcion,
       COUNT(*) FILTER (WHERE ciclos_corruptos = 1)                   AS un_corrupto,
       COUNT(*) FILTER (WHERE ciclos_corruptos >= 2)                  AS dos_o_mas_corruptos,
       COUNT(*) FILTER (WHERE ciclos_disponibles >= 4
                          AND ciclos_disponibles - ciclos_corruptos < 4) AS grupos_que_pierden_los_cuatro,
       COUNT(DISTINCT nro_cuenta) FILTER (WHERE ciclos_disponibles >= 4
                          AND ciclos_disponibles - ciclos_corruptos < 4) AS cuentas_afectadas,
       COUNT(DISTINCT nro_cuenta)                                     AS cuentas_en_el_historial
  FROM g;


-- =====================================================================
-- A2.3.g — LA REGLA DE DEPURACIÓN APLICADA: QUÉ SACA DEL CANAL HUMANO
--                                  (29 oct 2026 — gate de E7c, punto 2)
--
--     POR QUÉ EXISTE. DEC-100 fijó el ALCANCE de la depuración que
--     DEC-98 eligió como paso del método: (i) depurar SOLO la celda
--     observada, la de 2026, y NO el historial de 2022 a 2025. La (ii)
--     —depurar también el historial— se descartó tras medir su precio
--     en A2.3.f: movería 5 746 cuentas a A1, que es el 19,29 por
--     ciento de las 29 784 del historial, y la regla de A1 es el punto
--     4 de este gate y todavía no existe.
--
--     LA REGLA, ESCRITA ANTES DE APLICARSE:
--         Toda celda del universo 2026 con lec_actual = 0 se excluye
--         del cálculo de desviación y del listado de alertas; se
--         registran cuántas y de cuántas cuentas.
--         El historial de 2022 a 2025 NO se limpia.
--
--     CRITERIO FIJADO ANTES DE CORRER:
--       · "universo 2026" se toma con la MISMA definición que A2.3.c:
--         mes >= 2026-01-01, ciclos_disponibles >= 4 y referencia > 0,
--         o sea la salida que A2.3.c llamó "1 valor calculado". No se
--         redefine aquí: si se redefine, la comparación contra sus
--         183 541 no significa nada.
--       · "depurada" es lec_actual = 0. La misma regla determinista de
--         A2.3.f: no se mira el consumo y no hay umbral.
--       · "alertas por mes liberadas" divide entre 9 y no entre 12,
--         porque P1 = (a) acota la detección a enero-septiembre de
--         2026.
--       · el techo de referencia es 242 alertas al mes, fijado en
--         DEC-45 y DEC-54.
--
--     AUTOCALCUELOS:
--       1. celdas_depuradas + celdas_que_siguen DEBE dar
--          celdas_en_el_calculo. Los dos cubos son excluyentes y
--          cubren la salida entera.
--       2. celdas_en_el_calculo DEBE dar 183 541 —la salida "1 valor
--          calculado" de A2.3.c, DEC-96—. Si no da, esta consulta no
--          está midiendo el mismo universo que A2.3.c, y se repite
--          A2.3.c entera antes de interpretar nada.
--       3. celdas_depuradas DEBE dar 541 —el grupo con índice cero
--          dentro de "valor" del censo de A2.3.e, DEC-97—. Es la
--          tercera comprobación contra dos corridas anteriores.
--
--     LO QUE NO MIDE. No mide alertas: eso es E7b con θ. Mide
--     solamente CUÁNTO DEL CANAL HUMANO se devuelve al excluir estas
--     celdas, y eso es una cuenta de capacidad, no de detección.
-- =====================================================================

-- A2.3.g SALIDA — la regla aplicada al universo de detección
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
valor AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           p.consumo AS consumo_observado
      FROM p
      LEFT JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND r.nro_cuenta IS NOT NULL
       AND r.ciclos_disponibles >= 4
       AND r.referencia > 0
)
SELECT COUNT(*)                                                       AS celdas_en_el_calculo,
       COUNT(DISTINCT nro_cuenta)                                     AS cuentas_en_el_calculo,
       COUNT(*) FILTER (WHERE lec_actual = 0)                         AS celdas_depuradas,
       COUNT(DISTINCT nro_cuenta) FILTER (WHERE lec_actual = 0)       AS cuentas_depuradas,
       COUNT(*) FILTER (WHERE lec_actual <> 0)                        AS celdas_que_siguen,
       COUNT(DISTINCT nro_cuenta) FILTER (WHERE lec_actual <> 0)      AS cuentas_que_siguen,
       ROUND((COUNT(*) FILTER (WHERE lec_actual = 0)) / 9.0, 1)       AS alertas_mes_liberadas,
       ROUND(100.0 * (COUNT(*) FILTER (WHERE lec_actual = 0)) / 9.0 / 242.0, 1) AS por_ciento_del_techo
  FROM valor;


-- =====================================================================
-- A2.3.h — EJE 1: PERFIL DE CONSUMO POR CUENTA, SOBRE LOS 57 MESES
--                                  (29 oct 2026 — gate de E7c, punto 3)
--
--     POR QUÉ EXISTE. DEC-103 fijó el rol de la segmentación: (a)
--     caracterización previa que viaja con la alerta, sin cambiar qué
--     celdas alertan. R7.2 nombra dos ejes y este es el primero.
--
--     POR QUÉ 57 MESES Y NO LOS NUEVE. 07b §4.2, último párrafo:
--     «Los datos de segmentación no se acotan: siguen siendo los 57
--     meses. Se acota el paso de detección, no el panel.» El perfil
--     describe a la cuenta, no al mes que se evalúa.
--
--     CRITERIO FIJADO ANTES DE CORRER:
--       · unidad = cuenta (nro_cuenta), no celda.
--       · estadístico = MEDIANA del consumo mensual. Se elige la
--         mediana y no la media por lo mismo que P3 = (b) en DEC-90:
--         el panel tiene consumos desde -1 343 050 (DEC-86) y celdas
--         con índice cero que promedian 86,7 veces el resto (DEC-86),
--         y la media dejaría el perfil en manos de esas celdas.
--       · el panel se colapsa con la MISMA regla de A2.3.b: manda la
--         fecha más reciente y desempata id_lectura más alto. No se
--         redefine aquí.
--       · el CORTE de las bandas NO se ajusta a mano. Se propone una
--         REGLA mecánica —cuartiles— y los números que salgan son el
--         corte. Se cambia la regla antes de correr, no los números
--         después de haberlos visto.
--
--     AUTOCALCUELOS:
--       1. cuentas_perfil_positivo + cuentas_perfil_no_positivo DEBE
--          dar cuentas. Los dos cubos son excluyentes.
--       2. cuentas DEBE dar 30 411 —el panel verificado de A2.3.b,
--          DEC-80, y de A2.3.c, DEC-96—. Si no da, este panel no es
--          el mismo que clasificó A2.3.c y se repite A2.3.b antes de
--          interpretar nada.
--
--     LO QUE NO MIDE. No mide desviación ni alertas. Mide cómo está
--     distribuido el tamaño de las cuentas, y eso es lo que decide
--     dónde caen los cortes de las bandas de perfil.
-- =====================================================================

-- A2.3.h SALIDA — la mediana mensual por cuenta y su distribución
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
cuenta AS (
    SELECT nro_cuenta,
           COUNT(*)                                                          AS meses_observados,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo)              AS perfil_consumo
      FROM p
     GROUP BY nro_cuenta
)
SELECT COUNT(*)                                                          AS cuentas,
       COUNT(*) FILTER (WHERE perfil_consumo > 0)                        AS cuentas_perfil_positivo,
       COUNT(*) FILTER (WHERE perfil_consumo <= 0)                       AS cuentas_perfil_no_positivo,
       COUNT(*) FILTER (WHERE meses_observados < 12)                     AS cuentas_sin_doce_meses,
       ROUND(MIN(perfil_consumo)::numeric, 2)                            AS perfil_minimo,
       ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY perfil_consumo)::numeric, 2) AS corte_q1,
       ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY perfil_consumo)::numeric, 2) AS corte_q2,
       ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY perfil_consumo)::numeric, 2) AS corte_q3,
       ROUND(MAX(perfil_consumo)::numeric, 2)                            AS perfil_maximo
  FROM cuenta;


-- =====================================================================
-- A2.3.i — EJE 2: FAMILIA DE CÓDIGO EN EL UNIVERSO DE DETECCIÓN
--                                  (29 oct 2026 — gate de E7c, punto 3)
--
--     POR QUÉ EXISTE. DEC-103 fijó el rol de la segmentación, y R7.2
--     nombra dos ejes. Este es el segundo: familia de código.
--
--     CADENA DECLARADA ANTES DE BUSCAR (DEC-36):
--         tfv_lectura (id_lectura, tipo_lectura)
--             ^ tfv_historico_lecturador (id_lectura)
--     Las cuatro familias ya están definidas y no se inventan aquí:
--     consultas_base_datos.md L212-215 lista los 48 códigos repartidos
--     en 0 —LC, no facturada—, 1 —LN, lectura normal—, 2 —LE,
--     estimada— y 3 —NE, normal estimada— (02_delimitacion.md L14).
--
--     CRITERIO FIJADO ANTES DE CORRER:
--       · universo = la salida "1 valor calculado" de A2.3.c, la misma
--         que midió A2.3.g. No se redefine: si se redefine, la
--         comparación contra sus 183 541 no significa nada.
--       · "familia" es tfv_lectura.tipo_lectura de la LECTURA de esa
--         celda. Es la clasificación AETN, no la etiqueta con que se
--         marca "con código": esa regla la resolvió DEC-30 y dice que
--         tipo 1 es SIN código —99,12 %- y tipos 2 y 3 CON código
--         —0,88 %-. Aquí no se aplica esa regla, se miden las cuatro
--         familias tal como están.
--       · el JOIN es LEFT: una celda sin dato de tipo_lectura NO se
--         descarta, se cuenta aparte como f_sin_dato.
--
--     AUTOCALCUELOS:
--       1. f0 + f1 + f2 + f3 + f_sin_dato DEBE dar celdas_en_el_
--          calculo. Los cinco cubos son excluyentes y exhaustivos.
--       2. celdas_en_el_calculo DEBE dar 183 541 —A2.3.g, DEC-101—.
--          ESTE ES EL CONTROL DEL JOIN: si el JOIN multiplicara filas,
--          la cifra saldría MAYOR que 183 541 y la consulta entera se
--          tira sin interpretar nada.
--       3. celdas_con_tipo + f_sin_dato DEBE dar celdas_en_el_calculo.
--
--     LO QUE NO MIDE. No decide si el eje sirve como segmento: eso se
--     decide al ver si las cuatro familias están pobladas o si una
--     sola se queda con casi todo, que es lo que este censo dirá.
-- =====================================================================

-- A2.3.i SALIDA — el reparto de las celdas de detección por familia
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
valor AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.id_lectura
      FROM p
      LEFT JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND r.nro_cuenta IS NOT NULL
       AND r.ciclos_disponibles >= 4
       AND r.referencia > 0
)
SELECT COUNT(*)                                                       AS celdas_en_el_calculo,
       COUNT(*) FILTER (WHERE l.id_lectura IS NOT NULL)               AS celdas_con_tipo,
       COUNT(*) FILTER (WHERE l.tipo_lectura = 0)                     AS f0_no_facturada,
       COUNT(*) FILTER (WHERE l.tipo_lectura = 1)                     AS f1_normal_sin_codigo,
       COUNT(*) FILTER (WHERE l.tipo_lectura = 2)                     AS f2_estimada,
       COUNT(*) FILTER (WHERE l.tipo_lectura = 3)                     AS f3_normal_estimada,
       COUNT(*) FILTER (WHERE l.tipo_lectura IS NULL)                 AS f_sin_dato
  FROM valor v
  LEFT JOIN tfv_lectura l
    ON l.id_lectura = v.id_lectura;


-- =====================================================================
-- A2.3.j — LA PRUEBA DE ESTABILIDAD: ¿EL PERFIL ES PROPIEDAD DE LA
--           CUENTA O ES RUIDO?
--                                  (29 oct 2026 — gate de E7c, punto 3)
--
--     POR QUÉ EXISTE. El gate pide demostrar que el corte es razonable
--     y no una partición a conveniencia. A2.3.h ya resolvió la mitad
--     de esa exigencia: los cuartiles son una REGLA MECÁNICA fijada
--     antes de correr, así que ningún número se pudo ajustar después
--     de visto.
--
--     PERO ESO PRUEBA QUE EL CORTE NO ESTÁ HECHO A CONVENIENCIA, NO
--     QUE LA VARIABLE SEA REAL. Se puede repartir cualquier columna
--     en cuartiles y el reparto sale equitativo igualmente. Lo que
--     hace a un perfil útil como segmento es que la cuenta siga
--     estando en su banda de un periodo al otro; si cambia de banda
--     al azar, el perfil es ruido y la segmentación es decoración.
--
--     CÓMO SE PRUEBA. Se parte el panel en dos mitades —28 meses y
--     29—, se calcula el perfil de cada cuenta EN CADA MITAD POR
--     SEPARADO, se le asigna banda con los cuartiles DE ESA MISMA
--     mitad, y se mide cuántas cuentas conservan la banda.
--
--     CRITERIO DE RECHAZO FIJADO ANTES DE CORRER:
--       · Con cuatro bandas, el azar acierta el 25 % de las veces.
--       · Se exige un 50 % de conservación de banda, o sea el DOBLE
--         del azar, para aceptar que el perfil es propiedad de la
--         cuenta.
--       · SI NO SE ALCANZA, se declara: el perfil no es estable, la
--         segmentación se describe como caracterización no operativa
--         y NO se presenta ante el jurado como segmentación del
--         método. Se mide antes de escribir la regla, no después.
--       · Un dato no se trata de ninguna forma: los 999 976 del
--         máximo de A2.3.h siguen adentro, porque si el perfil es
--         real tiene que serlo también con la cola presente.
--
--     CRITERIO FIJADO ANTES DE CORRER SOBRE EL CORTE TEMPORAL:
--       · Mitad A = 2022-01 a 2024-04 (28 meses).
--       · Mitad B = 2024-05 a 2026-09 (29 meses).
--       · 28 + 29 = 57: se usa el panel entero, sin recortar.
--       · Las bandas de cada mitad se calculan CON LOS CUARTILES DE
--         ESA MISMA mitad, no con los de A2.3.h: cada mitad se juzga
--         con su propia escala, que es lo que hace la prueba justa.
--
--     AUTOCALCUELOS:
--       1. misma_banda + banda_adyacente + banda_lejana DEBE dar
--          cuentas_comparadas. Los tres cubos son exhaustivos.
--       2. cuentas_en_los_dos_periodos DEBE dar cuentas_comparadas:
--          el JOIN interno solo puede traer cuentas presentes en las
--          dos mitades.
--       3. cuentas_en_los_dos_periodos + cuentas_en_un_solo_periodo
--          DEBE dar cuentas_en_el_panel.
--       4. cuentas_en_el_panel DEBE dar 30 411 —A2.3.h, DEC-104—. Si
--          no da, este panel no es el mismo y se repite A2.3.h antes
--          de interpretar nada.
-- =====================================================================

-- A2.3.j SALIDA — la conservación de banda entre las dos mitades
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
mitad AS (
    SELECT nro_cuenta,
           consumo,
           CASE WHEN mes < DATE '2024-05-01' THEN 'A' ELSE 'B' END AS periodo
      FROM p
),
perfil AS (
    SELECT nro_cuenta,
           periodo,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS perfil_consumo
      FROM mitad
     GROUP BY nro_cuenta, periodo
),
cortes AS (
    SELECT periodo,
           PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY perfil_consumo) AS q1,
           PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY perfil_consumo) AS q2,
           PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY perfil_consumo) AS q3
      FROM perfil
     GROUP BY periodo
),
banda AS (
    SELECT pf.nro_cuenta,
           pf.periodo,
           CASE WHEN pf.perfil_consumo <= c.q1 THEN 1
                WHEN pf.perfil_consumo <= c.q2 THEN 2
                WHEN pf.perfil_consumo <= c.q3 THEN 3
                ELSE 4 END AS banda
      FROM perfil pf
      JOIN cortes c
        ON c.periodo = pf.periodo
),
cobertura AS (
    SELECT nro_cuenta, COUNT(*) AS periodos
      FROM banda
     GROUP BY nro_cuenta
),
par AS (
    SELECT a.nro_cuenta,
           a.banda AS banda_a,
           b.banda AS banda_b
      FROM banda a
      JOIN banda b
        ON b.nro_cuenta = a.nro_cuenta
     WHERE a.periodo = 'A'
       AND b.periodo = 'B'
)
SELECT (SELECT COUNT(*) FROM cobertura)                        AS cuentas_en_el_panel,
       (SELECT COUNT(*) FROM cobertura WHERE periodos = 2)     AS cuentas_en_los_dos_periodos,
       (SELECT COUNT(*) FROM cobertura WHERE periodos = 1)     AS cuentas_en_un_solo_periodo,
       COUNT(*)                                                AS cuentas_comparadas,
       COUNT(*) FILTER (WHERE banda_a = banda_b)               AS misma_banda,
       ROUND(100.0 * COUNT(*) FILTER (WHERE banda_a = banda_b) / COUNT(*), 1) AS por_ciento_misma_banda,
       COUNT(*) FILTER (WHERE ABS(banda_a - banda_b) = 1)      AS banda_adyacente,
       COUNT(*) FILTER (WHERE ABS(banda_a - banda_b) >= 2)     AS banda_lejana,
       ROUND(AVG(ABS(banda_a - banda_b))::numeric, 3)          AS desplazamiento_medio
  FROM par;


-- =====================================================================
-- A2.3.k — QUÉ CUENTA UN CICLO COMPLETO: ¿EXISTA EL MES O TENGA LAS 12?
--                                  (29 oct 2026 — gate de E7c, punto 4)
--
--     POR QUÉ EXISTE. Es la primera de las dos preguntas que §3.4 deja
--     abiertas. La fórmula de §3.1 está escrita y autocalculada, pero su
--     test es éste: para saber si una celda de 2026 tiene sus cuatro
--     ciclos previos basta con que exista la celda de ese mismo mes en
--     ese año (07c §3.1, nota de cierre). Un "ciclo anual completo"
--     podría exigir las 12 lecturas, y las dos definiciones NO dan el
--     mismo resultado.
--
--     LAS DOS DEFINICIONES, ESCRITAS ANTES DE MEDIR:
--       · DEFINICIÓN A —la vigente, la de §3.1—: un año cuenta para el
--         mes m si la cuenta TIENE el mes m en ese año.
--       · DEFINICIÓN B —la de 12—: un año cuenta para el mes m solo si
--         la cuenta TIENE LOS 12 MESES de ese año.
--
--     DOS CONSECUENCIAS QUE SE DEDUCEN ANTES DE CORRER y que la corrida
--     confirma o refuta:
--       · B es más exigente que A, de modo que B es SUBCONJUNTO de A:
--         ninguna celda puede tener valor bajo B sin tenerlo bajo A.
--         Eso es `lo_contrario_deberia_ser_cero`, que DEBE dar 0.
--       · Y cuando las dos dicen "valor", la referencia es la MISMA.
--         Si B da cuatro ciclos son los cuatro años 2022 a 2025
--         completos, o sea los mismos cuatro años que A contaría para
--         ese mes, así que la mediana sale de los mismos cuatro valores.
--         POR ESO NO SE REHACE LA REFERENCIA: se usa la de §3.1 tal
--         cual. Redefinirla sería reabrir el punto 1 del gate, cerrado
--         con DEC-90 y DEC-96.
--
--     CRITERIO FIJADO ANTES DE CORRER:
--       · Universo = el de §3.1: `mes >= 2026-01-01` y
--         `nro_cuenta IS NOT NULL`, o sea 264 384 celdas.
--       · Se cambia SOLO el test de ciclos. La restricción
--         `referencia > 0` queda idéntica en las dos definiciones.
--       · No se decide nada con este número: se mide primero y se
--         decide después, con la cifra a la vista.
--
--     AUTOCALCUELOS:
--       1. `valor_def_A` + `sin_referencia_def_A` + `a1_def_A` DEBE dar
--          `celdas_2026`.
--       2. `celdas_2026` DEBE dar 264 384 —A2.3.c, DEC-96—.
--       3. `valor_def_A` DEBE dar 183 541 —A2.3.c y A2.3.g, DEC-101—.
--          Si no da, este universo no es el mismo que clasificó A2.3.c y
--          se revisa antes de interpretar nada.
--       4. `sin_referencia_def_A` DEBE dar 5 524 —A2.3.c—.
--       5. `a1_def_A` DEBE dar 75 319 —A2.3.c—.
--       6. `valor_def_A` = `valor_def_B` + `pasan_a_a1`.
--       7. `lo_contrario_deberia_ser_cero` DEBE dar 0. ES LA
--          COMPROBACIÓN DEL RAZONAMIENTO DE ARRIBA: si diera más que 0,
--          la deducción "B es subconjunto de A" está mal y se para todo.
-- =====================================================================

-- A2.3.k SALIDA — las dos definiciones sobre el mismo universo
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           mes,
           EXTRACT(YEAR  FROM mes)::int AS anio,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref_A AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
anos_completos AS (
    SELECT nro_cuenta, anio
      FROM hist
     GROUP BY nro_cuenta, anio
    HAVING COUNT(DISTINCT mes_del_anio) = 12
),
cob AS (
    SELECT nro_cuenta, COUNT(*) AS anos_completos
      FROM anos_completos
     GROUP BY nro_cuenta
),
clasif AS (
    SELECT p.nro_cuenta,
           p.mes,
           COALESCE(rA.ciclos_disponibles, 0) AS ciclos_A,
           COALESCE(rA.referencia, 0)         AS referencia_A,
           COALESCE(cob.anos_completos, 0)    AS ciclos_B
      FROM p
      LEFT JOIN ref_A rA
        ON rA.nro_cuenta   = p.nro_cuenta
       AND rA.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
      LEFT JOIN cob
        ON cob.nro_cuenta  = p.nro_cuenta
     WHERE p.mes >= DATE '2026-01-01'
       AND p.nro_cuenta IS NOT NULL
)
SELECT COUNT(*)                                                     AS celdas_2026,
       COUNT(*) FILTER (WHERE ciclos_A >= 4 AND referencia_A > 0)   AS valor_def_A,
       COUNT(*) FILTER (WHERE ciclos_A >= 4 AND referencia_A <= 0)  AS sin_referencia_def_A,
       COUNT(*) FILTER (WHERE ciclos_A <  4)                        AS a1_def_A,
       COUNT(*) FILTER (WHERE ciclos_B >= 4 AND referencia_A > 0)   AS valor_def_B,
       COUNT(*) FILTER (WHERE ciclos_A >= 4 AND referencia_A > 0
                          AND ciclos_B <  4)                        AS pasan_a_a1,
       COUNT(*) FILTER (WHERE ciclos_B >= 4 AND referencia_A > 0
                          AND ciclos_A <  4)                        AS lo_contrario_deberia_ser_cero
  FROM clasif;


-- =====================================================================
-- A2.3.k2 — LAS CUATRO ANTES DE LA DECISIÓN, CUÉNTANSE POR CUENTA
--                                  (29 oct 2026 — gate de E7c, punto 4)
--
--     POR QUÉ EXISTE. `A2.3.k` decide cuántas CELDAS se mueven; ésta
--     dice cuántas CUENTAS se quedan sin cuatro años completos, que es
--     como `R8.1` está escrita —"las cuentas con menos de cuatro
--     ciclos"— y como `07a` L159 lo formula: "A1 opera solo cuando no
--     hay cuatro ciclos".
--
--     CRITERIO FIJADO ANTES DE CORRER:
--       · Un año es COMPLETO si la cuenta tiene los 12 meses de ese año
--         en el panel colapsado —la misma regla de colapso de A2.3.b,
--         sin redefinir—.
--       · Se cuenta sobre los cuatro años de referencia 2022 a 2025,
--         porque de ellos depende poder calcular `referencia` para 2026.
--       · Cuentas sin año completo entran con 0 y no se descartan.
--
--     AUTOCALCUELOS:
--       1. Los cinco recuentos DEBEN sumar `cuentas_en_el_panel`.
--       2. `cuentas_en_el_panel` DEBE dar 30 411 —A2.3.h, DEC-104—.
-- =====================================================================

-- A2.3.k2 SALIDA — años completos por cuenta
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(YEAR  FROM mes)::int AS anio,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
anos_completos AS (
    SELECT nro_cuenta, anio
      FROM hist
     GROUP BY nro_cuenta, anio
    HAVING COUNT(DISTINCT mes_del_anio) = 12
),
cob AS (
    SELECT nro_cuenta, COUNT(*) AS anos_completos
      FROM anos_completos
     GROUP BY nro_cuenta
),
cuentas AS (
    SELECT DISTINCT nro_cuenta
      FROM p
),
t AS (
    SELECT COALESCE(cob.anos_completos, 0) AS anos
      FROM cuentas c
      LEFT JOIN cob
        ON cob.nro_cuenta = c.nro_cuenta
)
SELECT COUNT(*)                   AS cuentas_en_el_panel,
       COUNT(*) FILTER (WHERE anos = 4) AS con_cuatro_años_completos,
       COUNT(*) FILTER (WHERE anos = 3) AS con_tres,
       COUNT(*) FILTER (WHERE anos = 2) AS con_dos,
       COUNT(*) FILTER (WHERE anos = 1) AS con_uno,
       COUNT(*) FILTER (WHERE anos = 0) AS con_cero
  FROM t;


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

-- A2.4.3 [RETIRADO — DEC-82, 27 oct 2026] Correcciones manuales por mes.
--        NO SE REFORMULA Y NO SE EJECUTA. Tres motivos, y ninguno de
--        ellos es «ya está verificado en DEC-24»:
--          (a) su forma a nivel de registro está MUERTA, no bloqueada:
--              el rótulo anterior decía [BLOQUEADO por B2], incorrecto
--              dos veces — B2 está cerrado, y quien lo mató fue DEC-53,
--              que cerró la vía tfv_cobranza.consumo contra
--              tfv_historico_lecturador.consumo al cumplirse el criterio
--              que quedó fijado ANTES de correr;
--          (b) su forma agregada sería una tautología: la Prueba 2 de
--              consultas_base_datos.md ya hace esa extracción y se
--              reverificó el 6 oct con script, diez de diez;
--          (c) nada espera en él: el criterio 3 está fijado y volcado a
--              02_delimitacion.md desde DEC-54.
--
--        LO QUE LA RETIRADA NO CIERRA, Y POR QUÉ NO SE DEJA VACÍO:
--        `lecturas_diferentes` sigue sin definición, y sobre ella se
--        apoyan tres cosas — el criterio 3 (02_delimitacion L50),
--        06_diagnostico L78 y 07a_alternativas L63, que mide sobre esa
--        columna el efecto de una alternativa. El sustituto se llama
--        «definición de lecturas_diferentes» y NO ES SQL: es una consulta
--        a quien elaboró la hoja historico de DATOS desde 2022.xlsx. La
--        hoja no tiene una sola fórmula y no nombra el segundo campo, así
--        que nadie que solo lea el archivo puede responderlo.
--        QUIEN LA ELABORÓ: ENDE —declarado por la tesista el 27 oct 2026,
--        DEC-83—. La consulta ya está redactada y SIN ENVIAR, en
--        00_estado.md §Preguntas abiertas. Pregunta cuatro cosas, entre
--        ellas el defecto de abril de 2025 (28 556 contra 28 554).
--        NO bloquea el gate de E7b: 242,2 = 2 180 / 9 no usa
--        total_lecturas, así que ni el 185 ni el 2 la mueven.
--
--        CONSULTA ORIGINAL, CONSERVADA COMO REGISTRO — NO EJECUTAR:
-- SELECT DATE_TRUNC('month', <FECHA_FACTURACION>)::date AS mes,
--        COUNT(*)
-- FROM <TABLA_FACTURADA> f
-- JOIN tfv_historico_lecturador h ON h.id_lectura = f.id_lectura  -- clave por confirmar
-- WHERE f.lectura_facturada <> h.lec_actual
--   AND <FECHA_FACTURACION> >= DATE '2022-01-01'
-- GROUP BY 1;
--        Esperado en su día: 1 507/mes ene-may 2025, 295/mes jun-dic
--        2025 y 242,2/mes en 2026 — las tres reproducidas ya desde la
--        hoja, por Prueba 2 y por verificación propia.


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
--      EJECUTADO EL 20 OCT 2026 (DEC-48 y DEC-49). Control 1, cardinalidad
--      de tfv_lec_irregular: max_codigos_por_lectura = 1 y
--      lecturas_con_varios = 0, o sea 1:1 con la lectura. Control 2,
--      reproducción desde la base de 0,88 % y 99,12 %: 177 784 ·
--      1 377 641 · 12 300 · 1 389 941 · 1 567 725, LAS CINCO CUADRADAS.
--      0.7.b dio que el tipo 1 sale solo con «sin codigo» y «codigo 0»,
--      de modo que la salvedad de DEC-30 quedó CERRADA y las dos cifras
--      quedan sostenidas por el cruce y no solo por la declaración.
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
--      Lo resolvía el 0.6.e (tres queries, ver arriba). RESULTADO: el
--      0.6.e.1 y el 0.6.e.2 cerraron el 20 oct (DEC-48), el 0.6.e.3
--      resultó inválido —el JOIN multiplicó 1 376 filas— y lo sustituyó
--      el CONTROL 4 (DEC-51), y la vía por consumo CERRÓ en DEC-53.
--      CON ESO A2.4.3 QUEDÓ RETIRADO (DEC-82), NO BLOQUEADO: B2 cerró a
--      nivel agregado desde DEC-24 — 242,2 = 2 180/9 y 800,3 = 9 604/12,
--      reproducibles desde la hoja historico— y a nivel de registro quedó
--      como RUTA MUERTA DOCUMENTADA, probada con dato. Regla que valió en
--      DEC-36 y siguió valiendo: con una lista de esquema incompleta no
--      se deduce nada y se pregunta.
--      LO QUE SIGUE ABIERTO NO PERTENECE A ESTE BLOQUE: se llama
--      «definición de lecturas_diferentes» y es una consulta a quien
--      elaboró la hoja, no una consulta SQL.
--
-- [B3] CERRADO: NO EQUIVALEN (DEC-59, 22 oct 2026), y el campo fue
--      localizado el 24 oct 2026 (DEC-61): sw_procendente está en
--      tfv_respuesta_reclamo, enlazada con tfv_reclamo por id_reclamo.
--      sw_proceso es OTRO campo, binario, y no lo sustituye.
--      El recuento reproducible desde la base está en CONTROL 5.j;
--      la cardinalidad, en CONTROL 5.i.
-- =====================================================================


-- =====================================================================
-- A2.3.l — LA CALIBRACIÓN DE θ PARA A2: EL UMBRAL EN EL CORTE DE 218
--                                  (30 oct 2026 — gate de E7b, punto 3)
--
--     QUÉ CIERRA. Es el punto 3 del gate de E7b —el último—, y con él
--     el gate queda en 4 de 4. 07b_requisitos.md §4.2 fija el
--     procedimiento en OCHO pasos desde DEC-114: pasos 1 a 5 para A2
--     sobre su cupo de 218, y pasos 6 a 8 para A1 sobre su cupo de 24.
--     ESTA CONSULTA ES LOS PASOS 1 A 5. Los 6 a 8 están en A2.3.m.
--
--     LOS PASOS QUE EJECITA, TAL COMO ESTÁN ESCRITOS:
--       1. desviacion(c,m) = ABS(consumo_observado - referencia)
--                            / referencia, para cada cuenta y cada mes
--                            de 2026 —enero a septiembre—, tomando
--                            referencia como la MEDIANA de esa cuenta
--                            en ese mismo mes de 2022 a 2025 (DEC-90,
--                            P3 = (b)).
--       2. Ordenarlas de mayor a menor.
--       3. Recorrer el orden hasta acumular 218 alertas por mes —el
--          cupo de A2, R2.5, fijado en DEC-114—.
--       4. θ_A2 es el valor en el corte.
--       5. Verificar que θ_A2 es único y estable entre los nueve
--          meses; si variara, se fija como el MÁXIMO —el más
--          estricto— y se declara. Ese era el paso 5 original.
--
--     LOS CUATRO FILTROS DEL UNIVERSO, Y DE DÓNDE SALE CADA UNO:
--       · mes >= 2026-01-01 —DEC-90, P1 = (a): la detección corre
--         sobre enero-septiembre de 2026 y NO sobre los 48 meses de
--         2022 a 2025, que tampoco reciben desviación—.
--       · ciclos_disponibles >= 4 —DEC-111, definición A: un año
--         cuenta si la cuenta TIENE ese mes. Lo que no lo tiene va a
--         A1 y NO ESTÁ AQUÍ: son salidas excluyentes—.
--       · referencia > 0 —DEC-90, P3 = (b): sin referencia positiva
--         no hay cociente, y esa celda recibe declaración, no valor.
--       · lec_actual <> 0 —DEC-100 y DEC-101: la depuración excluye
--         del cálculo de desviación toda celda observada de 2026 con
--         índice de contador cero. **541 celdas de 411 cuentas.** Es
--         el único filtro de este bloque que ya estaba medido—.
--
--     AUTOCALCUELOS — escritos ANTES de correr, y son la condición
--     para interpretar cualquier cosa que salga. Ninguno es una suma
--     interna: los tres primeros comparan contra corridas anteriores.
--       1. celdas_en_el_calculo DEBE dar **183 000**. Es 183 541 —la
--          salida "1 valor calculado" de A2.3.c, DEC-96— menos las 541
--          depuradas de A2.3.g, DEC-101. Si no la da, esta consulta no
--          está midiendo el universo de detección, y se repite A2.3.g
--          entera antes de mirar θ.
--       2. celdas_depuradas DEBE dar **541** y cuentas_depuradas
--          DEBE dar **411** —DEC-101—. Es la tercera comprobación
--          contra una corrida independiente.
--       3. **218 + 24 = 242** —DEC-114, ya verificado antes de
--          escribirlo—. Los dos cupos suman el techo de R2.1 sin
--          sobrante ni faltante. R2.1 no se toca aquí.
--       4. Cada mes DEBE tener **218 celdas o más**. Con 183 000
--          sobre nueve meses el promedio es ≈ 20 333, de modo que el
--          margen es de dos órdenes de magnitud. Si un mes diera
--          menos de 218, el corte NO EXISTE para ese mes: se declara
--          y no se rellena.
--       5. alertas_que_alertarian PUEDE superar 218 cuando haya
--          empates justo en el corte. Se reporta y NO se corrige: θ
--          se fija en la posición 218 y los empates entran por
--          desempate determinista —nro_cuenta—. Es la misma
--          conducta que en A2.3.b con el colapso.
--
--     LO QUE NO HACE. No fija θ_A1 —eso es A2.3.m—; no decide el
--     reparto, que DEC-114 ya fijó en 218 + 24; y no toca R2.1, que
--     sigue en 242 y sigue inviolable: no se dividió el techo, se
--     dividió el derecho a emitir dentro de él.
-- =====================================================================

-- A2.3.l SALIDA 1 — θ por cada uno de los nueve meses
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
valor AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.consumo AS consumo_observado,
           r.referencia,
           ABS(p.consumo - r.referencia) / r.referencia AS desviacion
      FROM p
      LEFT JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND r.nro_cuenta IS NOT NULL
       AND r.ciclos_disponibles >= 4
       AND r.referencia > 0
       AND p.lec_actual <> 0
),
orden AS (
    SELECT nro_cuenta,
           mes,
           desviacion,
           ROW_NUMBER() OVER (PARTITION BY mes
                              ORDER BY desviacion DESC, nro_cuenta) AS posicion
      FROM valor
),
corte AS (
    SELECT mes,
           MAX(desviacion) FILTER (WHERE posicion = 218) AS theta_mes
      FROM orden
     GROUP BY mes
)
SELECT o.mes,
       COUNT(*)                                            AS celdas_en_el_mes,
       c.theta_mes                                         AS theta_de_ese_mes,
       COUNT(*) FILTER (WHERE o.posicion <= 218)           AS alertas_por_cupo,
       COUNT(*) FILTER (WHERE o.desviacion >= c.theta_mes) AS alertas_que_alertarian
  FROM orden o
  JOIN corte c ON c.mes = o.mes
 GROUP BY o.mes, c.theta_mes
 ORDER BY o.mes;


-- A2.3.l SALIDA 2 — los autocalculeos y θ_A2, en una sola fila
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
ref AS (
    SELECT nro_cuenta,
           mes_del_anio,
           COUNT(*) AS ciclos_disponibles,
           PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY consumo) AS referencia
      FROM hist
     GROUP BY nro_cuenta, mes_del_anio
),
dep AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           ABS(p.consumo - r.referencia) / r.referencia AS desviacion
      FROM p
      LEFT JOIN ref r
        ON r.nro_cuenta   = p.nro_cuenta
       AND r.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND r.nro_cuenta IS NOT NULL
       AND r.ciclos_disponibles >= 4
       AND r.referencia > 0
),
valor AS (
    SELECT * FROM dep WHERE lec_actual <> 0
),
orden AS (
    SELECT nro_cuenta, mes, desviacion,
           ROW_NUMBER() OVER (PARTITION BY mes
                              ORDER BY desviacion DESC, nro_cuenta) AS posicion
      FROM valor
),
meses AS (
    SELECT mes, MAX(desviacion) FILTER (WHERE posicion = 218) AS theta_mes
      FROM orden
     GROUP BY mes
)
SELECT (SELECT COUNT(*) FROM dep)                                   AS celdas_antes_de_depurar,
       (SELECT COUNT(*) FROM dep WHERE lec_actual = 0)              AS celdas_depuradas,
       (SELECT COUNT(DISTINCT nro_cuenta) FROM dep WHERE lec_actual = 0) AS cuentas_depuradas,
       (SELECT COUNT(*) FROM valor)                                 AS celdas_en_el_calculo,
       (SELECT COUNT(DISTINCT nro_cuenta) FROM valor)               AS cuentas_en_el_calculo,
       (SELECT COUNT(*) FROM meses)                                 AS meses_medidos,
       (SELECT MIN(celdas) FROM (SELECT COUNT(*) AS celdas FROM orden GROUP BY mes) t)
                                                                     AS celdas_minimas_en_un_mes,
       (SELECT MIN(theta_mes) FROM meses)                           AS theta_minimo,
       (SELECT MAX(theta_mes) FROM meses)                           AS theta_A2,
       (SELECT COUNT(DISTINCT theta_mes) FROM meses)                AS theta_valores_distintos;


-- =====================================================================
-- A2.3.m — LA CALIBRACIÓN DE θ PARA A1: EL UMBRAL EN EL CORTE DE 24
--                                  (30 oct 2026 — gate de E7b, punto 3)
--
--     QUÉ ES. Los PASOS 6 A 8 de 07b_requisitos.md §4.2. A1 es la
--     contingencia por historial corto: recoge las celdas de 2026 que
--     le faltan ciclos previos, que bajo la definición A de DEC-111
--     son **75 319 celdas —el 28,5 % del panel—** (DEC-110). A1 fue
--     descartada como ALTERNATIVA en E7a (DEC-70) y sobrevive como
--     REGLA DE CONTINGENCIA, porque R8.1 promete que ninguna cuenta
--     queda sin cobertura.
--
--     LOS PASOS QUE EJECITA:
--       6. Calcular la desviación de A1 para cada celda que entró a
--          ella —ciclos < 4—, contra la MEDIA DE LOS SEIS MESES
--          ANTERIORES, en ambas direcciones:
--          ABS(consumo - media_6meses) / media_6meses.
--          *Regla traída de 07a L85-L87, donde ya estaba escrita y
--          nunca se había llevado al diseño.*
--       7. Ordenarlas de mayor a menor y recorrer hasta acumular 24
--          alertas por mes —el cupo de A1, R2.5, DEC-114—.
--       8. θ_A1 es el valor en el corte, y se somete a la misma
--          verificación de unicidad y estabilidad del paso 5.
--
--     LAS DOS DECISIONES DEL 30 OCT 2026 QUE ESTE PASO 6 ASUMÍA SIN
--     VERIFICAR, AMBAS CON SU TEXTO ORIGINAL CONSERVADO EN 07b:
--
--     [DEC-115] VENTANA INCOMPLETA — la tesista eligió (a).
--       "La media de los seis meses anteriores" supone que la cuenta
--       tiene seis meses previos. A1 existe precisamente para cuentas
--       NUEVAS —07a L159—, que pueden no tenerlos. La regla es:
--           Se usan los meses previos que EXISTAN, hasta un máximo
--           de 6. Una cuenta con dos meses previos se compara contra
--       la media de esos dos y sigue siendo alertable.
--       TEXTO ORIGINAL DEL PASO 6, CONSERVADO: *"contra la media de
--       los seis meses anteriores"*.
--       Por qué no (b) —exigir los seis completos, y sin desviación
--       si faltan—: habría incumplido R8.1◆F, "ningún mes queda sin
--       cobertura", vaciando por dentro el requisito que DEC-114 acaba
--       de proteger con la reserva de cupo. Y por qué no (c) —medir
--       primero—: el hueco ya estaba identificado y documentado en
--       07c §3.4, y la regla exigida por R8.1 era inequívoca.
--
--     [DEC-116] CELDAS DEPURADAS DENTRO DE LA VENTANA — eligió (a).
--       DEC-100 y DEC-101 depuraron 541 celdas con lec_actual = 0 de
--       la celda OBSERVADA de 2026, y declararon que el histórico
--       queda intacto. Pero la ventana de A1 USA el histórico: la
--       media se calcula sobre meses previos. La regla es:
--           Las celdas con lec_actual = 0 NO entran en el cálculo de
--           la media de los seis meses previos.
--       TEXTO ORIGINAL DEL PASO 6, CONSERVADO: *"la media de los seis
--       meses anteriores"*.
--       Fundamento medido: el consumo de las celdas con lectura es
--       **86,7 veces mayor**, de modo que dejar las de índice cero
--       dentro arrastraría la media hacia cero y dispararía
--       desviaciones artificiales —el método alertaría por arte del
--       cero y no por anomalía real.
--       LO QUE SE DECLARA Y NO SE DISIMULA: DEC-101 protegió el
--       histórico de la DEPURACIÓN, y aquí se excluye del CÁLCULO de
--       una media. No es la misma operación, pero sí es un segundo
--       efecto sobre el mismo dato, y por eso queda escrito en §10 de
--       la propuesta junto a la carencia por año de DEC-111.
--
--     LA REGLA ADICIONAL QUE HACÍA FALTA ESCRIBIR — media > 0.
--       El paso 6 divide por media_6meses. Si una cuenta tuviera
--       cero consumo en todos los meses previos disponibles, la media
--       daría cero y el cociente no existe. Se aplica la MISMA regla
--       que ya gobierna a A2 con referencia > 0 (DEC-90):
--           media_6meses > 0 para recibir desviación; si no,
--           declaración. No hay relleno de ningún tipo.
--
--     EXTENSIÓN DE LA DEPURACIÓN A LA CELDA OBSERVADA DE A1 —
--     regla escrita ANTES de correr, con su número declarado después.
--       DEC-100 y DEC-101 acotaron su conteo a la salida "1 valor
--       calculado", donde midieron 541. El principio decidido es que
--       UNA CELDA SIN LECTURA NO TIENE CONSUMO OBSERVABLE y por tanto
--       no puede producir desviación. Ese principio se aplica aquí
--       también. **El número dentro de A1 NO ESTÁ MEDIDO**, y esta
--       consulta lo devuelve como celdas_depuradas_a1. Si diera cero,
--       la extensión no movió nada y eso también es un resultado; si
--       diera más que cero, esa cifra se declara.
--
--     AUTOCALCUELOS — escritos ANTES de correr:
--       1. a1_celdas_antes_de_depurar DEBE dar **75 319** —DEC-110,
--          definición A sobre las 264 384 celdas de 2026—. Si no la
--          da, esta consulta clasificó A1 de otra manera que la de
--          A2.3.c y se repite esa antes de mirar θ.
--       2. **218 + 24 = 242** —DEC-114—. El cupo de A1 es 24 y no
--          puede mudarse sin reabrir §4.2.
--       3. Cada mes DEBE tener **24 celdas o más con media
--          calculable**. Con ≈ 8 369 celdas A1 por mes —75 319/9— el
--          margen es grande; si un mes diera menos de 24, el corte NO
--          EXISTE para ese mes y se declara.
--       4. meses_previos_disponibles DEBE devolver valores entre
--          **1 y 6**. Un 0 significa que la cuenta no tiene ningún mes
--          previo: esa celda va a declaración y no a desviación, y se
--          cuenta en a1_sin_ventana.
--       5. Reconciliación contra el panel: las 264 384 celdas de 2026
--          de A2.3.c se reparten en 183 541 con valor —de las que 541
--          se depuran—, 5 524 sin referencia positiva y 75 319 en A1.
--          Esta consulta no reabre esa partición: la respeta.
-- =====================================================================

-- A2.3.m SALIDA 1 — θ_A1 por cada uno de los nueve meses
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
cic AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           COUNT(*) AS ciclos_disponibles
      FROM hist
     GROUP BY nro_cuenta, EXTRACT(MONTH FROM mes)::int
),
a1 AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           p.consumo AS consumo_observado
      FROM p
      LEFT JOIN cic c
        ON c.nro_cuenta   = p.nro_cuenta
       AND c.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND (c.nro_cuenta IS NULL OR c.ciclos_disponibles < 4)
),
ventana AS (
    SELECT a.nro_cuenta,
           a.mes,
           a.lec_actual,
           a.consumo_observado,
           COUNT(h2.consumo) AS meses_previos_disponibles,
           AVG(h2.consumo)   AS media_6meses
      FROM a1 a
      LEFT JOIN p h2
        ON h2.nro_cuenta = a.nro_cuenta
       AND h2.mes >= (a.mes - INTERVAL '6 months')::date
       AND h2.mes <  a.mes
       AND h2.lec_actual <> 0
     GROUP BY a.nro_cuenta, a.mes, a.lec_actual, a.consumo_observado
),
dev AS (
    SELECT nro_cuenta,
           mes,
           consumo_observado,
           meses_previos_disponibles,
           media_6meses,
           ABS(consumo_observado - media_6meses) / media_6meses AS desviacion
      FROM ventana
     WHERE meses_previos_disponibles >= 1
       AND media_6meses > 0
       AND lec_actual <> 0
),
orden AS (
    SELECT nro_cuenta,
           mes,
           desviacion,
           ROW_NUMBER() OVER (PARTITION BY mes
                              ORDER BY desviacion DESC, nro_cuenta) AS posicion
      FROM dev
),
corte AS (
    SELECT mes,
           MAX(desviacion) FILTER (WHERE posicion = 24) AS theta_mes
      FROM orden
     GROUP BY mes
)
SELECT o.mes,
       COUNT(*)                                            AS celdas_en_el_mes,
       c.theta_mes                                         AS theta_de_ese_mes,
       COUNT(*) FILTER (WHERE o.posicion <= 24)            AS alertas_por_cupo,
       COUNT(*) FILTER (WHERE o.desviacion >= c.theta_mes) AS alertas_que_alertarian
  FROM orden o
  JOIN corte c ON c.mes = o.mes
 GROUP BY o.mes, c.theta_mes
 ORDER BY o.mes;


-- A2.3.m SALIDA 2 — los autocalculeos y θ_A1, en una sola fila
WITH w AS (
    SELECT nro_cuenta,
           DATE_TRUNC('month', fecha_lec)::date AS mes,
           fecha_lec,
           lec_actual,
           consumo,
           id_lectura
      FROM tfv_historico_lecturador
     WHERE fecha_lec >= DATE '2022-01-01'
       AND fecha_lec <  DATE '2026-10-01'
),
p AS (
    SELECT DISTINCT ON (nro_cuenta, mes)
           nro_cuenta, mes, fecha_lec, lec_actual, consumo, id_lectura
      FROM w
     ORDER BY nro_cuenta, mes, fecha_lec DESC, id_lectura DESC
),
hist AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           consumo
      FROM p
     WHERE mes >= DATE '2022-01-01'
       AND mes <  DATE '2026-01-01'
),
cic AS (
    SELECT nro_cuenta,
           EXTRACT(MONTH FROM mes)::int AS mes_del_anio,
           COUNT(*) AS ciclos_disponibles
      FROM hist
     GROUP BY nro_cuenta, EXTRACT(MONTH FROM mes)::int
),
a1 AS (
    SELECT p.nro_cuenta,
           p.mes,
           p.lec_actual,
           p.consumo AS consumo_observado
      FROM p
      LEFT JOIN cic c
        ON c.nro_cuenta   = p.nro_cuenta
       AND c.mes_del_anio = EXTRACT(MONTH FROM p.mes)::int
     WHERE p.mes >= DATE '2026-01-01'
       AND (c.nro_cuenta IS NULL OR c.ciclos_disponibles < 4)
),
ventana AS (
    SELECT a.nro_cuenta,
           a.mes,
           a.lec_actual,
           a.consumo_observado,
           COUNT(h2.consumo) AS meses_previos_disponibles,
           AVG(h2.consumo)   AS media_6meses
      FROM a1 a
      LEFT JOIN p h2
        ON h2.nro_cuenta = a.nro_cuenta
       AND h2.mes >= (a.mes - INTERVAL '6 months')::date
       AND h2.mes <  a.mes
       AND h2.lec_actual <> 0
     GROUP BY a.nro_cuenta, a.mes, a.lec_actual, a.consumo_observado
),
dev AS (
    SELECT nro_cuenta, mes, meses_previos_disponibles, media_6meses,
           ABS(consumo_observado - media_6meses) / media_6meses AS desviacion
      FROM ventana
     WHERE meses_previos_disponibles >= 1
       AND media_6meses > 0
       AND lec_actual <> 0
),
orden AS (
    SELECT nro_cuenta, mes, desviacion,
           ROW_NUMBER() OVER (PARTITION BY mes
                              ORDER BY desviacion DESC, nro_cuenta) AS posicion
      FROM dev
),
meses AS (
    SELECT mes, MAX(desviacion) FILTER (WHERE posicion = 24) AS theta_mes
      FROM orden
     GROUP BY mes
)
SELECT (SELECT COUNT(*) FROM a1)                                    AS a1_celdas_antes_de_depurar,
       (SELECT COUNT(*) FROM a1 WHERE lec_actual = 0)               AS celdas_depuradas_a1,
       (SELECT COUNT(*) FROM ventana)                               AS a1_celdas_con_ventana,
       (SELECT COUNT(*) FROM ventana WHERE meses_previos_disponibles = 0) AS a1_sin_ventana,
       (SELECT COUNT(*) FROM ventana WHERE media_6meses IS NULL
                                        OR media_6meses <= 0)       AS a1_sin_media_positiva,
       (SELECT COUNT(*) FROM dev)                                   AS a1_celdas_calculables,
       (SELECT MIN(meses_previos_disponibles) FROM dev)             AS meses_previos_minimos,
       (SELECT MAX(meses_previos_disponibles) FROM dev)             AS meses_previos_maximos,
       (SELECT COUNT(*) FROM meses)                                 AS meses_medidos,
       (SELECT MIN(celdas) FROM (SELECT COUNT(*) AS celdas FROM orden GROUP BY mes) t)
                                                                     AS celdas_minimas_en_un_mes,
       (SELECT MIN(theta_mes) FROM meses)                           AS theta_minimo,
       (SELECT MAX(theta_mes) FROM meses)                           AS theta_A1,
       (SELECT COUNT(DISTINCT theta_mes) FROM meses)                AS theta_valores_distintos;