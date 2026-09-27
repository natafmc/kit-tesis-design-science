# Matriz de coherencia y trazabilidad

> Archivo de trabajo mantenido desde E3. Si un eslabón contradice a otro, se detiene el avance y se resuelve antes de continuar.

## Cadena de coherencia

| Eslabón | Contenido | Origen |
|:--|:--|:--|
| Problema de diseño | La detección de lecturas anómalas depende del criterio individual del lecturador en el momento de la lectura y no existe barrido del histórico; los reclamos procedentes de la ODECO muestran que anomalías no detectadas llegan después de facturar, con verificación de 3 a 4 horas por caso (2 días con visita) | `02_delimitacion.md` |
| Problema de investigación (institucional: "problema científico") | Falta evidencia sobre cómo un método que barre el histórico —incluidas las lecturas no marcadas— se integra a un ciclo de lecturación-facturación sujeto al catálogo de un ente regulador, y bajo qué criterios los verificadores lo consideran utilizable. *[La afirmación de ausencia es provisional hasta E5]* | `02_delimitacion.md`, `03_perfil_ds.md` |
| Objeto de estudio (artefacto + tipología) | El método de detección y verificación de lecturas anómalas no declaradas. Tipología: **método**, con instanciación de apoyo como *exemplar* | `02_delimitacion.md`, `03_perfil_ds.md` |
| Campo de acción (clase de contextos) | Distribuidoras reguladas por la AETN con sistema transaccional propio e histórico tabular de lecturas | `02_delimitacion.md`, `03_perfil_ds.md` |
| Objetivo general | Diseñar, construir y evaluar el método, y articular los principios de diseño que de su aplicación se desprenden | `03_perfil_ds.md` |
| Pregunta de investigación | ¿Qué método de detección y verificación permite identificar lecturas anómalas no declaradas en el ciclo de lecturación y facturación de una distribuidora con sistema propio y catálogo regulatorio, y bajo qué condiciones lo consideran utilizable sus verificadores? + 4 subpreguntas | `03_perfil_ds.md` |
| Alternativas de solución consideradas | *[Pendiente: E7a — al menos dos alternativas reales de técnica de detección]* | — |
| Artefacto propuesto (tipología) | Método (pasos, roles, entradas, salidas, precondiciones, criterios, productos) | `03_perfil_ds.md` |
| Requisitos del artefacto | *[Pendiente: E7b — derivados del problema y del diagnóstico, con métrica]* | — |
| Decisiones de diseño principales | Segmentación previa; exclusión o tratamiento aparte de lecturas estimadas; barrido también sobre lecturas sin código; integración a la cadena vigente de verificación | `02_delimitacion.md` |
| Criterio de suficiencia del artefacto | *[Pendiente: E7d — se fija antes de construir]* | — |
| Método de evaluación | FEDS: **formativa de campo** con rediseño documentado → **sumativa de campo** por prueba retrospectiva sobre reclamos de `tfv_reclamo`, carga de verificación y aplicabilidad. Métodos propios de la tipología: aplicabilidad y efectividad | `03_perfil_ds.md` |
| Criterios de éxito e indicadores | (1) cobertura retrospectiva de reclamos procedentes; (2) falsos positivos; (3) carga de verificación dentro de la capacidad del equipo; (4) aplicabilidad sin asistencia de la autora. **Valores numéricos: *[pendiente de fijarse en E6 y E7b, antes de construir]*** | `02_delimitacion.md` |
| Contribución reclamada (nivel de maestría) | Principios de diseño validados de nivel de clase, con transferibilidad analítica; condiciones de contorno: distribuidoras reguladas por la AETN con sistema propio e histórico tabular | `03_perfil_ds.md` |

### Oración de contribución (gate de E3, cerrado el 26 sep 2026)

> Este estudio construye un método de detección y verificación previa a la facturación de lecturas sin código de irregularidad que presentan consumos atípicos, y de su aplicación y evaluación en ENDE se desprenden principios de diseño que permiten a una distribuidora regulada por la AETN incorporar detección sistemática a su ciclo de lecturación sin exceder la capacidad de su equipo de verificación.

## Trazabilidad propuesta ↔ solución

*[Se llena en E9 con la evidencia de E8. Se abre aquí para que la cadena no se construya al final.]*

| Problema de diseño | Requisito | Alternativa descartada | Decisión de diseño | Componente | Indicador | Verificación interna | Evidencia de evaluación | Cumplimiento | Limitación |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
| Sin barrido del histórico | Detección sobre lecturas con y sin código | | | | | | | | |
| Verificación cuesta 3–4 h por caso | Volumen de alertas dentro de la capacidad del equipo | | | | | | | | |
| Reclamos procedentes llegan después de facturar | Verificación previa a la facturación | | | | | | | | |
| Detección dependiente del criterio individual | Criterios de verificación escritos | | | | | | | | |

## Riesgos de construcción

| Riesgo | Tipo | Probabilidad | Impacto | Mitigación |
|:--|:--|:--|:--|:--|
| Calendario exigido: 9 semanas con 3 días de rediseño | Tiempo | Alta | Crítico | Recortar alcance en E7d; nunca el rediseño |
| La tesista no ha entrenado modelos predictivos | Competencia | Media | Alto | Técnica de detección elegida en E7a; priorizar explicabilidad sobre sofisticación |
| Las lecturas estimadas (~25 %) distorsionan el modelado de consumo | Técnico | Alta | Alto | Excluir o tratar aparte ese bloque desde el diseño |
| Sin cifras de facturas observadas ni energía no facturada | Datos | Alta | Medio | Línea base apoyada en horas de verificación y reclamos procedentes |
| Evaluadores disponibles solo en horario laboral de la institución | Acceso | Media | Alto | Agenda de evaluación fijada antes de E8 |

## Eslabones huérfanos (sin evidencia o sin correspondencia)

- **Evidencia de que el problema existe:** aún no se cuenta con el número de reclamos procedentes cuya lectura no tenía código. Sin él, el problema de diseño se sostiene solo en la descripción del proceso.
- **Valores numéricos de los criterios de éxito:** definidos como criterios, aún sin valor. Deben fijarse en E6 y E7b, antes de construir.
- **Base de conocimiento:** los ejes de E4 están listados pero no verificados; el estado del arte de E5 no existe todavía, por lo que la afirmación de brecha del problema de investigación sigue sin sustento bibliográfico.
