# Matriz de coherencia y trazabilidad

> Archivo de trabajo mantenido desde E3. Si un eslabón contradice a otro, se detiene el avance y se resuelve antes de continuar.

## Cadena de coherencia

| Eslabón | Contenido | Origen |
|:--|:--|:--|
| Problema de diseño | La marca de irregularidad la pone el lecturador terciarizado en el momento de la lectura y solo cubre el 1,04 % del facturable; el 98,96 % restante no se barre. Existe una detección manual previa a la facturación, pero **no está escrita, carece de umbral y depende de una sola persona**: 242,2 correcciones/mes con cambio registrado en el log pero **sin reporte accesible ni constancia del criterio**, y evidencia fotográfica siloada fuera del sistema. La capacitación de may–jun 2025 redujo las correcciones un 80 % pero dejó ese residual. Los reclamos procedentes de la ODECO muestran que anomalías no detectadas llegan después de facturar (3 a 4 horas de verificación; 2 días con visita) | `02_delimitacion.md` |
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
| La detección manual actual carece de umbral escrito | Umbral numérico fijado y justificado **antes** de construir | | | | | | | | |
| Verificación cuesta 3–4 h por caso | Volumen de alertas dentro de la capacidad del equipo | | | | | | | | |
| Reclamos procedentes llegan después de facturar | Verificación previa a la facturación | | | | | | | | |
| Detección dependiente del criterio individual | Criterios de verificación escritos | | | | | | | | |

## Riesgos de construcción

| Riesgo | Tipo | Probabilidad | Impacto | Mitigación |
|:--|:--|:--|:--|:--|
| Calendario exigido: 9 semanas con 3 días de rediseño | Tiempo | Alta | Crítico | Recortar alcance en E7d; nunca el rediseño |
| La tesista no ha entrenado modelos predictivos | Competencia | Media | Alto | Técnica de detección elegida en E7a; priorizar explicabilidad sobre sofisticación |
| Lecturas sin consumo facturable (tipo 0, ~13 % de las cuentas) y lecturas estimadas por impedimento (subconjunto del 1,04 % con código) | Técnico | Alta | Alto | Excluirlas o tratarlas aparte desde el diseño; sobre ellas no se calcula consumo esperado |
| Sin cifras de facturas observadas ni energía no facturada | Datos | Alta | Medio | Línea base apoyada en horas de verificación y reclamos procedentes |
| Evaluadores disponibles solo en horario laboral de la institución | Acceso | Media | Alto | Agenda de evaluación fijada antes de E8 |
| Las lecturas las toma personal terciarizado: rotación y dependencia contractual fuera del control de ENDE | Contexto | Media | Alto | El método opera sobre el dato registrado, no sobre la persona; declararlo como condición de contorno |
| La evidencia fotográfica que respalda una corrección está **siloada** en la computadora del encargado, sin enlace al registro | Trazabilidad | Alta | Medio | Es un hallazgo y un candidato a requisito de E7b, no una promesa del método: primero conviene saber si hay respaldo si ese equipo falla |
| El umbral de detección actual no está escrito y hoy es criterio de una persona | Diseño | Alta | Alto | Fijarlo en E7b **antes** de construir, y declararlo como decisión explícita frente a la práctica vigente |
| La estacionalidad ya se descuenta por juicio humano; un detector ingenuo marcaría inviernos y veranos | Técnico | Alta | Alto | Tratamiento explícito de estacionalidad en E7c. El histórico llega a 2022 (4 ciclos anuales), pero **hay que ampliar la extracción**: hoy solo cubre 21 meses |

## Eslabones huérfanos (sin evidencia o sin correspondencia)

- ~~**Evidencia de que el problema existe:** aún no se cuenta con el número de reclamos procedentes cuya lectura no tenía código.~~ → **cerrado el 1 oct 2026:** 46 de 62 (74,19 %), medido en `DATOS.xlsx`.
- **Valores numéricos de los criterios de éxito:** definidos como criterios, aún sin valor. Deben fijarse en E6 y E7b, antes de construir. Se avanza con el tiempo de verificación y las correcciones manuales como referencia de capacidad, pero el promedio de tiempo aún está en consulta.
- ~~**Base de conocimiento:** los ejes de E4 estaban listados sin verificar y E5 no existía.~~ → **cerrado el 2 oct 2026:** `04_marco_teorico.md` y `05_estado_del_arte.md`, con **22 entradas de referencia**: 21 comprobadas en Crossref por DOI y 1 (Hevner, 2007) en AISeL. **Cero entradas sin verificar.** **No se citan materiales internos** `referencias/ds_ch*.md` (decisión DEC-4). **Salvedad vigente:** la afirmación de brecha de `05_estado_del_arte.md` §8 sigue **provisional** hasta ejecutar la ampliación a IEEE Xplore (metadatos y resúmenes) y SciELO/LILACS **el 3–4 de octubre**, con conteo de registros (DEC-1/DEC-6/DEC-7 / E5-1a).
- ~~**Criterio actual de detección manual:** el umbral de "consumo elevado" que dispara la visita al domicilio no está escrito en ninguna parte.~~ → **cerrado el 2 oct 2026:** la regla se describió por primera vez —desviación frente a 6 meses, en las dos direcciones—, pero **confirmó que no tiene umbral numérico**. Ese umbral queda como decisión de diseño de E7b.
- **Tasa de falsos positivos de la detección manual actual:** cuántas visitas solicitadas terminan sin corregir la lectura. Sin ella no hay línea base del criterio 2.
- **Extracción ampliada a 2022:** el histórico existe desde 2022, pero toda la evidencia documentada sale de 21 meses. Hasta que no se amplíe, E7c (estacionalidad) y E8 (verdad de referencia) trabajan con un solo ciclo anual.
