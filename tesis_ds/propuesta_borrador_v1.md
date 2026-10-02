# Propuesta de investigación — primer borrador

> **Entrega: lunes 5 de octubre de 2026.** Documento de trabajo; se construye sobre E0–E5, **todas cerradas** (E4 y E5 el 2 de octubre de 2026, con entrega el 4).
> Las secciones 8, 9 y 12 quedan completas con fuentes verificadas una a una en Crossref. Siguen pendientes, por diseño, las secciones de E6 y E7 (criterios con valores numéricos, alternativas y diseño).

---

## 1. Título provisional

**Método para la detección y verificación previa a la facturación de lecturas anómalas no declaradas en la distribución de energía eléctrica: aplicación en ENDE.**

## 2. Planteamiento del problema

### 2.1 Problema de diseño

En la distribución comercial de energía eléctrica de ENDE, solo el 1,04 % de las lecturas facturables lleva un código de irregularidad —5 528 de 532 258 registros entre enero de 2025 y septiembre de 2026—. Esa marca la pone, en el momento de la lectura, el personal terciarizado que recorre los domicilios con equipos móviles de lecturación. El bloque sin marca representa el 98,96 % del volumen facturable y nadie lo barre: no existe ningún proceso que recorra el histórico para identificar lecturas cuyo consumo sea incoherente y que no fueron marcadas.

Existe una segunda capa, y conviene describirla con precisión porque es la que el método formaliza. Antes de facturar, el encargado de facturación revisa los consumos calculados y, cuando detecta una anomalía, solicita una visita al domicilio; el personal técnico toma la evidencia fotográfica del medidor y el encargado corrige la lectura. Ese paso **ya es una detección de anomalías**, pero no está escrito en ningún documento, no tiene umbral numérico y depende de la atención de una sola persona: se limita a juzgar si el consumo del mes difiere del histórico de los últimos seis meses, en sentido superior —estufas en invierno, aire acondicionado en verano— o inferior —viajes, vacaciones—. Si esa persona no revisa, no se detecta nada. El resultado son **242,2 correcciones manuales por mes en 2026**, sin registro de por qué se marcó ni de por qué se descartó una lectura.

Conviene declarar lo que ya se hizo, porque no es un problema de inacción. Las correcciones manuales pasaron de 1 507 mensuales en el primer semestre de 2025 a 295 a partir de junio de 2025 —una caída de 80 %—, resultado de capacitaciones impartidas al personal **en mayo y junio de 2025**. Esa capacitación se dirigió al personal **terciarizado** que registra las lecturas, cuyo error es una **lectura mal tomada**. La mitigación funcionó y, sin embargo, deja un residual estable de **242,2 correcciones mensuales en 2026**. El problema que este estudio aborda es ese residual y la ausencia de toda barrida sistemática sobre el histórico, no la ausencia de esfuerzo previo.

La corrección deja rastro en el log del sistema, pero **no hay un reporte accesible** que muestre la fecha y la lectura nueva, ni constancia de la justificación —la visita, la fotografía, el criterio aplicado—. Hoy solo se observa la lectura ya corregida y facturada; reconstruir cuándo se corrigió y por qué exige comparar contra el histórico de lecturas del lecturador.

Cada alerta que el encargado de facturación acepta termina en una visita al domicilio: el costo de una falsa alarma no es una revisión de pantalla, es un **desplazamiento**. Sobre las 242,2 correcciones mensuales y 22 días hábiles equivalen unas 11 visitas diarias, cifra que ya constituye la capacidad efectiva del equipo técnico y que fija el techo que el volumen de alertas del método no debe exceder. La evidencia fotográfica que respalda cada corrección se conserva en la computadora del encargado de facturación, fuera del sistema y sin enlace con la lectura que corrigió: queda guardada, pero no se audita desde el sistema ni puede consultarse junto al registro.

La evidencia del costo está en el ciclo de reclamos. La Oficina del Consumidor (ODECO) tramitó 314 reclamos en 21 meses, de los cuales 62 resultaron procedentes; 46 de esos 62 —el 74,19 %— provinieron de lecturas sin código de irregularidad, de modo que la anomalía no fue advertida por el proceso de lecturación sino reclamada por el usuario **después** de facturar, con plazos perentorios de 3 a 15 días hábiles y silencio administrativo positivo a favor del consumidor cuando la empresa no contesta. Verificar un caso cuesta entre 3 y 4 horas y, cuando exige visita del lecturador con respaldo fotográfico, 2 días. Adicionalmente, 252 de los 314 reclamos (80,25 %) resultaron improcedentes y consumieron la misma inspección técnica que los procedentes.

Se requiere construir un método que barra el histórico, priorice las lecturas sospechosas y las derive a verificación dentro de la cadena vigente, reduciendo la dependencia de la detección reactiva.

### 2.2 Problema de investigación

> En el formato institucional se registrará como **problema científico**.

La literatura sobre detección de anomalías en consumo eléctrico se apoya en series de consumo y, en los estudios de fraude, en etiquetas de casos confirmados. No hay, hasta donde se pudo indagar, evidencia sobre cómo un método que barre el histórico completo —incluidas las lecturas que el lecturador no marcó— se integra a un ciclo de lecturación-facturación sujeto al catálogo de códigos de un ente regulador, ni bajo qué criterios los verificadores de una distribuidora lo consideran utilizable cuando revisar un caso cuesta entre 3 y 4 horas. Este estudio genera esa evidencia.

*[Sustento: `05_estado_del_arte.md` §8. **Afirmación provisional** — búsqueda preliminar por Crossref el 2 oct 2026, sin IEEE Xplore ni SciELO/LILACS. **Se amplía el 3 y 4 de octubre** a esas dos bases —IEEE Xplore sobre metadatos y resúmenes, sin acceso institucional (DEC-1/DEC-6/DEC-7)— con cuenta de registros identificados, eliminados e incluidos, y entonces se confirma, amplía o retira (E5-3). Los artefactos comerciales y de código abierto quedan **fuera del alcance de esta versión** (DEC-2); Scopus y Web of Science **fuera de alcance** (DEC-8).]*

### 2.3 Evidencia disponible de que el problema existe

Fuente: extracción real de FACTUR sobre la regional de **29 750 cuentas** (dato exacto al cierre de septiembre de 2026), gestiones 2025 y 2026, 21 meses. Todos los porcentajes verificados aritméticamente contra el archivo. **El histórico en `tfv_historico_lecturador` llega hasta 2022** —57 meses y cuatro ciclos anuales completos—; la extracción empleada aquí cubre 21 y se ampliará antes de la construcción, porque de esa amplitud depende el tratamiento de estacionalidad y el volumen de casos disponibles para la evaluación.

| Evidencia | Valor | Fuente |
|:--|:--|:--|
| Reclamos tramitados ante la ODECO | 314 en 21 meses (≈ 15/mes) | `DATOS.xlsx`, Tabla 1 |
| Reclamos **procedentes** | 62 (19,75 % del total) | Tabla 1 |
| Procedentes originados en lecturas **sin** código | 46 de 62 → **74,19 %** | Tabla 1 |
| Procedentes originados en lecturas **con** código | 16 de 62, siendo ese tipo solo el **1,04 %** del facturable → tasa **33 veces mayor** por lectura | Tabla 1 + Tabla 3 |
| Reclamos **improcedentes** | 252 (80,25 %), con la misma carga de inspección de 3 a 15 días hábiles | Tabla 1 |
| Lecturas sin código sobre el volumen facturable | 526 730 de 532 258 → **98,96 %** | Tabla 3 |
| Correcciones manuales previas a la facturación, sin reporte accesible | **242,2 por mes** en 2026; 295 en jun–dic 2025; 1 507 antes de jun–2025. Naturaleza: **lectura mal tomada**. El cambio queda en el log, pero **no hay reporte de fecha ni de justificación** | Tabla 2; naturaleza y trazabilidad declaradas por la tesista |
| Efecto de las capacitaciones al personal (mayo–junio 2025) | Caída de **80 %** (1 507 → 295); residual 242,2 en 2026. Aplicadas al personal **terciarizado** que registra las lecturas | Caída confirmada en Tabla 2; causa y fechas declaradas |
| Evidencia fotográfica de la corrección | Se obtiene en visita al domicilio; se conserva en la **computadora del encargado**, fuera del sistema y sin enlace a la lectura corregida | Declaración de la tesista (2 oct 2026) |
| **Regla de detección vigente** | Desviación frente a los **últimos 6 meses**, en **ambas direcciones**; **sin umbral numérico ni registro** de la decisión | Declaración de la tesista (2 oct 2026) |
| Capacidad del equipo técnico | ≈ **11 visitas diarias** (242,2 correcciones ÷ 22 días hábiles); cada alerta aceptada termina en desplazamiento | Cálculo propio sobre Tabla 2 |
| Tiempo de verificación de un caso | 3 a 4 horas; 2 días con visita. **Promedio en consulta con el personal** | Práctica operativa (estimado, pendiente de promedio) |
| Facturas observadas y energía no facturada | Sin cifras disponibles | Vacío declarado |
| **Antigüedad del histórico de lecturas** | **Desde 2022** (57 meses, 4 ciclos anuales completos); la extracción usada aquí cubre 21 | Declaración de la tesista, 2 oct 2026 |

**Lectura del dato.** Auditar únicamente las lecturas con código habría alcanzado como máximo 16 de los 62 reclamos procedentes y se habría quedado sin detectar 46; pero esas mismas lecturas con código presentan 33 veces la tasa de procedencia por lectura. En consecuencia, el método debe barrer el conjunto completo **y** usar la familia de código como variable de priorización: el código no es el ámbito de trabajo, es la señal de riesgo.

**Segundo frente del problema.** Cuatro de cada cinco reclamos se resuelven en contra del usuario pero consumen la misma inspección técnica que los procedentes. El método no solo debe encontrar lo que no se marcó: puede dar al verificador evidencia para resolver improcedentes sin desplazamiento.

**Proceso existente que el método formaliza.** Se corrigen a mano un promedio de 242,2 lecturas por mes antes de facturar, con el fin de evitar reclamos. El cambio **queda en el log del sistema**, pero no existe un reporte accesible que muestre fecha y lectura nueva, ni constancia del criterio ni de la evidencia que lo justificó: hoy solo se observa la lectura ya corregida y facturada, y reconstruir la corrección exige comparar contra el histórico de lecturas del lecturador. Ese proceso es la línea base de carga y el límite de capacidad que el criterio de éxito n.º 3 respetará. La capacitación al personal —la otra medida vigente— reduce la frecuencia de los errores pero no prioriza ni barre el histórico; el método debe presentarse como complemento suyo, no como sustituto.

*[Pendiente: promedio de tiempo por corrección manual, desglosado por rama; visitas que no terminan en corrección (tasa de falsos positivos actual); conciliación de totales entre Tabla 2 y Tabla 3; antigüedad real de `tfv_historico_lecturador`. Ver `06_diagnostico.md`.]*

## 3. Objetivos

**General.** Diseñar, construir y evaluar un método de detección y verificación previa a la facturación de lecturas anómalas no declaradas en el ciclo de lecturación y facturación de energía eléctrica, y articular los principios de diseño que de su aplicación se desprenden.

**Específicos.** (1) Diagnosticar la magnitud y el costo de la detección reactiva actual con indicadores trazables a `tfv_historico_lecturador` y `tfv_reclamo`. (2) Determinar los requisitos del método y comparar alternativas de técnica de detección con trade-offs explícitos. (3) Construir el método y verificar su consistencia interna, documentando decisiones y rediseños. (4) Evaluarlo en un ciclo formativo con rediseño documentado y en un ciclo sumativo en el contexto real. (5) Articular los principios de diseño validados, con sus condiciones de contorno y las amenazas a la validez.

## 4. Pregunta de investigación

**Principal.** ¿Qué método de detección y verificación permite identificar lecturas anómalas no declaradas en el ciclo de lecturación y facturación de energía eléctrica de una distribuidora con sistema transaccional propio y catálogo regulatorio de irregularidades, y bajo qué condiciones lo consideran utilizable sus verificadores?

**Subpreguntas.** (1) *Diagnóstico:* ¿cuál es la magnitud de las anomalías no declaradas y cuánto cuesta hoy la detección reactiva? (2) *Construcción:* ¿qué segmentación, criterio de detección y reglas de verificación necesita el método para mantener las alertas dentro de la capacidad del equipo? (3) *Evaluación:* ¿con qué cobertura recupera los reclamos procedentes, con qué falsos positivos y con qué aplicabilidad? (4) *Conocimiento:* ¿qué principios de diseño son transferibles a distribuidoras reguladas por la AETN?

## 5. Objeto de estudio y tipología del artefacto

**Objeto de estudio:** el método de detección y verificación de lecturas anómalas no declaradas. **Tipología:** método —pasos, roles, entradas, salidas, precondiciones, criterios de entrada y salida, productos de trabajo—, acompañado de una instanciación de apoyo (aplicaciones sobre la base de datos) que hace de *exemplar*.

*Resignificación de Design Science, explícita:* el objeto de estudio no es el proceso de lecturación ni el fenómeno del fraude; éstos son el contexto. El objeto es el artefacto que se construye.

## 6. Campo de acción

Temático: detección y verificación de lecturas anómalas no declaradas. Temporal: histórico disponible en `tfv_historico_lecturador` y ciclos de facturación vigentes. Institucional: regionales del sistema de ENDE. **Clase de contextos:** distribuidoras reguladas por la AETN con sistema transaccional propio e histórico tabular de lecturas.

## 7. Propuesta y contribución reclamada

**Propuesta.** Método de detección segmentado por perfil de consumo y familia de código, con barrido sobre lecturas con y sin código, criterios de verificación escritos y registro de resolución; más su aplicación sobre el sistema real.

**Contribución reclamada.** Principios de diseño validados de nivel de maestría, con transferibilidad analítica —no estadística—. Condiciones de contorno: distribuidoras reguladas por la AETN con sistema propio e histórico tabular.

**Oración de contribución.** *Este estudio construye un método de detección y verificación previa a la facturación de lecturas sin código de irregularidad que presentan consumos atípicos, y de su aplicación y evaluación en ENDE se desprenden principios de diseño que permiten a una distribuidora regulada por la AETN incorporar detección sistemática a su ciclo de lecturación sin exceder la capacidad de su equipo de verificación.*

## 8. Marco teórico

Documento completo: `04_marco_teorico.md` (E4, cerrada el 2 de octubre de 2026). Cada fuente fue verificada en Crossref antes de citarse.

### 8.1 Design Science como paradigma

**Tipología del artefacto.** March y Smith (1995) identificaron cuatro tipos de artefacto —constructos, modelos, métodos e instanciaciones—; Hevner et al. (2004) los adoptaron como núcleo de los siete principios del paradigma y establecieron que **la evaluación apropiada depende del tipo de artefacto**. Un método se evalúa por **aplicabilidad** (¿pueden los practicantes seguir los pasos?) y **efectividad** (resultados con y sin el método); una instanciación, por métricas de rendimiento. De ahí que este estudio declare un **método** con una instanciación de apoyo que hace de *exemplar*, y que sus criterios de éxito sean de aplicabilidad y efectividad, **no pruebas de rendimiento de software**.

**Proceso.** El DSRM de Peffers et al. (2007) —seis actividades y tres puntos de entrada— aporta la estructura de planificación y comunicación. Wieringa (2014) aporta la estructura lógica: **dos ciclos anidados**, el de ingeniería (análisis del problema, diseño, validación, implementación, evaluación en contexto) y el de investigación (problema de investigación, construcción del artefacto como experimento, evaluación de la contribución, comunicación). La distinción es operativa: **el ciclo de ingeniería puede cerrarse con éxito sin que el de investigación genere contribución alguna**. En este estudio, el de ingeniería corresponde a E7a–E7f y E8; el de investigación, a E0–E6 y E9–E10.

**Evaluación.** FEDS (Venable et al., 2016) separa el **propósito** —formativo o sumativo— del **estilo** —artificial o naturalista—. De ahí la obligación de un ciclo formativo con rediseño documentado previo al sumativo, no de una única evaluación presentada como completa.

**Ciclos.** Hevner (2007) organiza el paradigma en ciclo de **relevancia**, **rigor** y **diseño**. Su efecto aquí es decisivo: el catálogo de códigos, los plazos de la ODECO (3 a 15 días hábiles), los cinco roles de la cadena de corrección y la capacidad de ≈11 visitas diarias **entran al diseño por el ciclo de relevancia**; por eso no son condiciones externas que pueda relajar el método, sino requisitos que lo constituyen. E4 y E5 son el ciclo de rigor.

**Nivel de la contribución.** Gregor y Hevner (2013) proponen juzgar la contribución por dos dimensiones: el estado del conocimiento en el **dominio del problema** y en el **dominio de la solución**. Aquí el dominio del problema es **escaso** —no hay documentación académica sobre detección de lecturas anómalas no declaradas en distribuidoras reguladas por la AETN— y el dominio de la solución es **abundante** —tres revisiones sistemáticas desde 2020 (§9)—. Con esa combinación, **la contribución no puede ser una técnica nueva de detección**, sino la formalización del problema y sus principios de diseño con condiciones de contorno explícitas. Ese es el alcance exacto de la oración de contribución adoptada en el gate de E3.

**Forma del principio de diseño.** Los principios de E10 se redactarán con la plantilla **objetivo → contexto → mecanismo → principio**, atribuida a Wieringa (2014) `[por verificar: capítulo y página]`. El objetivo especifica qué se pretende lograr; el contexto delimita las condiciones bajo las cuales aplica; el mecanismo explica por qué funciona; el principio prescribe qué debe tener el artefacto.

### 8.2 Qué es una anomalía y cómo se evalúa su detección

**Definición.** Chandola et al. (2009) definen la anomalía como un patrón de datos que no se ajusta al comportamiento esperado, y distinguen tres tipos: **punto**, **contextual** y **colectivo**. El caso de este estudio es fundamentalmente **contextual** —500 kWh son normales en julio y anómalos en abril para la misma cuenta— sobre la trayectoria completa de la serie, es decir, una **subsecuencia anómala**.

**Definición operativa adoptada:** *lectura cuyo consumo registrado difiere, en sentido superior o inferior, de lo esperable para esa cuenta y ese momento del ciclo, según un criterio escrito y reproducible, y que no lleva código de irregularidad en el momento de la lectura.* Tres condiciones la hacen verificable por alguien ajeno al estudio: criterio escrito —la regla vigente carece de umbral numérico y de registro—, ambas direcciones, y ausencia de marca previa.

**Etiquetas escasas.** Chandola et al. (2009) distinguen métodos supervisados, que exigen etiquetas, de no supervisados, que modelan la normalidad. Aquí las etiquetas positivas son **62 reclamos procedentes en 21 meses** (`DATOS.xlsx`, Tabla 1), y además **no son detecciones sino quejas de usuarios posteriores a la facturación**. Este marco **no elige la técnica** —eso es de E7a—, pero constriñe el espacio de opciones: cualquier alternativa que exija un corpus amplio de casos etiquetados parte con una desventaja documentada.

**Métrica.** Saito y Rehmsmeier (2015) demuestran que, ante datos desequilibrados, **la gráfica precisión-exhaustividad es más informativa que la curva ROC**. De ahí que los criterios de éxito n.º 1 y 2 sean cobertura y falsos positivos y **quede descartada la exactitud (accuracy)** como criterio: en este conjunto sería engañosa.

**Coste de la alerta.** Axelsson (2000) documentó la **falacia de la tasa base**: con poca proporción de casos verdaderos, una tasa de falsos positivos aparentemente pequeña produce una mayoría de alarmas falsas, y mejorar la exactitud no reduce el problema sino que lo oculta. Aquí el efecto es material: **cada alerta aceptada termina en una visita**, de modo que el coste de una falsa alarma es un desplazamiento y no una revisión de pantalla. El criterio de éxito n.º 3 —carga dentro de la capacidad de ≈11 visitas diarias— **es el criterio de viabilidad del artefacto**, no una preferencia de comodidad.

**Explicabilidad.** Nwafor et al. (2023) aplican inteligencia artificial explicable a la predicción de pérdidas no técnicas; Noorchenarboo y Grolinger (2025) explican la detección de anomalías en consumo atendiendo a los datos contextualmente relevantes. De ahí el requisito de que cada alerta lleve **la comparación concreta que la originó** y de que la resolución quede registrada con su criterio y su evidencia.

**Priorización.** Guerrero et al. (2018) reducen pérdidas no técnicas mejorando la exactitud de las inspecciones; Massaferro et al. (2020) formulan la detección para maximizar el retorno económico; Xia et al. (2020) proponen inspección por evaluación de sospecha. El campo ya sabe que **detectar no basta: hay que decidir a quién visitar**. Por eso la segmentación por perfil de consumo y familia de código es parte del método, no un refinamiento posterior.

### 8.3 Perfil de consumo y estacionalidad

Piscitelli et al. (2026) procesan el perfilado de carga como paso previo a la detección a nivel de medidor: **el perfil precede a la detección**. En estacionalidad, la consecuencia es lógica antes que bibliográfica: la regla vigente compara el mes contra los **seis meses anteriores**, ventana que **no incluye el mismo mes del año anterior**, de modo que un ciclo anual completo queda fuera de la comparación. La solución es empírica —**el histórico llega a 2022: 57 meses y cuatro ciclos anuales completos** (declaración de la tesista, 2 oct 2026)— y su consecuencia operativa es la ampliación de la extracción (A2.1–A2.4) antes de construir.

### 8.4 El entorno regulado como fuente de requisitos

| Aporte del entorno | Fuente | Efecto en el diseño |
|:--|:--|:--|
| Catálogo de códigos de irregularidad | `02_delimitacion.md` | Barrido **con y sin código**; el código es variable de priorización, no ámbito de trabajo |
| Plazos de la ODECO de 3 a 15 días hábiles | `02_delimitacion.md` | El método opera **antes** de facturar; la detección reactiva llega tarde por diseño |
| Capacidad de ≈11 visitas diarias | `06_diagnostico.md` | Techo de alertas: criterio de éxito n.º 3 |
| Cinco roles en cinco pasos de la cadena de corrección | `06_diagnostico.md` | Estructura de roles; punto único en el encargado de facturación |

### 8.5 Prueba de eliminación — resultado

*Si al retirar una sección del marco el diseño del método no cambia, esa sección es decorativa y se elimina.* Se evaluaron diecisiete secciones: **quince se conservan y dos se eliminan** —**auditoría y control interno** (no se localizó fuente verificable que cambiara el diseño; sus exigencias entran por E2, E6 y E7b) y **marco regulatorio como sección teórica** (es contexto documentado en E2, no teoría). Detalle en `04_marco_teorico.md` §6.

### 8.6 Lo que el marco NO decide

| Decisión | Etapa | Condición que impone el marco |
|:--|:--|:--|
| Técnica de detección | **E7a** | Debe comparar alternativas con trade-offs explícitos y ponderar la escasez de etiquetas |
| Valor numérico del umbral | **E7b** | Escrito y reproducible; limitado por volumen de alertas |
| Tratamiento de estacionalidad | **E7c** | Exige ≥4 ciclos anuales: la extracción ampliada |
| Valores numéricos de los criterios de éxito | **E6 y E7b** | Se fijan **antes** de construir; métricas precisión-exhaustividad |
| Comparación con la capacitación de mayo–junio de 2025 | **E7a** | Es la alternativa existente, no la inacción |

## 9. Estado del arte

Documento completo: `05_estado_del_arte.md` (E5, cerrada el 2 de octubre de 2026). **Advertencia de alcance:** es una búsqueda preliminar, no una revisión sistemática; las afirmaciones de brecha son **provisionales**.

### 9.1 Protocolo — versión 1

| Elemento | Descripción |
|:--|:--|
| Base | Crossref (API pública), 2 oct 2026. **Ampliación 3–4 oct:** IEEE Xplore (metadatos y resúmenes, sin acceso institucional) + SciELO + LILACS |
| Consultas | Búsqueda bibliográfica por cadena con orden por relevancia + resolución directa por DOI |
| Filtros | Artículos de revista; desde 2015 salvo trabajos canónicos |
| Cadenas | `non-technical losses detection electricity distribution review` · `electricity theft detection smart meter machine learning unsupervised` · `smart meter data anomaly detection review energy consumption` · `regulation incentives non-technical losses distribution utility tariff auditing` · `electricity distribution consumer complaints ombudsman regulation service quality` |
| Inclusión | Detección de anomalías o pérdidas no técnicas en distribución eléctrica, o aspectos metodológicos de detección, con revisión por pares |
| Exclusión | Editoriales sin revisión por pares; actas de divulgación; metadatos incompletos; resultados sin relación |
| Corpus incorporado | **15 trabajos** (6 del eléctrico como fenómeno y 9 de detección e inspección), más los 7 de Design Science de §8 → **22 entradas** |

**No se hizo todavía, y así se decide:** consulta a **IEEE Xplore y SciELO/LILACS**, **programada para el 3 y 4 de octubre de 2026**, con cuenta de registros identificados, eliminados e incluidos. **IEEE Xplore se consultará sobre metadatos y resúmenes públicos**, por no haber acceso institucional: es una **limitación del protocolo**, no un detalle operativo, y condiciona qué se pudo leer de cada registro. **Scopus y Web of Science quedan fuera del alcance de este ciclo.** Tampoco se aplicó doble criba independiente —limitación declarada, con una sola revisora— ni se calcularon conteos de flujo, que dependen de esa ampliación. **Los artefactos comerciales y de código abierto se difieren a después de la defensa de propuesta (DEC-2)** y quedan **fuera del alcance de esta versión**, no como pendiente dentro de él. **En consecuencia, la ausencia de trabajos bolivianos o del marco AETN es un vacío de búsqueda, no una constatación.**

### 9.2 Corpus verificado — cuatro ejes

- **A. Pérdidas no técnicas: concepto y revisiones.** Carr y Thomson (2022); Saeed et al. (2020); Yadav y Kumar (2022); de Oliveira Ventura et al. (2020); Henriques et al. (2020); Zhang et al. (2026).
- **B. Detección de anomalías: métricas, desequilibrio, explicabilidad.** Chandola et al. (2009); Axelsson (2000); Saito y Rehmsmeier (2015); Noorchenarboo y Grolinger (2025); Piscitelli et al. (2026); Nwafor et al. (2023).
- **C. Del algoritmo a la inspección.** Guerrero et al. (2018); Massaferro et al. (2020); Xia et al. (2020).
- **D. Design Science y método.** Hevner et al. (2004); March y Smith (1995); Peffers et al. (2007); Hevner (2007); Venable et al. (2016); Gregor y Hevner (2013); Wieringa (2014).

### 9.3 Hallazgos

**El concepto es más ancho que el fraude.** Carr y Thomson (2022) definen la pérdida no técnica de electricidad como un conjunto que **comprende robo, fraude, impago e irregularidades de facturación**. El problema de diseño de este estudio cae en el componente de **irregularidad de facturación**, no únicamente en fraude. El mismo trabajo señala que la mayor proporción de pérdidas proviene de grandes usuarios y hogares de mejor posición económica, y no del usuario residencial de bajos recursos que ocupa la percepción pública: priorizar por perfil y familia de código, y no por suposición sobre el tipo de usuario, es la decisión correcta.

**El campo está maduro.** Tres revisiones sistemáticas o comprehensivas en seis años —Saeed et al. (2020), que clasifica los métodos por algoritmos, características y métricas y compara las categorías basada en datos, basada en red e híbrida; Yadav y Kumar (2022); Zhang et al. (2026)— confirman que el problema y sus soluciones están ampliamente cubiertos. Hay también trabajo regional: de Oliveira Ventura et al. (2020) proponen comparar soluciones a las pérdidas no técnicas **en Sudamérica**, en una revista de política y regulación.

**El dato es distinto.** El patrón dominante usa **medidor inteligente de alta frecuencia** (Saeed et al., 2020; Yadav y Kumar, 2022; Zhang et al., 2026). Este estudio dispone de una **lectura mensual tabular** en `tfv_historico_lecturador`. Piscitelli et al. (2026) ilustran el extremo opuesto con perfilado de carga y detección a nivel de medidor. La diferencia de dato condiciona las características construibles, las etiquetas disponibles y lo que se puede prometer.

**La etiqueta es distinta.** En la literatura la etiqueta positiva es un caso confirmado de fraude o robo. Aquí es el **reclamo procedente ante la ODECO**: escaso **y** retardado —el usuario reclamó *después* de facturar—. Marca lo que ya fracasó, no lo que el método debió encontrar. Esto vuelve a la evaluación retrospectiva de E8 una prueba **conservadora**.

**El campo ya sabe que hay que priorizar inspecciones.** Guerrero et al. (2018) mejoran la exactitud de las inspecciones; Massaferro et al. (2020) maximizan el retorno económico; Xia et al. (2020) inspeccionan por evaluación de sospecha. Este estudio **no descubre** ese principio: lo lleva a su forma procesal —pasos, roles, criterio escrito, techo de capacidad, registro de resolución— dentro de una cadena que ya existe.

### 9.4 Por qué las soluciones existentes no bastan

| Dimensión | Soluciones existentes | Exigencia de este problema |
|:--|:--|:--|
| Origen del dato | Medidor inteligente de alta frecuencia (AMI) | Lectura **mensual** tabular |
| Etiqueta | Casos confirmados de fraude, o ausencia de etiquetas | 62 reclamos procedentes en 21 meses, posteriores a la facturación |
| Objetivo | Detectar robo, fraude o pérdida no técnica | Detectar **lectura anómala no declarada**, incluida la lectura mal tomada |
| Universo | Cuenta contra red, sin marca previa | **98,96 %** sin código y **1,04 %** con código, en el mismo barrido |
| Salida | Puntuación o clasificación binaria | **Lista priorizada con techo de volumen**: ≈11 visitas diarias, cada alerta acatada es un desplazamiento |
| Explicación | Campo en expansión, no universal | **Obligatoria**: sin la comparación que originó la alerta, el verificador no puede resolver |
| Integración | El modelo es el final del artículo | El artefacto **es el proceso**: pasos, roles, criterios, registro |
| Evaluación | Exactitud, F1, AUC | Aplicabilidad con verificadores ajenos + efectividad retrospectiva + carga dentro de capacidad |
| Punto de comparación | Ausente | La **capacitación de mayo–junio de 2025**, que ya redujo el volumen un 80 % |

### 9.5 Brecha identificada — formulación provisional

> **Provisional.** Fundada en la búsqueda preliminar de §9.1. Se sostiene hasta ejecutar la ampliación del **3–4 de octubre**; entonces se confirmará, ampliará o retirará (E5-3).

La literatura ha resuelto **cómo puntuar una lectura** y ha reconocido **que inspeccionar exige priorizar**. No se localizó, en esta pasada, trabajo que documente **cómo convertir esa puntuación en una decisión operativa dentro de un ciclo de lecturación-facturación sujeto a un catálogo regulatorio de irregularidades**, cuando concurren cuatro condiciones medidas aquí: (1) etiquetas escasas y retardadas; (2) coste de la alerta no recuperable, porque cada alerta acatada consume una visita; (3) una alternativa vigente ya eficaz —la capacitación de 2025—, de modo que el problema real es el **residual** y no la inacción; (4) un universo segmentado por el regulador en el que el 98,96 % circula sin código y ningún proceso lo barre.

**Aporte de esta propuesta, en una frase.** No un detector nuevo, sino la **formalización como método** —pasos, roles, criterio escrito, techo de capacidad y registro de resolución— de una detección que hoy existe informalmente en una sola persona, y los **principios de diseño** que de su aplicación se desprenden para una distribuidora regulada por la AETN.

### 9.6 Qué se buscó y no se encontró

Registrar los vacíos es parte del protocolo. Aquí **no se afirma que algo no exista**: se afirma que **esta búsqueda no lo encontró**.

| Búsqueda sin resultado | Interpretación | Acción |
|:--|:--|:--|
| Auditoría y control interno en distribuidoras reguladas | Cadena sin retorno útil | Retirado del marco teórico (§8.5); queda como condición de contorno empírica. **Una búsqueda complementaria (DEC-3)** en bases de regulación y política energética **el 3–4 de octubre**: si no hay fuente, se cierra por decisión explícita |
| Atención de reclamos ante entes reguladores | Mismos resultados no pertinentes | **Misma búsqueda complementaria** que la fila anterior: bases de regulación y política energética |
| Distribuidoras bolivianas o marco AETN | **Vacío de búsqueda**: no se consultaron SciELO ni LILACS | **Ampliación 3–4 oct:** IEEE Xplore (metadatos y resúmenes) + SciELO/LILACS, con conteo de registros identificados, eliminados e incluidos |
| Artefactos comerciales y de código abierto | **No se buscó**; requiere método distinto al bibliográfico | **Diferido a después de la defensa de propuesta** (decisión del asesor, 2 oct 2026): **fuera del alcance de esta versión** |
| "Lectura mal tomada" como categoría de anomalía | No localizado | Es la categoría central del estudio; verificar con búsqueda ampliada |

### 9.7 Consecuencia para las etapas siguientes

| Etapa | Qué le entrega E5 |
|:--|:--|
| **E7a** | Espacio de opciones constreñido por el dato mensual y la escasez de etiquetas; priorización bajo capacidad obligatoria; comparación **contra la capacitación de 2025** |
| **E7b** | Cinco exigencias convertidas en requisitos verificables: criterio escrito, ambas direcciones, techo de volumen, explicación obligatoria, registro de resolución |
| **E7c** | Segmentación por perfil previa a la detección; estacionalidad anual sostenida por los 57 meses — **exige ejecutar antes la extracción ampliada** |
| **E8** | Métricas precisión-exhaustividad; evaluación retrospectiva conservadora; dos ciclos con rediseño |
| **E9 / E10** | Principios con objetivo → contexto → mecanismo → principio y condiciones de contorno explícitas |

## 10. Diseño metodológico y estrategia de evaluación

**Proceso:** DSRM de Peffers et al. (2007), operado en ciclos de Wieringa (2014).

**Evaluación (FEDS):**

| Ciclo | Propósito | Método | Muestra |
|:--|:--|:--|:--|
| Formativa de campo | Detectar problemas y rediseñar | Aplicación a un periodo histórico acotado por el equipo de validación, con registro de hallazgos y rediseños | Personal de validación en sitio, no involucrado en la delimitación |
| Sumativa de campo | Demostrar utilidad y sustentar la contribución | Prueba retrospectiva: ¿el método habría alertado antes los reclamos procedentes? + carga de verificación + aplicabilidad | Reclamos de un periodo completo; verificadores y personal de respuesta al ODECO |

**Criterios de éxito** (valores numéricos a fijar en E6 y E7b, **antes** de construir): cobertura retrospectiva de reclamos procedentes; falsos positivos; carga de verificación dentro de la capacidad del equipo; aplicabilidad sin asistencia de la autora.

**Métodos propios de la tipología:** aplicabilidad y efectividad. No se emplean pruebas de rendimiento de software, que corresponden a una instanciación.

## 11. Cronograma

| Periodo | Actividades | Etapas |
|:--|:--|:--|
| 26 sep – 5 oct | Delimitación, perfil, marco teórico, estado del arte y **primer borrador de propuesta** | E2–E5, este documento |
| 6 – 12 oct | **Ejecución de la extracción ampliada a 2022** (A2.1–A2.4); resolución de los huecos B1, B2 y B3; primera pasada de E6 | A2.1–A2.4, E6 |
| 13 – 26 oct | Diagnóstico con indicadores; alternativas, requisitos y diseño | E6, E7a–E7c |
| 27 – 31 oct | Plan de construcción, criterio de suficiencia; **propuesta completa** | E7d |
| 1 – 8 nov | Construcción y verificación interna; ficha del artefacto | E7e, E7f |
| 9 – 15 nov | Evaluación formativa de campo | E8 formativa |
| **16 – 18 nov** | **Rediseño documentado** | E8 |
| 19 – 24 nov | Evaluación sumativa de campo | E8 sumativa |
| 25 – 27 nov | Trazabilidad, principios de diseño, conclusiones | E9, E10 |
| 28 – 30 nov | Redacción final y traducción institucional | E10 |

## 12. Referencias

Veintidós entradas. **21** se verificaron contra Crossref por DOI y **1** (Hevner, 2007) en AISeL, comprobando autoría, título, publicación, volumen, número y páginas, el 2 de octubre de 2026. **No se citan materiales internos (DEC-4):** las afirmaciones que parecían apoyarse en los capítulos `referencias/ds_ch*.md` se sustituyeron por su fuente primaria o se reformularon como criterio de este estudio. Una entrada lleva salvedad anotada; las pendencias que quedan fuera de la lista se registran al final.

Axelsson, S. (2000). The base-rate fallacy and the difficulty of intrusion detection. *ACM Transactions on Information and System Security*, *3*(3), 186–205. https://doi.org/10.1145/357830.357849

Carr, D., & Thomson, M. (2022). Non-Technical Electricity Losses. *Energies*, *15*(6), 2218. https://doi.org/10.3390/en15062218

Chandola, V., Banerjee, A., & Kumar, V. (2009). Anomaly detection: A survey. *ACM Computing Surveys*, *41*(3), 1–58. https://doi.org/10.1145/1541880.1541882

Gregor, S., & Hevner, A. R. (2013). Positioning and presenting design science research for maximum impact. *MIS Quarterly*, *37*(2), 337–355. https://doi.org/10.25300/MISQ/2013/37.2.01

Guerrero, J. I., Monedero, I., Biscarri, F., Biscarri, J., Millán, R., & León, C. (2018). Non-technical losses reduction by improving the inspections accuracy in a power utility. *IEEE Transactions on Power Systems*, *33*(2), 1209–1218. https://doi.org/10.1109/TPWRS.2017.2721435

Henriques, H. O., Corrêa, R. L. S., Fortes, M. Z., Borba, B. S. M. C., & Ferreira, V. H. (2020). Monitoring technical losses to improve non-technical losses estimation and detection in LV distribution systems. *Measurement*, *161*, 107840. https://doi.org/10.1016/j.measurement.2020.107840

Hevner, A. R., March, S. T., Park, J., & Ram, S. (2004). Design science in information systems research. *MIS Quarterly*, *28*(1), 75–105. https://doi.org/10.2307/25148625

Hevner, A. R. (2007). A three cycle view of design science research. *Scandinavian Journal of Information Systems*, *19*(2), Artículo 4. https://aisel.aisnet.org/sjis/vol19/iss2/4
*[Nota de verificación: se cita el número de artículo declarado por AISeL; no se localizó rango de páginas en fuente abierta. La página inicial 87 consta en el registro de referencias de Gregor y Hevner (2013).]*

March, S. T., & Smith, G. F. (1995). Design and natural science research on information technology. *Decision Support Systems*, *15*(4), 251–266. https://doi.org/10.1016/0167-9236(94)00041-2

Massaferro, P., Di Martino, J. M., & Fernández, A. (2020). Fraud detection in electric power distribution: An approach that maximizes the economic return. *IEEE Transactions on Power Systems*, *35*(1), 703–710. https://doi.org/10.1109/TPWRS.2019.2928276

Noorchenarboo, M., & Grolinger, K. (2025). Explaining deep learning-based anomaly detection in energy consumption data by focusing on contextually relevant data. *Energy and Buildings*, *328*, 115177. https://doi.org/10.1016/j.enbuild.2024.115177

Nwafor, O. N., Okafor, E., Aboushady, A. A., Nwafor, C., & Zhou, C. (2023). Explainable artificial intelligence for prediction of non-technical losses in electricity distribution networks. *IEEE Access*, *11*, 73104–73115. https://doi.org/10.1109/ACCESS.2023.3295688

de Oliveira Ventura, L., Melo, J. D., Padilha-Feltrin, A., Fernández-Gutiérrez, J. P., Sánchez Zuleta, C. C., & Piedrahita Escobar, C. C. (2020). A new way for comparing solutions to non-technical electricity losses in South America. *Utilities Policy*, *67*, 101113. https://doi.org/10.1016/j.jup.2020.101113

Peffers, K., Tuunanen, T., Rothenberger, M. A., & Chatterjee, S. (2007). A design science research methodology for information systems research. *Journal of Management Information Systems*, *24*(3), 45–77. https://doi.org/10.2753/MIS0742-1222240302

Piscitelli, M. S., Buscemi, G., Roselli, C., Marrasso, E., Pallotta, G., & Capozzoli, A. (2026). A novel data-analytics based process for load profiling and meter-level anomaly detection in building energy consumption time series. *Energy and Buildings*, *368*, 117829. https://doi.org/10.1016/j.enbuild.2026.117829

Saeed, M. S., Mustafa, M. W., Hamadneh, N. N., Alshammari, N. A., Sheikh, U. U., Jumani, T. A., Khalid, S. B. A., & Khan, I. (2020). Detection of non-technical losses in power utilities — A comprehensive systematic review. *Energies*, *13*(18), 4727. https://doi.org/10.3390/en13184727

Saito, T., & Rehmsmeier, M. (2015). The precision-recall plot is more informative than the ROC plot when evaluating binary classifiers on imbalanced datasets. *PLOS ONE*, *10*(3), e0118432. https://doi.org/10.1371/journal.pone.0118432

Venable, J., Pries-Heje, J., & Baskerville, R. (2016). FEDS: A framework for evaluation in design science research. *European Journal of Information Systems*, *25*(1), 77–89. https://doi.org/10.1057/ejis.2014.36

Wieringa, R. J. (2014). *Design science methodology for information systems and software engineering*. Springer. https://doi.org/10.1007/978-3-662-43839-8

Xia, X., Xiao, Y., & Liang, W. (2020). SAI: A suspicion assessment-based inspection algorithm to detect malicious users in smart grid. *IEEE Transactions on Information Forensics and Security*, *15*, 361–374. https://doi.org/10.1109/TIFS.2019.2921232

Yadav, R., & Kumar, Y. (2022). The detection of non-technical losses and electricity theft by smart meter data and artificial intelligence in the context of electric distribution utilities: A comprehensive review. *International Journal of Computing and Digital Systems*, *12*(1), 731–740. https://doi.org/10.12785/ijcds/120160

Zhang, B., Lin, G., Zheng, K., & Du, J. (2026). Anomaly detection and data repair for smart meter data in smart cities: A comprehensive review and future perspectives. *Sensors*, *26*(16), 5122. https://doi.org/10.3390/s26165122

### Estado de la verificación

| Grupo | Entradas |
|:--|:--|
| Design Science y método | 7 |
| Detección de anomalías, métricas y explicabilidad | 6 |
| Dominio: pérdidas no técnicas e inspección | 9 |
| **Total** | **22** |

**Cómo se verificaron las 22:**

- **21** — comprobadas contra Crossref por DOI, con autoría, título, publicación, volumen, número y páginas.
- **1** — Hevner (2007), comprobada en AISeL (artículo 4); sin DOI publicado.

**Entrada con salvedad anotada: 1** — Hevner (2007), sin rango de páginas en fuente abierta.

**Entradas sin verificar: 0.**

**Pendencias que quedan fuera de esta lista** y se siguen en `04_marco_teorico.md` §10:

- **Hevner et al. (2004):** se conserva 75–105 **(DEC-5)**; Crossref reporta 75–106.
- **Plantilla objetivo → contexto → mecanismo → principio:** `[por verificar]` el capítulo y la página de Wieringa (2014). Cuatro búsquedas el 2 oct 2026 no la localizaron; **consulta pendiente al tutor**. La plantilla se usa igualmente.
- **Control interno y auditoría (DEC-3):** búsqueda complementaria en bases de regulación y política energética **el 3–4 de octubre**; si no hay fuente, queda fuera del marco por decisión explícita.
- **Materiales internos `referencias/ds_ch*.md` (DEC-4):** **no se citan**; sus afirmaciones se sustituyeron por la fuente primaria correspondiente.

## 13. Anexo: artefacto previsto

Método de detección y verificación, descrito con: entradas (`tfv_historico_lecturador`, `tfv_reclamo`, catálogo de códigos); segmentación por perfil de consumo y familia de código; criterio de detección elegido en E7a con su justificación; reglas de prioridad y criterios de verificación escritos; roles sobre la cadena vigente —recepción del ODECO, validación en sitio, respuesta al ODECO, conciliación—; formato de registro de resolución; y las aplicaciones sobre la base que lo instancian.

*[Descripción preliminar: se enriquece en E7c con la ficha de diseño y el diagrama de estructura.]*
