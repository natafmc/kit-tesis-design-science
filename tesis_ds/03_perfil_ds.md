# E3 — Perfil de investigación en Design Science

> Borrador entregado a la tesista el 26 de septiembre de 2026. El gate de E3 exige **una sola oración, con las palabras de la tesista, que enuncie la contribución original de conocimiento**. Falta esa oración.

## 1. Título provisional

**Método para la detección y verificación de lecturas anómalas no declaradas en la distribución de energía eléctrica: aplicación en ENDE.**

Declara artefacto (método), clase de problema (lecturas anómalas no declaradas) y contexto (distribución de energía eléctrica, caso ENDE). No declara técnica, porque ésta se decide en E7a.

## 2. Planteamiento del problema

**Problema de diseño.** En la distribución comercial de energía eléctrica de ENDE, cerca del 25 % de las lecturas de cada ciclo se resuelve con un código de irregularidad y la detección depende del criterio individual del lecturador en el momento de la lectura. No existe ningún proceso que recorra el histórico para identificar lecturas cuyo consumo sea incoherente y que no fueron marcadas. La ODECO recibe unos 50 reclamos por mes y unos 40 resultan procedentes: en esos casos la anomalía no la detectó el proceso de lecturación, la reclamó el usuario después de facturar. Verificar un caso cuesta entre 3 y 4 horas y, si exige visita en sitio, 2 días. Se requiere construir un método que barra el histórico, priorice las lecturas sospechosas y las derive a verificación dentro de la cadena vigente, reduciendo la dependencia de la detección reactiva.

**Problema de investigación** *(en el formato institucional se registrará como **problema científico**)*. La literatura sobre detección de anomalías en consumo eléctrico se apoya en series de consumo y en etiquetas de fraude confirmado; *[por verificar en E5]*. No hay evidencia sobre cómo un método que barre el histórico completo —incluidas las lecturas que el lecturador no marcó— se integra a un ciclo de lecturación-facturación sujeto al catálogo de códigos de un ente regulador, ni bajo qué criterios los verificadores de una distribuidora lo consideran utilizable cuando revisar un caso cuesta entre 3 y 4 horas. Este estudio genera esa evidencia.

**Relación entre ambos.** El problema de diseño no se resuelve sin construir; el problema de investigación no se resuelve sin evaluar esa construcción. Si solo se articula el primero, el trabajo es un proyecto de ingeniería bien documentado.

## 3. Pregunta de investigación

**Pregunta principal (prescriptiva-analítica, de clase):**

> ¿Qué método de detección y verificación permite identificar lecturas anómalas no declaradas en el ciclo de lecturación y facturación de energía eléctrica de una distribuidora con sistema transaccional propio y catálogo regulatorio de irregularidades, y bajo qué condiciones lo consideran utilizable sus verificadores?

Tiene componente de **utilidad** (¿permite identificar y verificar?) y de **conocimiento** (¿bajo qué condiciones es utilizable y qué principios de eso se extraen?).

**Subpreguntas:**

1. *Diagnóstico:* ¿cuál es la magnitud de las anomalías no declaradas en el histórico y cuánto cuesta hoy la detección reactiva, medida en horas de verificación y en reclamos procedentes?
2. *Construcción:* ¿qué segmentación, criterio de detección y reglas de verificación debe tener el método para mantener el volumen de alertas dentro de la capacidad real del equipo?
3. *Evaluación:* ¿con qué cobertura recupera el método los reclamos procedentes, con qué tasa de falsos positivos y con qué aplicabilidad para los verificadores?
4. *Conocimiento:* ¿qué principios de diseño resultan transferibles a distribuidoras que aplican un catálogo regulatorio de irregularidades?

## 4. Objeto de estudio

**El método de detección y verificación de lecturas anómalas no declaradas**, con tipología declarada de **método**: pasos, roles, entradas, salidas, precondiciones, criterios de entrada y salida y productos de trabajo, más las aplicaciones sobre la base que lo instancian.

*Resignificación de Design Science, explícita:* el objeto de estudio no es el proceso de lecturación ni el fenómeno del fraude; éstos son el contexto. El objeto es el artefacto que se construye. En la traducción institucional esta relación se invertirá y así se anotará.

**Justificación de la tipología:** el problema no es falta de software —el sistema existe y la tesista lo administra—, sino falta de un procedimiento que decida qué leer, con qué criterio y quién resuelve. Un método es el artefacto que llena ese vacío; la instanciación de apoyo (consultas y rutinas sobre `tfv_histo_lec` y `tfv_reclamo`) es el vehículo de aplicación, no la contribución.

## 5. Objetivos

**Objetivo general.** Diseñar, construir y evaluar un método de detección y verificación de lecturas anómalas no declaradas en el ciclo de lecturación y facturación de energía eléctrica, y articular los principios de diseño que de su aplicación se desprenden.

**Objetivos específicos:**

1. Diagnosticar la magnitud y el costo de la detección reactiva actual mediante indicadores trazables a `tfv_histo_lec` y `tfv_reclamo`.
2. Determinar los requisitos del método y comparar alternativas de técnica de detección con trade-offs explícitos, eligiendo una y descartando las demás con justificación.
3. Construir el método y verificar su consistencia interna, documentando las decisiones de diseño y los rediseños.
4. Evaluarlo en un ciclo formativo con rediseño documentado y en un ciclo sumativo en el contexto real de la cadena de verificación.
5. Articular los principios de diseño validados, con sus condiciones de contorno y las amenazas a la validez de la evidencia.

Los objetivos 1 a 3 son de **construcción**; los objetivos 4 y 5 son de **contribución al conocimiento** y son los que impiden que el trabajo sea un plan de desarrollo.

## 6. Tipología del artefacto

**Método** (tipología principal), acompañado de una **instanciación de apoyo** que hace de *exemplar*: aplicaciones sobre la base de datos del sistema real que producen la lista de alertas y registran la verificación. Si en E7a se eligiera una técnica estadística de modelado, el artefacto pasaría a ser una **composición** (método + modelo) y así se declarará.

## 7. Fundamentación en la base de conocimiento

*[Se construye en E4 y pasa la prueba de eliminación: si al retirarla el diseño del método no cambia, es decorativa.]* Ejes previstos:

- Detección de valores atípicos y sus métodos, con énfasis en explicabilidad para verificación humana.
- Modelado de consumo eléctrico por perfil de usuario y estacionalidad.
- Auditoría, control interno y atención de reclamos bajo normativa del ente regulador.
- Design Science: proceso DSRM (Peffers et al., 2007), ciclos de Wieringa (2014), estrategias FEDS (Venable et al., 2016), principios de Hevner et al. (2004) y niveles de contribución de Gregor y Hevner (2013).

Todas las referencias del dominio quedan **[por verificar]** hasta E4 y E5; las de Design Science están tomadas de la biblioteca del repositorio.

## 8. Diseño metodológico

Modelo de proceso: **DSRM de Peffers et al. (2007)** —identificación del problema, objetivos de diseño, diseño, construcción, evaluación, comunicación— operado en **ciclos de Wieringa (2014)**: un ciclo de investigación de problemas para el diagnóstico y un ciclo de diseño para el artefacto.

Número de ciclos de evaluación planificados: **uno formativo de campo con rediseño documentado** (equipo de validación en sitio, durante la construcción) **y uno sumativo de campo** (cadena de verificación completa, después del criterio de suficiencia).

## 9. Estrategia de evaluación

Marco **FEDS** (Venable et al., 2016), en secuencia **formativa → sumativa**, ambas **de campo**:

| Ciclo | Propósito | Método concreto | Muestra |
|:--|:--|:--|:--|
| Formativa de campo | Descubrir problemas del diseño y rediseñar | Aplicación del método a un periodo histórico acotado por el equipo de validación, con registro de hallazgos y de los rediseños que provoquen | Personal de validación en sitio, que no participó en la delimitación |
| Sumativa de campo | Demostrar utilidad y sustentar la contribución | Prueba retrospectiva sobre los meses previos: ¿el método habría alertado antes los reclamos que resultaron procedentes? Complementada con medida de carga de verificación y aplicabilidad | Reclamos de `tfv_reclamo` de un periodo completo; verificadores y personal de respuesta al ODECO |

**Métodos propios de la tipología:** al método se le mide **aplicabilidad** (¿pueden seguirlo los verificadores sin la autora?) y **efectividad** (cobertura de reclamos procedentes y carga de alertas frente a la línea base). No se usan pruebas de rendimiento de software, que corresponden a una instanciación.

**Distinción obligatoria:** la **utilidad** es que el artefacto resuelve el problema en ENDE; la **contribución** es que los principios valen para la clase de contextos. Son evaluaciones distintas con evidencia distinta.

**Separación de muestras:** el problema de diseño se informó con el equipo técnico; la evaluación sumativa incorpora al menos un evaluador que no participó de la delimitación, para controlar el sesgo de confirmación de la constructora.

**Criterios de éxito:** los cuatro definidos en `02_delimitacion.md` (cobertura retrospectiva, falsos positivos, carga de verificación, aplicabilidad), con sus **valores numéricos fijados antes de construir**, en E6 y E7b.

## 10. Tipo de contribución reclamada

**Principios de diseño validados de nivel de clase**, con transferibilidad **analítica** —no estadística—: principios con objetivo, contexto y mecanismo que un operador distinto podría aplicar para construir su propio método ante un problema de la misma clase. No se reclama teoría de diseño ni generalización a todo el sector eléctrico.

## 11. Selección y muestra

Contexto de evaluación: la regional de ENDE con 20 000 cuentas, la de mayor volumen del sistema, sujeta al mismo catálogo nacional de códigos. Es representativa de la clase de contextos —distribuidoras con sistema propio, histórico tabular y catálogo del regulador— por cuanto comparte las tres condiciones que definen esa clase. Acceso garantizado: la tesista es administradora del sistema.

Participantes: personal de validación en sitio, personal de respuesta al ODECO y encargado de facturación; al menos un evaluador fuera de ese grupo. *[Pendiente: confirmar número exacto de participantes y su disponibilidad.]*

## 12. Cronograma

Fechas **exigidas** por el programa, confirmadas por la tesista el 26 de septiembre de 2026.

| Periodo | Actividades | Etapas |
|:--|:--|:--|
| 26–28 sep | Delimitación y perfil | E2, E3 |
| 29 sep – 12 oct | Marco teórico y estado del arte | E4, E5 |
| 13–26 oct | Diagnóstico con indicadores y línea base; alternativas, requisitos y diseño | E6, E7a, E7b, E7c |
| 27–31 oct | Plan de construcción, producto mínimo viable, criterio de suficiencia. **Entrega de propuesta completa** | E7d |
| 1–8 nov | Construcción y verificación interna; ficha del artefacto | E7e, E7f |
| 9–15 nov | **Evaluación formativa de campo** | E8 (formativa) |
| **16–18 nov** | **Rediseño documentado** — tiempo de rediseño explícito, no negociable | E8 |
| 19–24 nov | **Evaluación sumativa de campo** | E8 (sumativa) |
| 25–27 nov | Matriz de trazabilidad, principios de diseño, conclusiones | E9, E10 |
| 28–30 nov | Redacción final y traducción institucional | E10, traducción |

**Riesgo declarado:** tres días de rediseño es el mínimo absoluto. Si la evaluación formativa se retrasa, el rediseño se recorta y la tesis pierde el ciclo que sostiene los principios de diseño. Cualquier deslizamiento superior a tres días obliga a recortar alcance en E7d, no a eliminar el rediseño.

## 13. Plan de análisis

1. Cruce de alertas del método con los reclamos procedentes de `tfv_reclamo`: recuperación, falsos positivos y tiempo de verificación, por familia de código y por mes.
2. Análisis cualitativo de las decisiones de los verificadores: por qué se aceptó o rechazó cada alerta; registro de los casos en que el método no alertó y el reclamo sí prosperó.
3. Análisis de los rediseños del ciclo formativo: qué cambió, por qué hallazgo y con qué efecto en los criterios.
4. De los resultados a los principios: cada principio se redacta en la forma **objetivo → contexto → mecanismo → principio** y se somete al contraste de la evidencia que lo sostiene.

**Criterio de suficiencia del análisis:** la evidencia es suficiente cuando todo reclamo procedente no alertado ha sido clasificado por causa, cuando ningún criterio de éxito queda sin valor y cuando cada principio afirmado tiene al menos dos evidencias independientes (prueba retrospectiva y juicio de verificador). Si una afirmación no alcanza dos evidencias, se reformula con alcance menor o se declara como trabajo futuro.

## 14. Anexo de artefacto previsto

Método de detección y verificación, descrito con: entradas (`tfv_histo_lec`, `tfv_reclamo`, catálogo de códigos); segmentación por perfil de consumo y familia de código; criterio de detección elegido en E7a con su justificación; reglas de prioridad y criterios de verificación escritos; roles y productos de trabajo sobre la cadena vigente (recepción, validación en sitio, respuesta al ODECO, conciliación); formato de registro de resolución; y las aplicaciones sobre la base que lo instancian.

---

## Gate de E3 — pendiente

Falta **una oración, con sus palabras**, que enuncie la contribución original de conocimiento. No la escribo yo: si no puede decirla con su propia voz, todavía no le pertenece.
