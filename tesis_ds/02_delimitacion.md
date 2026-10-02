# E2 — Delimitación

**Estado: cerrada el 26 de septiembre de 2026.** Decisión de la tesista: **Opción 2** (detectar anomalías no declaradas por el lecturador).

## 1. Problema de diseño

### Contexto

ENDE, distribución comercial de energía eléctrica. Sistema de lecturación y facturación en PHP/PostgreSQL, administrado por la tesista, organizado en regionales; la regional estudiada maneja **29 750 cuentas** (dato exacto al cierre de septiembre de 2026; el universo creció de 28 355 registros de lectura en enero de 2025, por lo que los denominadores se calculan mes a mes).

| Elemento | Detalle | Estado |
|:--|:--|:--|
| Ente regulador | AETN — Autoridad de Fiscalización de Electricidad y Tecnología Nuclear del Estado Plurinacional de Bolivia; fiscaliza medición, ciclos de lectura, límites de estimación y protección al consumidor | **Fuera del marco teórico** por prueba de eliminación (E4). El marco normativo **no se buscó en E5** —que fue bibliográfica sobre métodos de detección—. Una búsqueda complementaria queda prevista para el **3–4 de octubre** (DEC-3/DEC-7); si no hay fuente, se documenta como condición de contorno empírica por decisión explícita |
| Catálogo de códigos | 20 a 25 códigos en tres familias: impedimento de acceso, falla técnica del medidor, intervención y fraude | Descrito por la tesista |
| Lecturas con código | **5 528 de 532 258** lecturas facturables en 21 meses → **1,04 %** (≈ 285 al mes) | Medido en E6, `DATOS.xlsx`, 1 oct 2026 |
| Histórico de lecturas | `tfv_historico_lecturador`: conserva la lectura bruta sin sobrescribir | Confirmado |
| Reclamos de usuarios | `tfv_reclamo`: ODECO, **314 tramitados en 21 meses** (≈ 15/mes), **62 procedentes** (≈ 3/mes) | Medido en E6, `DATOS.xlsx`, 1 oct 2026 |
| Correcciones manuales pre-facturación | **242,2 por mes** en 2026; cambio registrado en el log, **sin reporte accesible ni constancia del criterio** | Medido en E6, `DATOS.xlsx`, 1 oct 2026; trazabilidad declarada por la tesista, 2 oct 2026 |
| Cadena de verificación vigente | Equipo técnico que recibe el ODECO → personal que valida la lectura en sitio → personal que responde el ODECO → si procede, encargado de facturación emite nota de conciliación | Descrita por la tesista |
| Tiempo de verificación | 3 a 4 horas por caso; 2 días si exige visita con imagen de respaldo | Estimado por la tesista |
| Facturas observadas / energía no facturada | Sin cifras disponibles | Vacío declarado |

### Problema

Entre enero de 2025 y septiembre de 2026, solo el **1,04 %** de las lecturas facturables de la regional lleva un código de irregularidad —5 528 de 532 258 registros—, y ese código se aplica de forma homogénea, sin distinguir entre impedimento de acceso, falla del medidor e intervención. Ese bloque sin marca representa el **98,96 %** del volumen facturable y **no se barre en ningún momento**: no existe un proceso que recorra el histórico para identificar lecturas cuyo consumo sea incoherente y que **no** fueron marcadas.

La detección que sí existe opera antes de facturar y es completamente manual: el encargado de facturación compara el consumo del mes con el histórico de los **últimos 6 meses**, en sentido superior o inferior, y si lo juzga anómalo solicita una visita al domicilio, donde el personal técnico obtiene evidencia fotográfica y el encargado corrige la lectura. Esa regla **no está escrita, no tiene umbral numérico y no deja registro** de las decisiones que descarta; depende de la atención de una sola persona. Aporta 242,2 correcciones mensuales en 2026, pero no alcanza las lecturas que nunca son revisadas.

Existe además un proceso manual: en la gestión 2026 se corrigieron **242,2 lecturas por mes** antes de facturar, con el propósito de evitar reclamos. El cambio **queda en el log del sistema**, pero no hay un reporte accesible con la fecha y la lectura nueva, ni constancia del criterio ni de la evidencia que lo justificó; hoy solo se observa la lectura ya corregida y facturada. Es el trabajo que el método formalizaría y, al mismo tiempo, el límite de capacidad que el artefacto no debe exceder.

La evidencia de que la omisión tiene costo está en el ciclo de reclamos. La ODECO tramitó **314 reclamos en 21 meses** (≈ 15 al mes), de los cuales **62 resultaron procedentes** (≈ 3 al mes). De esos 62, **46 —el 74,19 %— provinieron de lecturas sin código**: en esos casos la irregularidad no la advirtió el proceso de lecturación, la reclamó el usuario **después** de facturar, con plazos perentorios de 3 a 15 días hábiles y silencio administrativo positivo a favor del consumidor si la empresa no contesta. Verificar un caso cuesta de 3 a 4 horas y, cuando exige visita del lecturador, 2 días. No hay cifras de facturas observadas ni de energía no facturada; la tesista declara no disponer de ellas, por lo que la línea base se apoya en horas de verificación, en reclamos procedentes y en las correcciones manuales del proceso informal.

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
| 1 | **Cobertura retrospectiva:** proporción de reclamos procedentes cuya lectura habría sido alertada por el método | por calcular con `tfv_reclamo` | *[fijar antes de construir]* |
| 2 | **Falsos positivos:** proporción de alertas descartadas por el verificador | sin criterio actual | *[fijar antes de construir]* |
| 3 | **Carga de verificación:** alertas generadas por ciclo dentro de la capacidad real del equipo (base: 3 a 4 h por caso) | sin proceso de barrido | *[fijar antes de construir]* |
| 4 | **Aplicabilidad:** el equipo técnico sigue el método sin asistencia de la autora | sin procedimiento escrito | *[fijar antes de construir]* |

## 2. Problema de investigación

> En el formato institucional se registrará como **problema científico**.

La literatura sobre detección de anomalías en consumo eléctrico trabaja con series de consumo y, en los estudios de fraude, con etiquetas de casos confirmados —`05_estado_del_arte.md` §5, 22 referencias verificadas; **brecha provisional** hasta la ampliación DEC-1—. No hay, hasta donde se pudo indagar, evidencia sobre cómo un método de detección que barre el histórico completo —incluidas las lecturas que el lecturador no marcó— se integra a un ciclo de lecturación-facturación sujeto al catálogo de códigos del ente regulador, ni bajo qué criterios los verificadores de una distribuidora lo consideran utilizable cuando revisar un caso cuesta entre 3 y 4 horas. Este estudio genera esa evidencia.

*Advertencia:* la afirmación sobre lo que no existe en la literatura es provisional hasta cerrar E5 y no debe presentarse como hecha.

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
