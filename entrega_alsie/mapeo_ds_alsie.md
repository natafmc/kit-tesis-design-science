# Mapa de equivalencias Design Science → ALSIE

> **Archivo de trabajo del agente `traductor-alsie`.** Se construye **antes** de redactar el IFI y se vuelca, sin rehacerlo, en el **Anexo C** de `entrega_alsie/IFI_ALSIE.md`.
> **Fuente de la forma:** `instituciones/alsie/guia_ifi_contenido.md` e `instituciones/alsie/indicadores_revision_ifi.md` (nivel de maestría).
> **Fuente del contenido:** carpeta `tesis_ds/`.
> **Fecha de construcción:** 29 de octubre de 2026.
> **Regla:** todo apartado del IFI se rastrea hasta un archivo de `tesis_ds/` o hasta una respuesta explícita del tesista. Lo que no tiene fuente se marca `[vacío]`.

---

## 1. Equivalencias terminológicas

| Design Science (`tesis_ds/`) | ALSIE (IFI) | Naturaleza del cambio |
|:--|:--|:--|
| Problema de investigación (brecha de conocimiento) | Problema científico — componente de conocimiento | Renombrar y anclar en la realidad |
| Problema de diseño (contexto, problema, costo) | Problema científico — situación real, población afectada y lugar | Se funde con el anterior; se elimina el lenguaje de "diseño" |
| Solución conceptual | Avance de la solución dentro de la propuesta | Se conserva, sin anticiparla en el problema |
| Artefacto (constructo, modelo, método, instanciación, marco) | Propuesta (Capítulo IV) y, en parte, Modelo teórico (Capítulo III) | Se separa lo conceptual (modelo) de lo concreto (propuesta) |
| Objeto de estudio de Design Science (el artefacto) | Objeto de estudio (área del conocimiento donde se manifiesta la situación) | **Resignificación inversa:** de artefacto a área del conocimiento |
| Clase de contextos del problema | Campo de acción (parte esencial del objeto) | Se convierte en el subconjunto esencial del objeto |
| Principios de diseño (objetivo, contexto, mecanismo, principio) | Aporte teórico y Modelo teórico | Los principios se vuelven componentes y relaciones del modelo |
| Contribución al conocimiento | Aporte teórico | Renombrar y expresar en términos de conceptos, relaciones y leyes |
| Utilidad y enlace propuesta ↔ solución | Significación práctica | Renombrar y explicitar la relación teórico-práctica |
| Ciclos de evaluación (formativa y sumativa) | Validación dentro de la Propuesta (Capítulo IV) y base de las Conclusiones | ALSIE no tiene capítulo de evaluación propio |
| Condiciones de contorno y amenazas a la validez | Limitaciones y Recomendaciones | Se redistribuyen |
| Proceso DSRM y estrategias FEDS | Métodos y técnicas (Introducción) | Se reclasifican en teóricos, empíricos y técnicas |

**Regla de oro aplicada:** ningún término de Design Science queda en el IFI sin traducir ("artefacto" → "propuesta"/"método"; "principio de diseño" → "componente/relación del modelo" y "aporte teórico"; "problema de diseño" → "problema científico"; "evaluación formativa/sumativa" → "validación"; "contexto de evaluación" → "contexto de aplicación").

---

## 2. Mapa apartado por apartado

| Apartado del IFI (ALSIE) | Fuente en `tesis_ds/` | Transformación | Estado |
|:--|:--|:--|:--|
| 1. Carátula | `ifi_informe_final.md` §1 (datos dictados, `DEC-77`) | Completar con el tesista; no inventar | **Listo** |
| 2. Agradecimientos | `ifi_informe_final.md` §2 (`DEC-93`, `DEC-94`, `DEC-127`) | Texto dictado por la tesista; el tutor se añadió el 30 oct con texto dictado | **Listo** |
| 3. Dedicatoria | `ifi_informe_final.md` §3 (`DEC-93`) | Texto dictado por la tesista | **Listo** |
| 4. Resumen | `ifi_informe_final.md` §4 (`DEC-77`) | 241 palabras, un párrafo, pasado, voz pasiva | **Listo** |
| 5. Índice | Estructura del propio IFI | Generar la lista de apartados, capítulos, epígrafes y subepígrafes | **Generado** |
| 6. Introducción | `01_areas_y_temas.md`, `02_delimitacion.md`, `03_perfil_ds.md`, `06_diagnostico.md` | Perfil de investigación completo con las fórmulas 6.1–6.9 | **Listo — hipótesis, aporte y significación validados el 30 oct (`DEC-127`); `[PROVISIONAL]` por `E8` y `E10`** |
| 6.1 Problema científico | `02_delimitacion.md` §1–§2, `06_diagnostico.md` | Fórmula 6.1 | **Listo** |
| 6.2 Objeto de estudio | `02_delimitacion.md` §3, `03_perfil_ds.md` §4 | Fórmula 6.2 (resignificación inversa) | **Listo** |
| 6.5 Campo de acción | `02_delimitacion.md` §4, `03_perfil_ds.md` §4 | Fórmula 6.3 | **Listo** |
| 6.3–6.4 Objetivo general y objetivos específicos | `03_perfil_ds.md` §5, `propuesta_borrador_v1.md` §3 | Fórmula 6.4 | **Listo** |
| 6.6 Hipótesis | `10_contribucion_conclusiones.md` (diseño; principios pendientes) + `07a`/`07b`/`07c` | Fórmula 6.5 (provisional desde el diseño) | **Validada por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por principios de `E10`** |
| 6.7 Aporte teórico | `10_contribucion_conclusiones.md` (diseño; principios pendientes) + `03_perfil_ds.md` §10 | Fórmula 6.6 (provisional) | **Validado por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por principios de `E10`** |
| 6.8 Significación práctica | `09_enlace_solucion.md` (diseño) + `08_evaluacion.md` (diseño) + `02_delimitacion.md` | Fórmula 6.7 (provisional) | **Validada por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por los resultados de `E8`** |
| 6.9 Métodos y técnicas | `03_perfil_ds.md` §8–§9, `07c_diseno_artefacto.md`, `06_diagnostico.md` | Fórmula 6.8 (teóricos/empíricos/técnicas) | **Listo** |
| 6.10 Población y muestra | `06_diagnostico.md`, `03_perfil_ds.md` §11 | Fórmula 6.9 | **Listo** |
| 7. Capítulo I. Diagnóstico | `06_diagnostico.md`, `08_evaluacion.md` (diseño; resultados pendientes) | Volcado completo — ver §3 | **Listo (evaluación pendiente); salvedades de las cifras volcadas 2 nov (`DEC-130`)** |
| 8. Capítulo II. Marco teórico | `04_marco_teorico.md` + `05_estado_del_arte.md` | Volcado completo — ver §3 | **Listo; etapa de revisión bibliográfica —método, cuenta de registros, vacíos y verificación— volcada 2 nov (`DEC-130`), detalle en Anexo D** |
| 9. Capítulo III. Modelo teórico | `10_contribucion_conclusiones.md` (diseño; principios pendientes) + `07c_diseno_artefacto.md` + `07b_requisitos.md` | Fórmula 6.10 + volcado — ver §3 | **Validado por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por principios de `E10`** |
| 10. Capítulo IV. Propuesta | `07a_alternativas.md`, `07b_requisitos.md`, `07c_diseno_artefacto.md`, `07d_construccion.md`, `08_evaluacion.md`, `09_enlace_solucion.md` (+ `07e_construccion_verificacion.md` `[vacío]`) | Fórmula 6.11 + volcado — ver §3 | **Volcado ampliado 2 nov (`DEC-129`): plan de construcción, diseño de la validación y matriz de trazabilidad; parcial por `E7e`/`E8`/`E9`/`E7f`/`E10`** |
| 11. Conclusiones | `06_diagnostico.md`, `04_marco_teorico.md`, `05_estado_del_arte.md`, `07c_diseno_artefacto.md` (+ `08_evaluacion.md` y `10_contribucion_conclusiones.md` §4 para limitaciones) | Una por capítulo, en términos de resultados | **Tres de cuatro redactadas (`DEC-127`); la del Cap. IV requiere `E8`; cinco limitaciones volcadas de `10` §4** |
| 12. Recomendaciones | `06_diagnostico.md`, `04_marco_teorico.md`, `05_estado_del_arte.md`, `07c_diseno_artefacto.md` (+ `08`, `10` `[vacío]`) | Sugerencias viables | **Redactadas el 30 oct (`DEC-127`); faltan las de `E8` y `E10`** |
| 13. Referencias bibliográficas | `propuesta_borrador_v1.md` §12 (22 entradas verificadas) | APA 7; correspondencia bidireccional | **Listo** |
| 14. Anexos | `06_diagnostico.md`, `07f_ficha_artefacto.md` `[vacío]`, `05_estado_del_arte.md` + este mapa | Instrumentos, ficha, mapa DS → ALSIE y protocolo de la revisión | **Parcial — ficha pendiente (E7f); Anexo D volcado 2 nov (`DEC-130`)** |

> **Nota sobre la numeración de la columna «Fórmula 6.x», escrita el 1 de noviembre de 2026.** Esa columna sigue el esquema definido en la definición del agente `traductor-alsie` (`.opencode/agent/traductor-alsie.md` L95–L107), que **fusiona *objetivo general* y *objetivos específicos* en una sola fórmula —la 6.4— y coloca el *campo de acción* antes de los objetivos.** Por eso, **a partir de la hipótesis el número de apartado y el número de fórmula difieren en uno:** el apartado **6.6** corresponde a la fórmula **6.5**. **Los números de la primera columna coinciden con el índice del IFI (§5), que es la fuente autoritativa de la numeración.** La columna de fórmulas se deja como está, porque renumerarla obliga a decidir si el esquema del agente se corrige también, y esa decisión no se toma aquí.

> **Nota de actualización, 3 nov 2026.** El apartado del campo de acción se movió de la posición 6.3 a la 6.5 del índice del IFI, y los objetivos general y específico pasaron a 6.3 y 6.4, para cumplir el orden que fija la guía oficial (`instituciones/alsie/guia_ifi_contenido.md` L208-L226): problema, objeto, objetivo general, objetivos específicos, campo de acción, hipótesis. La primera columna de esta tabla se renumeró ese día. La columna Fórmula 6.x no se toca: es un esquema propio de nueve fórmulas que fusiona los dos objetivos en una sola, la 6.4, y sitúa el campo de acción antes de ellos, tal como está definido en la definición del agente `traductor-alsie` (`.opencode/agent/traductor-alsie.md` L95-L107). Por eso las dos numeraciones ya no se alinean posición por posición a partir del 6.3, y desde la hipótesis el desfase sigue siendo de uno: el apartado 6.6 corresponde a la fórmula 6.5.

---

## 3. Volcado completo por capítulo (trazabilidad fina)

### Capítulo I. Diagnóstico
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Descripción contextual (quiénes, cómo trabajan, herramientas, restricciones) | `06_diagnostico.md` §"Población y alcance"; `02_delimitacion.md` §1 Contexto |
| Indicadores con definición operacional, fórmula/unidad, fuente, línea base y valor esperado | `06_diagnostico.md` §"Indicadores previstos y estado"; `02_delimitacion.md` §1 Criterios de éxito |
| Operacionalización (variable, definición operativa, dimensiones, indicadores) | `04_marco_teorico.md` §7; `06_diagnostico.md` |
| Instrumentos aplicados (ítems ↔ indicadores) | `06_diagnostico.md` §"Vacíos que restan" (consultas a ENDE); `consultas_base_datos.md` |
| Resultados de todos los instrumentos, con tabla/figura APA | `06_diagnostico.md` §"Línea base multianual", Indicadores 1–3 |
| Especificidad de la señal del código (razón de improcedentes 1,15× en 21 meses) | `06_diagnostico.md` §"Las tres cifras que deben publicarse juntas" |
| Salvedades de las cifras (4) | `06_diagnostico.md` §"Salvedades que viajan con estas cifras" — **volcadas el 2 nov (`DEC-130`)**: defecto de 2 unidades, agosto 2026 (`DEC-25`/`DEC-26`), denominadores por gestión, código ausente del archivo |
| Regularidades del estado actual | `06_diagnostico.md` §"Tres lecturas que este archivo obliga a hacer"; `02_delimitacion.md` §1 Problema |

> **No volcado del Capítulo I, por decisión de la fuente:** la cifra invalidada del 30 de septiembre de 2026 queda **suprimida de todos los documentos** por decisión de la tesista (`06_diagnostico.md` §"Dato invalidado"); no se reproduce aquí. Los estados de etapa de §"Vacíos que restan para cerrar E6" son control de proceso, no contenido del informe.

### Capítulo II. Marco teórico
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Revisión bibliográfica: método y cuenta de registros (§8.1) | `05_estado_del_arte.md` §2.1–§2.4 — **volcado el 2 nov (`DEC-130`)**: protocolo v1, regla de recuento `DEC-21`, tabla resumen de las tres corridas (448 = 389 + 59 → 54), fuentes institucionales con ALER no localizada, registro de verificación 15/15 |
| Antecedentes (mundo, región, país) | `05_estado_del_arte.md` §4.3, §9; `04_marco_teorico.md` §2.6 |
| Definiciones y concepciones de cada autor | `04_marco_teorico.md` §3.1, §7; `05_estado_del_arte.md` §4.1 |
| Categorías conceptuales del objeto y del campo | `04_marco_teorico.md` §3, §4, §5 |
| Análisis histórico-lógico del problema | `05_estado_del_arte.md` §4.2, §5, §6 |
| Soluciones dadas por otras investigaciones | `05_estado_del_arte.md` §6, §7 |
| Comparación por dimensión con las exigencias del problema (9 dimensiones) | `05_estado_del_arte.md` §7 — **volcada el 2 nov (`DEC-130`)** |
| Valoraciones críticas y toma de posición | `04_marco_teorico.md` §2.6, §3.3, §3.4, §6; `05_estado_del_arte.md` §8 |
| Estado del arte y brecha | `05_estado_del_arte.md` §8 |
| Búsquedas sin resultado y su estado (5 filas) | `05_estado_del_arte.md` §9 — **volcada el 2 nov (`DEC-130`)** |
| Limitación declarada de la búsqueda | `05_estado_del_arte.md` §2.2, §8 (accesos no consultables, sin doble criba) |

> **No volcado del Capítulo II, por naturaleza:** `05_estado_del_arte.md` §10 (consecuencias para las etapas siguientes) fue consumido por las propias etapas `E7a`–`E8`; §12 (gate de E5) es control de proceso; §11 quedó íntegro en el Anexo D. Las tablas por índice y las listas de DOIs de §2.4 fueron al **Anexo D** del IFI, no al cuerpo, para no atomizar el capítulo.

### Capítulo III. Modelo teórico
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Fundamentación epistemológica | `04_marco_teorico.md` §2 (Design Science); `07c_diseno_artefacto.md` §4 |
| Componentes (dimensiones/variables esenciales) | `07c_diseno_artefacto.md` §3.1–§3.6; `07b_requisitos.md` §2 |
| Relaciones entre componentes | `07c_diseno_artefacto.md` §3.6 (orden depuración → segmentación → fórmula); `07b_requisitos.md` §5 |
| Representación gráfica (Mermaid → figura APA) | Construida por el traductor desde `07c` §3 |
| Propiedades del modelo (sistémico, multifactorial, etc.) | Construida por el traductor; `[vacío]` en `tesis_ds/` |
| Principios de diseño validados | `10_contribucion_conclusiones.md` `[vacío]` — **requiere E10** |

### Capítulo IV. Propuesta
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Alternativas consideradas y criterios de decisión con trade-offs | `07a_alternativas.md` §4–§6 |
| Requisitos con trazabilidad al problema | `07b_requisitos.md` §3 (R1–R10) |
| Diseño completo (componentes, estructura, decisiones, justificación) | `07c_diseno_artefacto.md` §3 |
| Plan de construcción y versiones | `07d_construccion.md` — **volcado al IFI el 2 nov (`DEC-129`)**: cuatro entregables, MPV, criterio de suficiencia y gate 0 de 6 con `DEC-125` |
| Registro de construcción y verificación interna | `07e_construccion_verificacion.md` `[vacío]` — **requiere E7e** |
| Evaluación (ciclos formativo y sumativo) con datos y resultados | `08_evaluacion.md` — **diseño volcado al IFI el 2 nov (`DEC-129`)** (verdad de referencia, métricas, cuatro criterios con valor y fuente, muestra, dos fases y gate); **los datos y resultados requieren E8** |
| Matriz de trazabilidad propuesta ↔ solución | `09_enlace_solucion.md` — **diseño volcado al IFI el 2 nov (`DEC-129`)** (matriz de 13 secciones con estado al 30 oct, matriz de requisitos y gate); **el cierre requiere E9**; borrador en `matriz_coherencia.md` §"Trazabilidad propuesta ↔ solución" |

### Conclusiones / Recomendaciones
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Conclusiones por capítulo | Redactadas en el IFI §11 desde `06_diagnostico.md`, `04_marco_teorico.md`, `05_estado_del_arte.md` y `07c_diseno_artefacto.md` — **tres de cuatro (`DEC-127`); la del Cap. IV requiere `E8`** |
| Limitaciones del estudio (§11) | `10_contribucion_conclusiones.md` §4 — **cinco limitaciones ya escritas, volcadas el 2 nov (`DEC-129`)**; las de `E8` se agregan al cerrarla. **Ubicación propuesta por el traductor — ALSIE no tiene apartado de limitaciones; pendiente de confirmación de la tesista** |
| Recomendaciones (trabajo futuro) | Redactadas en el IFI §12 el 30 oct desde las tres conclusiones (`DEC-127`) — **las que dependen de `E8` y `E10` se añaden al cerrarlas** |

### Anexos
| Anexo | Fuente |
|:--|:--|
| A. Instrumentos aplicados | `06_diagnostico.md` §"Vacíos que restan" (consultas a ENDE); `consultas_base_datos.md` |
| B. Ficha del artefacto | `07f_ficha_artefacto.md` `[vacío]` — **requiere E7f**; esqueleto en `plantillas/ficha_metodo.md` |
| C. Mapa DS → ALSIE | Este archivo |
| D. Protocolo y cuenta de registros de la revisión bibliográfica | `05_estado_del_arte.md` §2.1–§2.4 y §11 — **volcado el 2 nov (`DEC-130`)**: protocolo, lo que no se buscó, cadenas declaradas, tablas por índice, DOIs y dudas de verificación |

---

## 4. Vacíos registrados (lo que no tiene fuente)

| # | Apartado del IFI | Qué falta | Etapa que lo produce | Pregunta al tesista |
|:--|:--|:--|:--|:--|
| V1 | 6.6 Hipótesis | Principios de diseño validados | E10 | **RESUELTA 30 oct (`DEC-127`): la hipótesis se confirmó sin ajustes; solo queda `E10`** |
| V2 | 6.7 Aporte teórico | Principios de diseño validados | E10 | **RESUELTA 30 oct (`DEC-127`): el aporte se confirmó sin ajustes; solo queda `E10`** |
| V3 | 6.8 Significación práctica | Enlace propuesta ↔ solución y evaluación | E9/E8 | **RESUELTA 30 oct (`DEC-127`): la significación se confirmó sin ajustes; la magnitud queda para `E8`** |
| V4 | 9. Capítulo III | Principios de diseño y propiedades del modelo | E10 | **RESUELTA 30 oct (`DEC-127`): se confirmaron los 5 componentes, las 5 relaciones y las 9 propiedades; solo queda `E10`** |
| V5 | 10. Capítulo IV | Construcción (`07e`), resultados de evaluación, cierre de la matriz, ficha, principios | E7e/E8/E9/E7f/E10 | — (depende de etapas). **Plan de construcción, diseño de la validación y matriz volcados el 2 nov (`DEC-129`)** |
| V6 | 11. Conclusiones | Resultados por capítulo | E8/E10 | — (depende de etapas) |
| V7 | 12. Recomendaciones | Trabajo futuro | E10 | — (depende de etapas) |
| V8 | 14. Anexo B | Ficha reproducible del artefacto | E7f | — (depende de etapas) |
| V9 | 10.2 Capítulo IV | Estructura oficial con autor de la propuesta | Tutor | **CON EL TUTOR desde el paquete del 30 oct (`DEC-117`); se propuso el DSRM de Peffers et al. (2007)** |
| V10 | 1. Carátula | Logo institucional | Tesista | ¿Se inserta el logo en el maquetado final? |
| V11 | 2. Agradecimientos | Inclusión del tutor | Tesista | **RESUELTA 30 oct (`DEC-127`): el tutor entra, con texto dictado por la tesista** |
| V12 | 11. Conclusiones | Ubicación de las limitaciones del estudio | Tesista | **PROPUESTA 2 nov (`DEC-129`): ALSIE no tiene apartado de limitaciones; se volcaron al cierre de §11 desde `10` §4. ¿Se confirma esa ubicación?** |
