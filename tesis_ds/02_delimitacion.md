# E2 — Delimitación

**Estado: cerrada el 26 de septiembre de 2026.** Decisión de la tesista: **Opción 2** (detectar anomalías no declaradas por el lecturador).

## 1. Problema de diseño

### Contexto

ENDE, distribución comercial de energía eléctrica. Sistema de lecturación y facturación en PHP/PostgreSQL, administrado por la tesista, organizado en regionales; la regional de mayor volumen maneja 20 000 cuentas.

| Elemento | Detalle | Estado |
|:--|:--|:--|
| Ente regulador | AETN — Autoridad de Fiscalización de Electricidad y Tecnología Nuclear del Estado Plurinacional de Bolivia; fiscaliza medición, ciclos de lectura, límites de estimación y protección al consumidor | Marco normativo *[por verificar en E5]* |
| Catálogo de códigos | 20 a 25 códigos en tres familias: impedimento de acceso, falla técnica del medidor, intervención y fraude | Descrito por la tesista |
| Lecturas con código | Aproximadamente 5 000 por ciclo de un total de 20 000 cuentas (≈ 25 %) | Dato por confirmar en E6 |
| Histórico de lecturas | `tfv_histo_lec`: conserva la lectura bruta sin sobrescribir | Confirmado |
| Reclamos de usuarios | `tfv_reclamo`: ODECO, ~50 reclamos/mes, ~40 procedentes/mes | Estimado por la tesista; conteo exacto *[por confirmar en E6]* |
| Cadena de verificación vigente | Equipo técnico que recibe el ODECO → personal que valida la lectura en sitio → personal que responde el ODECO → si procede, encargado de facturación emite nota de conciliación | Descrita por la tesista |
| Tiempo de verificación | 3 a 4 horas por caso; 2 días si exige visita con imagen de respaldo | Estimado por la tesista |
| Facturas observadas / energía no facturada | Sin cifras disponibles | Vacío declarado |

### Problema

Cerca del 25 % de las lecturas de cada ciclo se resuelve con un código de irregularidad y se trata de forma homogénea, sin distinción entre impedimento de acceso, falla del medidor e intervención. La detección es **exclusivamente reactiva y dependiente del criterio individual del lecturador en el momento de la lectura**: no existe ningún proceso que recorra el histórico para identificar lecturas cuyo consumo sea incoherente y que **no** fueron marcadas.

La evidencia de que esa omisión tiene costo está en el ciclo de reclamos. La ODECO recibe unos 50 reclamos por mes y unos 40 resultan procedentes; en esos casos la irregularidad no fue advertida por el proceso de lecturación sino reclamada por el usuario **después** de facturar, con plazos perentorios de 3 a 15 días hábiles y silencio administrativo positivo a favor del consumidor si la empresa no contesta. Verificar un caso cuesta de 3 a 4 horas y, cuando exige visita del lecturador, 2 días. No hay cifras de facturas observadas ni de energía no facturada; la tesista declara no disponer de ellas, por lo que la línea base se apoya en horas de verificación y en reclamos procedentes.

**Pendiente de mayor importancia para E6:** determinar cuántos de los ~40 reclamos procedentes mensuales corresponden a lecturas **sin** código de irregularidad. Esa cifra es la evidencia directa de que la detección existente deja pasar anomalías y es, a la vez, la línea base del diagnóstico.

### Solución conceptual

Un **método** de cuatro momentos, aplicable sobre el sistema existente:

1. **Segmentación** del histórico por perfil de consumo y familia de código.
2. **Detección** de desviaciones sobre el consumo esperado, en lecturas con y sin código, sobre `tfv_histo_lec`.
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

La literatura sobre detección de anomalías en consumo eléctrico trabaja con series de consumo y, en los estudios de fraude, con etiquetas de casos confirmados; *[por verificar en E5]*. No hay, hasta donde se pudo indagar, evidencia sobre cómo un método de detección que barre el histórico completo —incluidas las lecturas que el lecturador no marcó— se integra a un ciclo de lecturación-facturación sujeto al catálogo de códigos del ente regulador, ni bajo qué criterios los verificadores de una distribuidora lo consideran utilizable cuando revisar un caso cuesta entre 3 y 4 horas. Este estudio genera esa evidencia.

*Advertencia:* la afirmación sobre lo que no existe en la literatura es provisional hasta cerrar E5 y no debe presentarse como hecha.

## 3. Objeto de estudio

**El artefacto propuesto: el método de detección y verificación de lecturas anómalas**, con tipología declarada de **método** —pasos, roles, entradas, salidas, precondiciones, criterios de entrada y salida, productos de trabajo—, acompañado de la *exemplar* de su aplicación.

*Resignificación de Design Science, explícita:* el objeto de estudio no es el proceso de lecturación ni el fenómeno del fraude en la distribución de energía; esos son el contexto. El objeto es el método que se construye para atacarlos. Al momento de la traducción institucional esta relación se invertirá, y así se anotará entonces.

## 4. Campo de acción

- **Temático:** detección de lecturas anómalas no declaradas y su verificación en el ciclo de lecturación y facturación.
- **Temporal:** histórico conservado en `tfv_histo_lec` y ciclos de facturación vigentes.
- **Institucional:** regionales del sistema de ENDE.
- **Clase de contextos:** distribuidoras de energía eléctrica con sistema transaccional propio, histórico tabular de lecturas y catálogo de irregularidades impuesto por su ente regulador.

## 5. Propuesta

Método de detección de lecturas anómalas no declaradas, con segmentación previa, criterios de verificación escritos y registro de resolución; más la *exemplar*: su aplicación sobre el sistema administrado por la tesista, que produce la evidencia de los ciclos de evaluación.

**Decisión registrada:** la técnica de detección —reglas estadísticas y segmentación frente a algoritmo de detección— no se promete en el título y se decide en **E7a** con trade-offs explícitos.

## Roles identificados (insumo para E7c y E8)

| Rol en la cadena vigente | Función | Uso en la investigación |
|:--|:--|:--|
| Equipo técnico de recepción del ODECO | Recibe y clasifica el reclamo | Informa el problema de diseño |
| Personal de validación en sitio | Verifica la lectura y obtiene respaldo fotográfico | **Evaluador de aplicabilidad**; probador del método en campo |
| Personal de respuesta al ODECO | Redacta la respuesta formal | **Evaluador de utilidad** |
| Encargado de facturación | Emite la nota de conciliación | Evalúa el impacto en el ciclo de facturación |
| Tesista | Administradora del sistema | Diseña y construye; **no evalúa su propio artefacto** |

**Separación de muestras:** el problema de diseño se informa con la experiencia de este equipo; la evaluación sumativa debe incorporar al menos un evaluador que no participó en la delimitación, para controlar el sesgo de confirmación del constructor.
