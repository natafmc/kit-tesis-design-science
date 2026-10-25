# E2 — Delimitación

**Estado: cerrada el 26 de septiembre de 2026.** Decisión de la tesista: **Opción 2** (detectar anomalías no declaradas por el lecturador).

## 1. Problema de diseño

### Contexto

ENDE, distribución comercial de energía eléctrica. Sistema de lecturación y facturación en PHP/PostgreSQL, administrado por la tesista, organizado en regionales; la regional estudiada maneja **29 750 cuentas** (dato exacto al cierre de septiembre de 2026; el universo creció de 28 355 registros de lectura en enero de 2025, por lo que los denominadores se calculan mes a mes).

| Elemento | Detalle | Estado |
|:--|:--|:--|
| Ente regulador | AETN — Autoridad de Fiscalización de Electricidad y Tecnología Nuclear del Estado Plurinacional de Bolivia; fiscaliza medición, ciclos de lectura, límites de estimación y protección al consumidor | **Fuera del marco teórico** por prueba de eliminación (E4). El marco normativo **no se buscó en E5** —que fue bibliográfica sobre métodos de detección—. **Búsqueda complementaria (DEC-3) intentada el 3–4 oct sin registro de resultado (DEC-13), pendiente de repetir:** si no hay fuente, se documenta como condición de contorno empírica por decisión explícita |
| Catálogo de códigos | **`tfv_codigo_irregular` — 48 códigos, `id_cod_irre` de 0 a 47**, con `desc_cod_irre`, `sw_aviso` y `estado` (=1 en los 48). Descripciones repartidas en cuatro familias de lectura: **tipo 1 = 30 · tipo 3 = 8 · tipo 2 = 6 · tipo 0 = 4**; dominios de impedimento de acceso, falla técnica del medidor, intervención y fraude | **Medido el 6 oct 2026** en `CODIGOS_IRREGULARES.xlsx`; nombre de tabla confirmado por la tesista (DEC-31) |
| Lecturas con código | **12 300 de 1 389 941** lecturas facturables, **enero 2022 – septiembre 2026 (57 meses)** → **0,88 %** (≈ 216 al mes). *Ventana 2025–2026: 5 528 de 532 258 = 1,04 %* | Medido en E6, `DATOS desde 2022.xlsx`, hoja `tipo_lectura`, 6 oct 2026 |
| Histórico de lecturas | `tfv_historico_lecturador`: conserva la lectura bruta sin sobrescribir | Confirmado |
| Reclamos de usuarios | `tfv_reclamo`: ODECO, **1 053 tramitados en 57 meses** (≈ 18,5/mes), **174 procedentes** (≈ 3/mes) | Medido en E6, `DATOS desde 2022.xlsx`, hoja `reclamos`, 6 oct 2026 |
| Correcciones manuales pre-facturación | **242,2 por mes** en 2026; cambio registrado en el log, **sin reporte accesible ni constancia del criterio** | Medido en E6, `DATOS.xlsx`, 1 oct 2026; trazabilidad declarada por la tesista, 2 oct 2026 |
| Cadena de verificación vigente | Equipo técnico que recibe el ODECO → personal que valida la lectura en sitio → personal que responde el ODECO → si procede, encargado de facturación emite nota de conciliación | Descrita por la tesista |
| Tiempo de verificación | 3 a 4 horas por caso; 2 días si exige visita con imagen de respaldo | Estimado por la tesista |
| Facturas observadas / energía no facturada | Sin cifras disponibles | Vacío declarado |

### Problema

Entre enero de 2022 y septiembre de 2026, solo el **0,88 %** de las lecturas facturables de la regional lleva un código de irregularidad —12 300 de 1 389 941 registros, 57 meses—, y ese código se aplica de forma homogénea, sin distinguir entre impedimento de acceso, falla del medidor e intervención. Ese bloque sin marca representa el **99,12 %** del volumen facturable y **no se barre en ningún momento**: no existe un proceso que recorra el histórico para identificar lecturas cuyo consumo sea incoherente y que **no** fueron marcadas. *El uso del código creció con el tiempo: **0,79 %** en 2022–2024 y **1,04 %** en 2025–2026, de modo que el promedio de 57 meses queda por debajo de la ventana reciente.*

La detección que sí existe opera antes de facturar y es completamente manual: el encargado de facturación compara el consumo del mes con el histórico de los **últimos 6 meses**, en sentido superior o inferior, y si lo juzga anómalo solicita una visita al domicilio, donde el personal técnico obtiene evidencia fotográfica y el encargado corrige la lectura. Esa regla **no está escrita, no tiene umbral numérico y no deja registro** de las decisiones que descarta; depende de la atención de una sola persona. Aporta 242,2 correcciones mensuales en 2026, pero no alcanza las lecturas que nunca son revisadas.

Existe además un proceso manual: en la gestión 2026 se corrigieron **242,2 lecturas por mes** antes de facturar, con el propósito de evitar reclamos. El cambio **queda en el log del sistema**, pero no hay un reporte accesible con la fecha y la lectura nueva, ni constancia del criterio ni de la evidencia que lo justificó; hoy solo se observa la lectura ya corregida y facturada. Es el trabajo que el método formalizaría y, al mismo tiempo, el límite de capacidad que el artefacto no debe exceder.

La evidencia de que la omisión tiene costo está en el ciclo de reclamos. La ODECO tramitó **1 053 reclamos en 57 meses** (≈ 18,5 al mes), de los cuales **174 resultaron procedentes** (≈ 3 al mes). De esos 174, **136 —el 78,16 %— provinieron de lecturas sin código**: en esos casos la irregularidad no la advirtió el proceso de lecturación, la reclamó el usuario **después** de facturar, con plazos perentorios de 3 a 15 días hábiles y silencio administrativo positivo a favor del consumidor si la empresa no contesta. Verificar un caso cuesta de 3 a 4 horas y, cuando exige visita del lecturador, 2 días. No hay cifras de facturas observadas ni de energía no facturada; la tesista declara no disponer de ellas, por lo que la línea base se apoya en horas de verificación, en reclamos procedentes y en las correcciones manuales del proceso informal.

**Causa de la ruptura de junio de 2025 (declarada el 1 oct 2026):** hubo capacitaciones al personal para evitar los errores; las correcciones cayeron de 1 507 a 295 mensuales (−80 %). Por eso la gestión 2025 no sirve como línea base única y la base utilizable es la post-capacitación (295 y 242,2). La capacitación entra en E7a como **alternativa existente** con la que el método debe compararse. Siguen pendientes: tiempo real que consume cada corrección y conciliación de los totales entre la Tabla 2 y la Tabla 3. Detalle en `06_diagnostico.md`.

### Solución conceptual

Un **método** de cuatro momentos, aplicable sobre el sistema existente:

1. **Segmentación** del histórico por perfil de consumo y familia de código.
2. **Detección** de desviaciones sobre el consumo esperado, en lecturas con y sin código, sobre `tfv_historico_lecturador`.
3. **Verificación humana** con criterios escritos, dentro de la cadena vigente (validación en sitio, respuesta al ODECO, conciliación).
4. **Resolución y registro** que alimente el ciclo siguiente.

### Criterios de éxito (borrador; los valores se fijan en E6 y E7b, antes de construir)

| # | Criterio | Línea base | Valor esperado |
|:--|:--|:--|:--|
| 1 | **Cobertura retrospectiva:** proporción de reclamos procedentes cuya lectura habría sido alertada por el método | **RESUELTA EL 24 OCT 2026 (DEC-61): EL CAMPO SÍ ESTÁ EN LA BASE, EN OTRA TABLA.** **CONTROL 5.g:** la tabla es **`tfv_respuesta_reclamo`**, relacionada con `tfv_reclamo` por **`id_reclamo`**, y en ella vive **`sw_procedente`**, que indica si el reclamo tiene pronunciamiento **procedente o improcedente**. El criterio es por tanto **computable desde la base de datos y no solo desde la hoja**, que era la salvedad abierta por DEC-59. **Antes de contar se mide la cardinalidad (CONTROL 5.i)** —el 0.6.f, el CONTROL 3 y el CONTROL 5 enseñaron que un `JOIN` multiplicado devuelve cifras falsas—, **y el recuento corre con `COUNT(DISTINCT)`** para que sea válido sea 1:1 o 1:n. **`sw_proceso` sigue siendo OTRO campo** (`character varying` binario, en `tfv_reclamo_lectura`) **y no sustituye a este** (DEC-59). | **COMPUTABLE, FALTAN DOS CONTROLES YA ESCRITOS — CONTROL 5.i (L724, cardinalidad) y 5.j (L755, recuento en la ventana 2022-01→2026-09).** Autocalculos esperados de 5.j: **1 053 en total · 174 procedentes · 136 de los 174 en tipo 1 (78,16 %)**. **[valor: fijar tras 5.i y 5.j]** |
| 2 | **Falsos positivos:** proporción de alertas descartadas por el verificador | **Sin criterio actual: la precisión global del proceso manual es INMEDIBLE**, porque la revisión en pantalla —donde nace la mayor parte de las correcciones— **no tiene denominador registrado** (DEC-43, 19 oct 2026). **Comparador único computable: el canal de reclamos —174 de 1 053 = 16,52 %, es decir 83,48 % de falsa alarma—, rotulado SIEMPRE como canal de reclamos y NUNCA como proceso completo**, porque es solo una de las vías de detección. **Queda como referencia secundaria declarada y no como umbral.** | **Se fija SIN COMPARACIÓN contra el proceso manual (DEC-43):** el método se evalúa contra su propio criterio. **El umbral numérico corresponde fijarlo a E7b** — `04_marco_teorico.md` §8: *debe ser escrito y reproducible; el criterio 3 lo limita por volumen*. **[valor numérico: pendiente de E7b]** |
| 3 | **Carga de verificación:** alertas generadas por ciclo dentro de la capacidad real del equipo (base: 3 a 4 h por caso) | sin proceso de barrido | **≤ 242 alertas/mes (≈ 11/día)** por capacidad observada — fijado el 19 oct 2026 (DEC-45); *linaje y salvedades en la nota debajo de la tabla.* |
| 4 | **Aplicabilidad:** el equipo técnico sigue el método sin asistencia de la autora | sin procedimiento escrito | *[fijar antes de construir]* |

> **Nota de linaje — criterio 3, fijado el 19 de octubre de 2026 (DEC-45).** El valor **≤ 242 alertas/mes (≈ 11 por día)** se fijó **por capacidad observada y no por horas**: 242 correcciones mensuales ÷ 22 días hábiles ≈ 11 por día, reproducible desde `DATOS desde 2022.xlsx`. **Los 3 a 4 h por caso se conservan rotulados como estimación declarada del personal y no como medición**, conforme a la regla de trazabilidad. **RESUELTA el 22 oct 2026 la inconsistencia 11/día contra 3 a 4 h/caso, con respuesta de ENDE (DEC-57):** **las 3 a 4 h son un MÁXIMO y no un promedio, y el trabajo lo hace un EQUIPO —1 a 3 técnicos por oficina, y 2 a 3 personas en la visita— que agrupa las cuentas de una misma ruta antes de salir.** **La fuente es estimación declarada del personal, no un reporte del sistema.** **Consecuencia de diseño:** **el método tiene que emitir sus alertas AGRUPADAS POR RUTA, no como cuentas sueltas**, y **E7c debe construir esa agrupación como parte del método y no como agregado posterior**. **Salvedad (a), abierta:** si esas 3 a 4 h son por cuenta o por visita de ruta completa —se lee como visita de ruta, pero eso es interpretación propia y no declaración suya—. **Salvedad (b), abierta:** **(b)** el valor 242 se sostiene solo mientras 2026 siga en régimen vigente, pues 2025 daba 800,3/mes con el cambio de régimen de junio.

## 2. Problema de investigación

> En el formato institucional se registrará como **problema científico**.

La literatura sobre detección de anomalías en consumo eléctrico trabaja con series de consumo y, en los estudios de fraude, con etiquetas de casos confirmados —`05_estado_del_arte.md` §5, 22 referencias verificadas; **brecha cerrada el 7 de octubre de 2026 (DEC-35)**—. No hay, hasta donde se pudo indagar, evidencia sobre cómo un método de detección que barre el histórico completo —incluidas las lecturas que el lecturador no marcó— se integra a un ciclo de lecturación-facturación sujeto al catálogo de códigos del ente regulador, ni bajo qué criterios los verificadores de una distribuidora lo consideran utilizable cuando revisar un caso cuesta entre 3 y 4 horas. Este estudio genera esa evidencia.

*Alcance:* la afirmación sobre lo que no existe en la literatura **se cerró el 7 de octubre de 2026 (DEC-35)** sobre una búsqueda con protocolo declarado y ampliación con cuenta de registros. **No es una revisión sistemática**, así que se presenta como **lo que esta búsqueda no encontró**, y no como inexistencia demostrada.

## 3. Objeto de estudio

**El artefacto propuesto: el método de detección y verificación de lecturas anómalas**, con tipología declarada de **método** —pasos, roles, entradas, salidas, precondiciones, criterios de entrada y salida, productos de trabajo—, acompañado de la *exemplar* de su aplicación.

*Resignificación de Design Science, explícita:* el objeto de estudio no es el proceso de lecturación ni el fenómeno del fraude en la distribución de energía; esos son el contexto. El objeto es el método que se construye para atacarlos. Al momento de la traducción institucional esta relación se invertirá, y así se anotará entonces.

## 4. Campo de acción

- **Temático:** detección de lecturas anómalas no declaradas y su verificación en el ciclo de lecturación y facturación.
- **Temporal:** histórico conservado en `tfv_historico_lecturador` y ciclos de facturación vigentes.
- **Institucional:** regionales del sistema de ENDE.
- **Clase de contextos:** distribuidoras de energía eléctrica con sistema transaccional propio, histórico tabular de lecturas y catálogo de irregularidades impuesto por su ente regulador.

## 5. Propuesta

Método de detección de lecturas anómalas no declaradas, con segmentación previa, criterios de verificación escritos y registro de resolución; más la *exemplar*: su aplicación sobre el sistema administrado por la tesista, que produce la evidencia de los ciclos de evaluación.

**Decisión registrada:** la técnica de detección —reglas estadísticas y segmentación frente a algoritmo de detección— no se promete en el título y se decide en **E7a** con trade-offs explícitos.

## Roles identificados (insumo para E7c y E8)

| Rol en la cadena vigente | Función | Uso en la investigación |
|:--|:--|:--|
| **Personal terciarizado de lecturación** | Toma la lectura en el domicilio con **equipo móvil de lecturación**. Externo a ENDE | Genera el dato de entrada; destinatario de la capacitación may–jun 2025; causa declarada de las ~242 correcciones mensuales |
| **Personal responsable de lecturación** | Recibe el equipo móvil y **descarga las lecturas al sistema comercial** | Puerta entre el dato de campo y el sistema; primer punto donde podría validarse |
| **Encargado de facturación** | **Revisa los consumos calculados y decide si hay anomalía**; solicita la visita; después **revisa y corrige la lectura**; emite la nota de conciliación. Almacena la evidencia fotográfica en su computadora | **Actor central**: hoy es quien detecta, quien manda a verificar y quien corrige. Máximo usuario del método y **evaluador de aplicabilidad** |
| **Personal técnico de la empresa** (no terciarizado) | Se desplaza al domicilio, saca el respaldo fotográfico del medidor y retorna a oficina | **Evaluador de campo**; quien ejecuta las visitas que el método generaría |
| Equipo técnico de recepción del ODECO | Recibe y clasifica el reclamo | Informa el problema de diseño |
| Personal de respuesta al ODECO | Redacta la respuesta formal | **Evaluador de utilidad** |
| Tesista | Administradora del sistema | Diseña y construye; **no evalúa su propio artefacto** |

**Separación de muestras:** el problema de diseño se informa con la experiencia de este equipo; la evaluación sumativa debe incorporar al menos un evaluador que no participó en la delimitación, para controlar el sesgo de confirmación del constructor.

**Consecuencia de diseño:** hay **cinco roles distintos** entre el domicilio y la factura, y el encargado de facturación concentra tres funciones —detectar, pedir verificación, corregir—. Ese punto único es la dependencia más frágil de la cadena actual y, a la vez, el lugar donde el método aporta más: hoy si esa persona no revisa, no se detecta nada.
