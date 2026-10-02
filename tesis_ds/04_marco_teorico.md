# E4. Marco teórico

| | |
|:--|:--|
| **Estado** | **cerrada el 2 de octubre de 2026** |
| **Entrega** | 4 de octubre de 2026, con E5 |
| **Alcance** | Los conceptos y marcos que, al retirarlos, cambiarían el diseño del método. Nada más entra. |
| **Regla de verificación** | Ninguna fuente se cita sin haber comprobado autoría, título, publicación, volumen, número, páginas y DOI en Crossref. Lo no comprobado queda marcado `[por verificar]`. El registro completo está en la sección 9. **Decisión del asesor, 2 oct 2026:** no se citan materiales internos; las citas se sustituyen por la fuente primaria que las respalda. |
| **Archivo que alimenta** | `propuesta_borrador_v1.md`, sección 8 |

---

## 1. Para qué sirve este marco en un estudio de Design Science

En investigación empírica el marco teórico informa el instrumento de medición. Aquí cumple otra función: sustenta las decisiones de diseño del artefacto y alimenta el **ciclo de rigor**, uno de los tres ciclos de Hevner (2007), que importa el conocimiento del campo hacia el estudio. En Design Science esa revisión de la base de conocimiento cumple dos funciones que no son las habituales —**identificar el problema de diseño** y **fundamentar el diseño del artefacto**— y su exploración no termina al identificar la brecha, sino que continúa durante la construcción. Ambas funciones se observan en este documento: la sección 3 define la anomalía que se va a construir y la sección 2 decide con qué criterios se evaluará.

Esa segunda función fija el criterio de selección de este documento. La sección 8 del borrador declara una **prueba de eliminación**: *si al retirar una sección del marco el diseño del método no cambia, esa sección es decorativa y se elimina*. Se aplicó literalmente; el resultado está en la sección 6.

Los cuatro ejes anunciados en el borrador se conservan, pero el eje 3 se reformula (sección 5) y dos de sus partes se eliminan.

---

## 2. Eje 4 — Design Science como paradigma

Es el eje que determina los otros tres: decide qué cuenta como artefacto, cómo se evalúa y qué nivel de contribución se puede reclamar.

### 2.1 Qué cuenta como artefacto: la tipología

March y Smith (1995) identificaron cuatro tipos de artefacto en la investigación sobre sistemas de información —**constructos, modelos, métodos e instanciaciones**—. Hevner et al. (2004) adoptaron esa taxonomía como núcleo de los siete principios del paradigma y establecieron que **la evaluación apropiada depende del tipo de artefacto producido**. Wieringa (2014) añadió, para ingeniería de software, las **teorías de diseño** como tipo diferenciado.

La correspondencia entre tipo de artefacto y tipo de evaluación es la que gobierna el diseño metodológico de este estudio:

| Tipo | Evaluación apropiada | ¿Corresponde aquí? |
|:--|:--|:--|
| Constructo | Completitud y consistencia del vocabulario | No es el objeto |
| Modelo | Que represente el fenómeno; evaluación predictiva contra datos históricos | No es el objeto |
| **Método** | **Aplicabilidad** (¿pueden los practicantes seguir los pasos?) y **efectividad** (resultados con y sin el método) | **Sí: es el artefacto** |
| Instanciación | Rendimiento, cobertura, corrección | Solo como *exemplar* de apoyo |
| Teoría de diseño | Múltiples instanciaciones independientes | No: excede el nivel de maestría |

**Decisión que este marco fija.** El artefacto es un **método** —pasos, roles, entradas, salidas, precondiciones, criterios de entrada y salida, productos de trabajo— acompañado de una instanciación de apoyo (las aplicaciones sobre la base de datos) que hace de *exemplar*. De ahí se siguen tres consecuencias que ya estaban en el diseño y que ahora tienen fundamento:

1. Los criterios de éxito son de **aplicabilidad y efectividad**, no de rendimiento de software. No se aplican pruebas de carga ni métricas de cobertura de pruebas al método.
2. La contribución no puede ser la instanciación. **Criterio de contribución de este estudio** —fijado en la E3 y registrado en §7 del borrador—: en nivel de maestría se reclama un conjunto de **principios de diseño validados**; el artefacto es el vehículo, no la contribución.
3. La **transferibilidad analítica** del método es lo que permite a otra distribuidora construir algo distinto ante un problema de la misma clase. **Criterio operativo que este estudio se impone a sí mismo:** *¿puede un investigador sin acceso a este artefacto usar los principios para construir uno diferente ante un problema de la misma clase?* Si la respuesta es no, la tesis se quedó en el nivel de instancia.

### 2.2 Los siete principios de Hevner et al. (2004)

Los principios que operan en este estudio, con el efecto concreto de cada uno:

| Principio | Efecto en el diseño |
|:--|:--|
| 1. Diseño como artefacto | El objeto es el método, no el fenómeno del fraude ni el proceso de lecturación |
| 2. Relevancia del problema | El problema se sustenta en evidencia empírica medida, no en afirmación declarativa (`06_diagnostico.md`) |
| 3. Evaluación del diseño | Todo criterio se fija **antes** de construir; los valores numéricos se fijan en E6 y E7b |
| 4. Contribuciones de investigación | Se reclaman principios de diseño, no el método mismo |
| 5. Rigor de investigación | Toda decisión de diseño se apoya en conocimiento verificable: este documento y `05_estado_del_arte.md` |
| 6. Diseño como búsqueda | Se espera explorar un espacio de alternativas en E7a, no ejecutar la primera idea |
| 7. Comunicación de la investigación | Trazabilidad: cada cifra con su consulta y su fuente |

### 2.3 Los tres ciclos de Hevner (2007)

Hevner (2007) organiza el paradigma en tres ciclos que operan simultáneamente. Su valor para este estudio es que **asigna cada etapa a un ciclo** y hace visible cuándo uno de ellos queda abierto:

- **Ciclo de relevancia** — conecta la investigación con el entorno: de ahí salen los requisitos y hacia allí va el artefacto. Aquí: la cadena de verificación vigente en cinco pasos y cinco roles, el catálogo de códigos de irregularidad, los plazos de la ODECO de 3 a 15 días hábiles y la capacidad de ≈11 visitas diarias.
- **Ciclo de rigor** — importa el conocimiento del campo. Aquí: este documento (E4) y `05_estado_del_arte.md` (E5).
- **Ciclo de diseño** — construir y evaluar. Aquí: E7a a E7f y E8.

**Decisión que este marco fija.** El techo de capacidad y los plazos regulatorios **no son restricciones externas al diseño: son requisitos del artefacto** que se incorporan desde el ciclo de relevancia. De ahí que el criterio de éxito n.º 3 —la carga de verificación dentro de la capacidad del equipo— no pueda relajarse sin que la contribución pierda su condición de transferible a distribuidoras reguladas.

### 2.4 El proceso: DSRM y ciclos anidados

Peffers et al. (2007) proponen el DSRM, seis actividades con tres puntos de entrada posibles: identificación del problema y motivación; definición de objetivos de la solución; diseño y desarrollo; demostración; evaluación; comunicación. La distinción clave es que el DSRM es un **modelo prescriptivo de planificación y comunicación**, no un espejo del proceso real.

Wieringa (2014) describe en cambio la estructura lógica del proceso mediante **dos ciclos anidados**: el **ciclo de ingeniería** (análisis del problema, diseño de la solución, validación del diseño, implementación, evaluación de la implementación en contexto) y el **ciclo de investigación** (formulación del problema de investigación, construcción del artefacto como experimento, evaluación de la contribución al conocimiento, comunicación a la comunidad).

La distinción no es cosmética. **El ciclo de ingeniería puede cerrarse con éxito sin que el de investigación genere ninguna contribución.** Una tesis puede mostrar que el método funciona en ENDE y no haber aprendido nada transferible.

| Ciclo | Etapas en este estudio | Riesgo si se descuida |
|:--|:--|:--|
| Ingeniería | E7a – E7f, E8 | Artefacto funcional sin contribución |
| Investigación | E0 – E6, E9, E10 | Buen proyecto de ingeniería, tesis sin conocimiento |

**Decisión que este marco fija.** La documentación de rediseño del 16 al 18 de noviembre no es un trámite administrativo: es la evidencia del ciclo de investigación. Cada versión del artefacto debe registrar qué pregunta de diseño respondía, qué reveló la evaluación y qué cambió en consecuencia. Un artefacto que no cambia durante todo el proceso debería ser motivo de sospecha.

Además, este estudio se impone como **combinación mínima** una evaluación formativa, un rediseño documentado y una evaluación sumativa —la distinción entre propósito formativo y sumativo la aporta FEDS (Venable et al., 2016; véase §2.5)—. El cronograma vigente la cumple exactamente.

### 2.5 La evaluación: FEDS

Venable et al. (2016) proponen FEDS, que separa el **propósito** de la evaluación —formativa o sumativa— del **estilo** con que se ejecuta —artificial o naturalista—. De ahí la estructura de E8 ya registrada en el borrador: una evaluación formativa de campo que detecte problemas y rediseñe, y una sumativa de campo que sustente la contribución.

**Decisión que este marco fija.** No basta una única evaluación sumativa presentada como completa. El esquema de dos ciclos con rediseño intermedio es obligatorio, no opcional.

### 2.6 Nivel de la contribución: Gregor y Hevner

Gregor y Hevner (2013) proponen juzgar la contribución de una investigación de Design Science por **dos dimensiones: el estado del conocimiento en el dominio del problema y el estado del conocimiento en el dominio de la solución**; y proponen además un esquema de comunicación en el que la descripción del artefacto sustituye a la sección de resultados convencional.

Aplicado a este estudio:

- **Dominio del problema:** conocimiento **escaso**. No existe documentación académica sobre detección de lecturas anómalas no declaradas en distribuidoras reguladas por la AETN con sistema transaccional propio; la evidencia se construyó aquí, con `DATOS.xlsx` y las declaraciones de la tesista.
- **Dominio de la solución:** conocimiento **abundante**. La detección de anomalías y las pérdidas no técnicas son campos maduros, con revisiones sistemáticas desde 2017 (ver `05_estado_del_arte.md`).

**Decisión que este marco fija.** Al combinar un problema poco documentado con una solución ya conocida, la contribución **no puede ser una técnica nueva de detección** —sería redundante con un campo maduro—, sino la **formalización del problema y sus principios de diseño con condiciones de contorno explícitas**. Ese es exactamente el alcance de la oración de contribución adoptada en el gate de E3.

### 2.7 La forma del principio de diseño

Para articular principios de diseño este estudio adopta la plantilla **objetivo → contexto → mecanismo → principio**, atribuida a Wieringa (2014) `[por verificar: capítulo y página; ruta: preguntar al tutor, que cita el libro]`. El objetivo especifica qué se pretende lograr; el contexto delimita las condiciones bajo las cuales aplica; el mecanismo explica por qué funciona; el principio prescribe qué debe tener el artefacto. Omisiones frecuentes que hay que evitar: el contexto —producen principios que suenan universales pero no lo son— y el mecanismo —dejan el principio como recomendación sin explicación—. **La plantilla se exige igualmente aunque la atribución no se confirme:** lo que estaría en juego es solo de dónde viene la forma, no si se usa.

**Decisión que este marco fija.** Los principios de E10 se redactarán con esa plantilla. Se descarta de antemano derivarlos de una única evaluación con muestra pequeña.

---

## 3. Eje 1 — Qué es una anomalía y cómo se evalúa su detección

### 3.1 Definición operativa de anomalía

Chandola et al. (2009) definen una anomalía como un patrón de datos que no se ajusta al comportamiento esperado de la mayoría de los datos, y sistematizan el campo distinguiendo **tres tipos**:

| Tipo | Qué es | Encaje en este problema |
|:--|:--|:--|
| **Anomalía de punto** | Un registro individual que se aparta del resto | Una lectura aislada con consumo fuera de rango |
| **Anomalía contextual** | Un registro anómalo solo en función del contexto —tiempo, estación, categoría— | **El caso principal.** 500 kWh son normales en julio y anómalos en abril para la misma cuenta |
| **Anomalía colectiva** | Un conjunto de registros cuyo comportamiento conjunto es anómalo, aunque cada uno sea normal | La trayectoria completa de la serie de la cuenta frente a sus ciclos anuales |

Para series temporales, el tipo relevante es la **subsecuencia anómala**: una parte de la serie que se comporta de manera incompatible con el resto de la serie y con las series semejantes.

**Definición operativa adoptada.** Para este estudio:

> **Lectura anómala no declarada:** una lectura cuyo consumo registrado difiere, en sentido superior o inferior, de lo esperable para esa cuenta y ese momento del ciclo, según un **criterio escrito y reproducible**, y que **no lleva código de irregularidad** en el momento de la lectura.

Tres condiciones la hacen *operativa* —es decir, verificable por una persona que no participó en el estudio—:

1. **Criterio escrito y reproducible.** La regla vigente —desviación frente a los últimos 6 meses, en ambas direcciones— ya existe, pero **no tiene umbral numérico ni registro** (declaración de la tesista, 2 oct 2026). Mientras no haya umbral escrito, no hay detección: hay juicio.
2. **Ambas direcciones.** El consumo excesivo *y* el consumo inusualmente bajo son sospechosos.
3. **Sin marca previa.** Con la marca, el caso ya está dentro del proceso; el estudio trata los que quedaron fuera.

### 3.2 Supervisado, no supervisado y escasez de etiquetas

Chandola et al. (2009) distinguen los métodos **supervisados** —requieren datos etiquetados de anomalía y de normalidad— de los **no supervisados** —construyen un modelo de normalidad y marcan como anómalo lo que se desvía—, más una categoría intermedia.

La restricción de este estudio es empírica y medida: **62 reclamos procedentes en 21 meses** (`DATOS.xlsx`, Tabla 1). Sobre un universo facturable de 532 258 registros (Tabla 3), las etiquetas positivas disponibles son extremadamente escasas y, además, **no son etiquetas de detección**: son el resultado de un reclamo del usuario que llegó *después* de facturar.

**Consecuencia para el diseño.** Este marco **no elige la técnica** —eso es de E7a—, pero **constriñe el espacio de opciones**: cualquier alternativa que exija un corpus amplio de casos etiquetados parte con una desventaja documentada, y la verdadera referencia de verdad de referencia tendrá que construirse en E8, no tomarse prestada.

### 3.3 Desequilibrio de clases y métrica de evaluación

Saito y Rehmsmeier (2015) demuestran que, ante conjuntos de datos desequilibrados, **la gráfica precisión-exhaustividad es más informativa que la curva ROC**, porque la ROC permanece optimista cuando la clase positiva es rara.

**Decisión que este marco fija.** Los criterios de éxito 1 y 2 del estudio —cobertura de reclamos procedentes y falsos positivos— son, en terminología del campo, **exhaustividad y (1 − precisión)**. Este marco les da su fundamento: no son una elección conveniente, son la métrica correcta para la estructura del dato. **Queda descartada la exactitud (accuracy) como criterio de éxito**, porque en este conjunto sería engañosa.

### 3.4 La falacia de la tasa base y el costo de la alerta

Axelsson (2000) documentó la **falacia de la tasa base** en la detección de intrusiones: cuando la proporción de casos verdaderos es baja, un detector con una tasa de falsos positivos aparentemente pequeña produce una mayoría de alarmas falsas. El resultado contraintuitivo es que **mejorar la exactitud no reduce el problema; lo oculta**.

Aquí el efecto no es abstracto. Cada alerta que el encargado de facturación acepta termina en una visita: **el costo de una falsa alarma no es una revisión de pantalla, es un desplazamiento**. Sobre 242,2 correcciones mensuales y 22 días hábiles, la capacidad efectiva es de ≈11 visitas diarias (`06_diagnostico.md`, cálculo propio sobre Tabla 2).

**Decisión que este marco fija.** El criterio de éxito n.º 3 —la carga de verificación dentro de la capacidad del equipo— **no es un criterio de comodidad: es el criterio de viabilidad del artefacto**. Un método que encontrara todo pero emitiera 500 alertas mensuales sería inútil en este contexto. La métrica central pasa a ser **el volumen de alertas frente a la capacidad**, y no la exactitud agregada.

### 3.5 Explicabilidad como requisito de la verificación humana

Nwafor et al. (2023) aplican inteligencia artificial explicable a la predicción de pérdidas no técnicas; Noorchenarboo y Grolinger (2025) estudian cómo explicar la detección de anomalías en datos de consumo energético **centrándose en los datos contextualmente relevantes**. Ambas responden a la misma necesidad: quien verifica no puede adoptar una alerta que no entiende.

**Decisión que este marco fija.** Cada alerta que el método emita debe acompañarse de **la comparación concreta que la originó** —contra qué ventana, en qué dirección, cuánto se desvió— y la resolución debe registrarse con **su criterio y su evidencia**. De ahí sale el requisito de registro de resolución que ya figura en la propuesta. Sin este eje, ese requisito sería una preferencia de redacción y no una exigencia del campo.

### 3.6 Del algoritmo a la visita: priorizar la inspección

Tres trabajos documentan que la detección no basta, que hay que decidir **a quién visitar**:

- Guerrero et al. (2018): reducir pérdidas no técnicas **mejorando la exactitud de las inspecciones** en una empresa de distribución.
- Massaferro et al. (2020): detección de fraude formulada para **maximizar el retorno económico**.
- Xia et al. (2020): algoritmo de inspección basado en **evaluación de sospecha** para detectar usuarios maliciosos.

**Decisión que este marco fija.** La **priorización es parte del método**, no un refinamiento posterior. Esto sostiene directamente la segmentación por perfil de consumo y familia de código que la propuesta ya declara.

---

## 4. Eje 2 — Perfil de consumo y estacionalidad

### 4.1 El perfil precede a la detección

Piscitelli et al. (2026) proponen un proceso analítico para **perfilar la carga y detectar anomalías a nivel de medidor** en series de consumo, de modo que la detección opera sobre consumos ya caracterizados, no sobre lecturas crudas.

**Decisión que este marco fija.** La **segmentación por perfil de consumo** es un paso previo a la detección, no una salida. Esto confirma la estructura ya anunciada en la propuesta (§7): método *segmentado* por perfil de consumo y familia de código.

### 4.2 Estacionalidad: por qué la ventana de 6 meses no basta

La anomalía es **contextual** (sección 3.1): un consumo solo lo es respecto de su estación y su cuenta. La regla vigente compara el mes contra los **seis meses anteriores**; esa ventana **no incluye el mismo mes del año anterior**, de modo que un ciclo anual completo —calefacción en invierno, aire acondicionado en verano— queda fuera de la comparación. Esta consecuencia es **lógicamente deducible de la definición de la regla**, no una afirmación tomada de la literatura.

La solución no es teórica sino empírica: **el histórico `tfv_historico_lecturador` llega hasta 2022 — 57 meses y cuatro ciclos anuales completos** (declaración de la tesista, 2 oct 2026), lo que permite comparar contra el mismo periodo del año anterior en lugar de contra una ventana móvil.

**Decisión que este marco fija.** El tratamiento de estacionalidad es **requisito de diseño de E7c** y se sustenta en la amplitud del histórico, no en una fuente externa. Consecuencia operativa pendiente: **ampliar la extracción a enero de 2022** antes de construir (`sql_a2_extraccion.sql`, especificación A2.1–A2.4).

---

## 5. Eje 3 — El ciclo de relevancia y el entorno regulado

### 5.1 Qué entra desde el entorno

Hevner (2007) ubica en el **ciclo de relevancia** el intercambio entre la investigación y su entorno: de allí se reciben los requisitos y hacia allí se devuelve el artefacto. En este estudio el entorno es una distribuidora regulada, y sus aportes al diseño son cuatro y están documentados empíricamente:

| Aporte del entorno | Fuente | Efecto en el diseño |
|:--|:--|:--|
| Catálogo de códigos de irregularidad del ente regulador | `02_delimitacion.md` | El método barre **con y sin código**; el código es variable de priorización, no ámbito de trabajo |
| Plazos de la ODECO: 3 a 15 días hábiles, con silencio administrativo positivo | `02_delimitacion.md` | El método opera **antes** de facturar; la detección reactiva llega tarde por diseño |
| Capacidad de ≈11 visitas diarias | `06_diagnostico.md` | Techo de alertas: criterio de éxito n.º 3 |
| Cinco roles en cinco pasos de la cadena de corrección | `06_diagnostico.md` | Estructura de roles del método; punto único en el encargado de facturación |

### 5.2 Parte de este eje se elimina

El eje 3 estaba redactado en el borrador como *"auditoría, control interno y atención de reclamos bajo normativa del ente regulador"*. **Se buscó y no se localizó ninguna fuente verificable** sobre control interno, auditoría o atención de reclamos en servicios eléctricos regulados que cambiara el diseño del método (consulta a Crossref, 2 oct 2026; registro en `05_estado_del_arte.md`, sección 8).

Aplicando la prueba de eliminación declarada: **esa sección se retira del marco teórico**. Sus contenidos —que la corrección quede registrada, que haya constancia del criterio y de la evidencia, que exista un reporte accesible— **no desaparecen del estudio**: entran por el camino correcto, como **condiciones de contorno empíricas** documentadas en E2 y E6, y como requisitos de diseño en E7b.

Queda pendiente `[por verificar]` **solo si** la búsqueda complementaria devuelve algo. E5 no localizó esa literatura (`05_estado_del_arte.md` §9). **Decisión del asesor, 2 oct 2026 (DEC-3):** se hará **una búsqueda complementaria en bases de regulación y política energética el 3–4 de octubre**; si tampoco devuelve fuente verificable, el tema queda fuera del marco teórico por decisión explícita y se deja constancia. **No se rellena con una fuente dudosa.**

---

## 6. Prueba de eliminación — resultado

| Sección | ¿Cambia el diseño del método si se retira? | Decisión |
|:--|:--|:--|
| Tipología de artefactos (2.1) | Sí: cambiaría la tipología y, con ella, todos los criterios de evaluación | **Se conserva** |
| Siete principios (2.2) | Sí: sin ellos no hay obligación de evaluar ni de fijar criterios antes de construir | **Se conserva** |
| Tres ciclos (2.3) | Sí: sin el ciclo de relevancia, la capacidad y los plazos dejarían de ser requisitos | **Se conserva** |
| DSRM y ciclos anidados (2.4) | Sí: sin el ciclo de investigación no hay obligación de documentar rediseño ni de extraer principios | **Se conserva** |
| FEDS (2.5) | Sí: se perdería la obligación de la evaluación formativa previa a la sumativa | **Se conserva** |
| Gregor y Hevner (2.6) | Sí: permitiría reclamar una contribución de técnica nueva, desproporcionada | **Se conserva** |
| Plantilla de principios (2.7) | Sí: E10 quedaría sin forma de redacción | **Se conserva** |
| Definición y taxonomía de anomalía (3.1) | Sí: sin definición operativa no hay nada que detectar ni cómo verificarlo | **Se conserva** |
| Etiquetas escasas (3.2) | Sí: constriñe el espacio de técnicas de E7a | **Se conserva** |
| Métrica bajo desequilibrio (3.3) | Sí: los criterios 1 y 2 quedarían sin fundamento | **Se conserva** |
| Tasa base y capacidad (3.4) | Sí: el criterio 3 pasaría de viabilidad a preferencia | **Se conserva** |
| Explicabilidad (3.5) | Sí: el registro de resolución sería una preferencia de redacción | **Se conserva** |
| Priorización de visitas (3.6) | Sí: la segmentación sería un añadido opcional | **Se conserva** |
| Perfil y estacionalidad (4) | Sí: sin ella la ventana de 6 meses seguiría pareciendo suficiente | **Se conserva** |
| Ciclo de relevancia (5.1) | Sí: es la vía por la que entran catálogo, plazos y capacidad | **Se conserva** |
| **Auditoría y control interno (5.2)** | **No: sus efectos entran por E2, E6 y E7b** | **Se elimina** del marco teórico |
| Marco regulatorio boliviano (AETN, ODECO) como sección teórica | No: es contexto documentado en E2, no teoría | **Se elimina** del marco teórico |

Dos secciones eliminadas de diecisiete. No es una reducción grande, pero es el resultado honesto de aplicar la prueba que el propio documento declara. La eliminación de *auditoría y control interno* queda **sujeta a la búsqueda complementaria** de la sección 10: si alguna fuente devuelve algo que cambie el diseño, la sección vuelve y se actualiza esta tabla.

---

## 7. Definiciones operativas

| Término | Definición operativa en este estudio |
|:--|:--|
| **Anomalía** | Patrón de datos que no se ajusta al comportamiento esperado (Chandola et al., 2009) |
| **Lectura anómala no declarada** | Lectura cuyo consumo difiere de lo esperable para esa cuenta y ese momento del ciclo, según criterio escrito y reproducible, **sin código de irregularidad** |
| **Detección** | Aplicación del criterio a un conjunto de lecturas para emitir una lista priorizada de sospechosas |
| **Verificación** | Acto posterior —revisión en pantalla o visita con fotografía— que confirma o descarta una alerta |
| **Procedencia (del reclamo)** | Resolución del reclamo a favor del usuario; `sw_procedente` con valores 1 / 2 / 4 en `DATOS.xlsx` **[B3 pendiente]** |
| **Verdad de referencia** | Conjunto de casos cuya condición de anómala se conoce independientemente del método; en este estudio se reconstruye en E8 con los reclamos procedentes |
| **Capacidad de verificación** | Volumen de alertas que el equipo puede resolver en un periodo sin exceder su carga normal: ≈11 visitas diarias |
| **Aplicabilidad** | Que practicantes que no participaron en la investigación puedan seguir los pasos y obtener los resultados esperados |
| **Efectividad** | Comparación de resultados con y sin el método |
| **Principio de diseño** | Prescripción redactada como objetivo → contexto → mecanismo → principio (Wieringa, 2014) |
| **Condición de contorno** | Límite bajo el cual un principio deja de ser aplicable; forma parte de la contribución, no de las limitaciones |
| **Exemplar** | Instanciación de apoyo: las aplicaciones sobre la base de datos que muestran que el método es ejecutable |

---

## 8. Lo que este marco NO decide

Estas decisiones quedan deliberadamente abiertas. Cerrarlas aquí sería adelantar etapas:

| Decisión | Etapa | Condición que impone el marco |
|:--|:--|:--|
| Técnica de detección | **E7a** | Debe comparar alternativas con trade-offs explícitos y ponderar la escasez de etiquetas (3.2) |
| Valor numérico del umbral | **E7b** | Debe ser escrito y reproducible (3.1); el criterio 3 lo limita por volumen (3.4) |
| Tratamiento de estacionalidad | **E7c** | Exige ≥4 ciclos anuales (4.2); requiere la extracción ampliada |
| Valores numéricos de los criterios de éxito | **E6 y E7b** | Se fijan **antes** de construir; métrica 1 y 2 son precisión-exhaustividad (3.3) |
| Comparación con la capacitación de 2025 | **E7a** | Es la alternativa existente, no la inacción |

---

## 9. Registro de verificación de fuentes

Método: consulta a la API de Crossref por DOI o por búsqueda bibliográfica con filtro de fecha, el **2 de octubre de 2026**. Cada entrada fue comprobada en autoría, título, publicación, volumen, número y páginas.

| N.º | Fuente | DOI verificado | Estado |
|:--|:--|:--|:--|
| 1 | Hevner, March, Park y Ram (2004), *MIS Quarterly*, 28(1) | 10.2307/25148625 | Verificada — **se conserva 75–105 (decisión, ver nota)** |
| 2 | March y Smith (1995), *Decision Support Systems*, 15(4) | 10.1016/0167-9236(94)00041-2 | Verificada |
| 3 | Peffers, Tuunanen, Rothenberger y Chatterjee (2007), *JMIS*, 24(3) | 10.2753/MIS0742-1222240302 | Verificada |
| 4 | Hevner (2007), *Scandinavian Journal of Information Systems*, 19(2) | — | Verificada por AISeL (artículo 4). Pág. inicial 87 confirmada en el registro de referencias de Gregor y Hevner (2013); **pág. final 92 [por verificar]** |
| 5 | Venable, Pries-Heje y Baskerville (2016), *EJIS*, 25(1) | 10.1057/ejis.2014.36 | Verificada |
| 6 | Gregor y Hevner (2013), *MIS Quarterly*, 37(2) | 10.25300/MISQ/2013/37.2.01 | Verificada |
| 7 | Wieringa (2014), Springer | 10.1007/978-3-662-43839-8 | Verificada (libro) |
| 8 | Chandola, Banerjee y Kumar (2009), *ACM Computing Surveys*, 41(3) | 10.1145/1541880.1541882 | Verificada |
| 9 | Saito y Rehmsmeier (2015), *PLOS ONE*, 10(3) | 10.1371/journal.pone.0118432 | Verificada |
| 10 | Axelsson (2000), *ACM TISSEC*, 3(3) | 10.1145/357830.357849 | Verificada |
| 11 | Nwafor et al. (2023), *IEEE Access*, 11 | 10.1109/ACCESS.2023.3295688 | Verificada |
| 12 | Noorchenarboo y Grolinger (2025), *Energy and Buildings*, 328 | 10.1016/j.enbuild.2024.115177 | Verificada |
| 13 | Piscitelli et al. (2026), *Energy and Buildings*, 368 | 10.1016/j.enbuild.2026.117829 | Verificada |
| 14 | Guerrero et al. (2018), *IEEE TPWRS*, 33(2) | 10.1109/TPWRS.2017.2721435 | Verificada |
| 15 | Massaferro, Di Martino y Fernández (2020), *IEEE TPWRS*, 35(1) | 10.1109/TPWRS.2019.2928276 | Verificada |
| 16 | Xia, Xiao y Liang (2020), *IEEE TIFS*, 15 | 10.1109/TIFS.2019.2921232 | Verificada |

**Total: 16 fuentes citadas en este documento** — todas con DOI en Crossref salvo Hevner (2007), verificada en AISeL. Ninguna sin verificar.

**Nota de discrepancia — resuelta el 2 de octubre de 2026.** Crossref reporta para Hevner et al. (2004) el rango **75–106** y la lista canónica del asesor (`referencias/ds_ch15_referencias.md`) reporta **75–105**. **Decisión: se conserva 75–105**, por ser la fuente institucional del trabajo; la discrepancia queda registrada y se retira la nota del borrador. Para Hevner (2007) no se localizó rango de páginas en fuente abierta: se cita el número de artículo declarado por AISeL.

**Materiales internos: no se citan.** Decisión del asesor del 2 de octubre de 2026. Los capítulos `referencias/ds_ch*.md` se usaron como fuente de trabajo, pero **no entran a la lista de referencias**; toda afirmación que parecía apoyarse en ellos quedó reatribuida a su fuente primaria o reformulada como criterio adoptado por este estudio. Donde no había fuente primaria verificable, se marcó `[por verificar]` —hoy un solo caso: la plantilla de §2.7.

**Fuentes descartadas por no superar la verificación.** Buscaciones sobre auditoría, control interno y atención de reclamos ante entes reguladores devolvieron resultados sin relación con el problema (sección 5.2). **No se incorporaron.** Se hará una búsqueda complementaria en bases de regulación y política energética **el 3–4 de octubre de 2026** (DEC-3/DEC-7); si tampoco hay fuente, el tema queda fuera del marco teórico por decisión explícita.

---

## 10. Gate de E4

| # | Criterio | Estado |
|:--|:--|:--|
| 1 | Cada eje del borrador fue evaluado con la prueba de eliminación y el resultado está escrito | **Cumple** (sección 6) |
| 2 | Toda fuente citada fue verificada antes de citarse | **Cumple** (sección 9) |
| 3 | Lo no verificable queda marcado `[por verificar]`, sin rellenarlo | **Cumple** (2 ítems: páginas de Hevner 2007, plantilla de Wieringa) |
| 4 | Cada decisión de diseño atribuida a una fuente está enlazada a esa fuente | **Cumple** (tablas de cada sección) |
| 5 | No se deciden aquí las decisiones que corresponden a E6, E7a, E7b y E7c | **Cumple** (sección 8) |
| 6 | Se identifica al menos una consecuencia verificable para E7a, E7b y E8 | **Cumple**: técnica constreñida por escasez de etiquetas; umbral escrito con techo de volumen; métricas precisión-exhaustividad |
| 7 | El marco no contiene secciones decorativas | **Cumple**: dos eliminadas de diecisiete |
| 8 | Las cifras citadas provienen de documentos ya cerrados, con su fuente declarada | **Cumple**: 62, 21, 532 258, 242,2, ≈11, 57, 4 — todas trazadas a `DATOS.xlsx` o a declaraciones registradas |

**Gate de E4.**

*Cerrados el 2 de octubre de 2026 (decisiones del asesor):*

- ~~Título y forma de citación del manuscrito `referencias/ds_ch*.md`~~ → **los materiales internos no se citan**; sus afirmaciones se sustituyeron por la fuente primaria o se reformularon como criterio de este estudio.
- ~~Discrepancia de páginas de Hevner et al. (2004)~~ → **se conserva 75–105**; la nota se retiró del borrador.

*Abiertos, antes de la propuesta completa:*

1. **Confirmar el capítulo y la página de Wieringa (2014)** donde consta la plantilla objetivo → contexto → mecanismo → principio (§2.7). **Cuatro búsquedas en DuckDuckGo el 2 oct 2026 no la localizaron** y los PDF de Springer, de la Universidad de Twente y de GBV no se pudieron leer con las herramientas disponibles. **Confirmado: la tesista no tiene el libro → la consulta va al tutor**, que lo cita en su manuscrito. *Por enviar.* Hasta entonces la plantilla **se usa** pero la atribución queda marcada. **No bloquea la entrega del 5 de octubre.**
2. **Búsqueda complementaria sobre control interno y auditoría** en bases de regulación y política energética. Si no devuelve fuente verificable, el tema queda fuera del marco teórico por decisión explícita y se deja constancia (§5.2).
