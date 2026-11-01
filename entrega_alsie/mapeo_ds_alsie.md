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
| 6.3 Campo de acción | `02_delimitacion.md` §4, `03_perfil_ds.md` §4 | Fórmula 6.3 | **Listo** |
| 6.4–6.5 Objetivo general y objetivos específicos | `03_perfil_ds.md` §5, `propuesta_borrador_v1.md` §3 | Fórmula 6.4 | **Listo** |
| 6.6 Hipótesis | `10_contribucion_conclusiones.md` `[vacío]` + `07a`/`07b`/`07c` | Fórmula 6.5 (provisional desde el diseño) | **Validada por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por principios de `E10`** |
| 6.7 Aporte teórico | `10_contribucion_conclusiones.md` `[vacío]` + `03_perfil_ds.md` §10 | Fórmula 6.6 (provisional) | **Validado por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por principios de `E10`** |
| 6.8 Significación práctica | `09_enlace_solucion.md` `[vacío]` + `08_evaluacion.md` `[vacío]` + `02_delimitacion.md` | Fórmula 6.7 (provisional) | **Validada por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por los resultados de `E8`** |
| 6.9 Métodos y técnicas | `03_perfil_ds.md` §8–§9, `07c_diseno_artefacto.md`, `06_diagnostico.md` | Fórmula 6.8 (teóricos/empíricos/técnicas) | **Listo** |
| 6.10 Población y muestra | `06_diagnostico.md`, `03_perfil_ds.md` §11 | Fórmula 6.9 | **Listo** |
| 7. Capítulo I. Diagnóstico | `06_diagnostico.md`, `08_evaluacion.md` `[vacío]` | Volcado completo — ver §3 | **Listo (evaluación pendiente)** |
| 8. Capítulo II. Marco teórico | `04_marco_teorico.md` + `05_estado_del_arte.md` | Volcado completo — ver §3 | **Listo** |
| 9. Capítulo III. Modelo teórico | `10_contribucion_conclusiones.md` `[vacío]` + `07c_diseno_artefacto.md` + `07b_requisitos.md` | Fórmula 6.10 + volcado — ver §3 | **Validado por la tesista 30 oct (`DEC-127`); `[PROVISIONAL]` por principios de `E10`** |
| 10. Capítulo IV. Propuesta | `07a_alternativas.md`, `07c_diseno_artefacto.md`, `07d_construccion.md` (abierto el 30 oct, `DEC-123`), `07e_construccion_verificacion.md` `[vacío]`, `08_evaluacion.md` `[vacío]`, `09_enlace_solucion.md` `[vacío]` | Fórmula 6.11 + volcado — ver §3 | **Parcial — E7d/E7e/E8/E9 pendientes** |
| 11. Conclusiones | `06_diagnostico.md`, `04_marco_teorico.md`, `05_estado_del_arte.md`, `07c_diseno_artefacto.md` (+ `08` `[vacío]`) | Una por capítulo, en términos de resultados | **Tres de cuatro redactadas (`DEC-127`); la del Cap. IV requiere `E8`** |
| 12. Recomendaciones | `06_diagnostico.md`, `04_marco_teorico.md`, `05_estado_del_arte.md`, `07c_diseno_artefacto.md` (+ `08`, `10` `[vacío]`) | Sugerencias viables | **Redactadas el 30 oct (`DEC-127`); faltan las de `E8` y `E10`** |
| 13. Referencias bibliográficas | `propuesta_borrador_v1.md` §12 (22 entradas verificadas) | APA 7; correspondencia bidireccional | **Listo** |
| 14. Anexos | `06_diagnostico.md`, `07f_ficha_artefacto.md` `[vacío]` + este mapa | Instrumentos, ficha y mapa DS → ALSIE | **Parcial — ficha pendiente (E7f)** |

> **Nota sobre la numeración de la columna «Fórmula 6.x», escrita el 1 de noviembre de 2026.** Esa columna sigue el esquema definido en la definición del agente `traductor-alsie` (`.opencode/agent/traductor-alsie.md` L95–L107), que **fusiona *objetivo general* y *objetivos específicos* en una sola fórmula —la 6.4— y coloca el *campo de acción* antes de los objetivos.** Por eso, **a partir de la hipótesis el número de apartado y el número de fórmula difieren en uno:** el apartado **6.6** corresponde a la fórmula **6.5**. **Los números de la primera columna coinciden con el índice del IFI (§5), que es la fuente autoritativa de la numeración.** La columna de fórmulas se deja como está, porque renumerarla obliga a decidir si el esquema del agente se corrige también, y esa decisión no se toma aquí.

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
| Regularidades del estado actual | `06_diagnostico.md` §"Tres lecturas que este archivo obliga a hacer"; `02_delimitacion.md` §1 Problema |

### Capítulo II. Marco teórico
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Antecedentes (mundo, región, país) | `05_estado_del_arte.md` §4.3, §9; `04_marco_teorico.md` §2.6 |
| Definiciones y concepciones de cada autor | `04_marco_teorico.md` §3.1, §7; `05_estado_del_arte.md` §4.1 |
| Categorías conceptuales del objeto y del campo | `04_marco_teorico.md` §3, §4, §5 |
| Análisis histórico-lógico del problema | `05_estado_del_arte.md` §4.2, §5, §6 |
| Soluciones dadas por otras investigaciones | `05_estado_del_arte.md` §6, §7 |
| Valoraciones críticas y toma de posición | `04_marco_teorico.md` §2.6, §3.3, §3.4, §6; `05_estado_del_arte.md` §8 |
| Estado del arte | `05_estado_del_arte.md` §3–§8 |

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
| Plan de construcción y versiones | `07d_construccion.md` — **abierto el 30 oct (`DEC-123`)**, con plan, MPV y criterio de suficiencia; gate 0 de 6 |
| Registro de construcción y verificación interna | `07e_construccion_verificacion.md` `[vacío]` — **requiere E7e** |
| Evaluación (ciclos formativo y sumativo) con datos y resultados | `08_evaluacion.md` `[vacío]` — **requiere E8** |
| Matriz de trazabilidad propuesta ↔ solución | `09_enlace_solucion.md` `[vacío]` — **requiere E9**; borrador en `matriz_coherencia.md` §"Trazabilidad propuesta ↔ solución" |

### Conclusiones / Recomendaciones
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Conclusiones por capítulo | Redactadas en el IFI §11 desde `06_diagnostico.md`, `04_marco_teorico.md`, `05_estado_del_arte.md` y `07c_diseno_artefacto.md` — **tres de cuatro (`DEC-127`); la del Cap. IV requiere `E8`** |
| Recomendaciones (trabajo futuro) | Redactadas en el IFI §12 el 30 oct desde las tres conclusiones (`DEC-127`) — **las que dependen de `E8` y `E10` se añaden al cerrarlas** |

### Anexos
| Anexo | Fuente |
|:--|:--|
| A. Instrumentos aplicados | `06_diagnostico.md` §"Vacíos que restan" (consultas a ENDE); `consultas_base_datos.md` |
| B. Ficha del artefacto | `07f_ficha_artefacto.md` `[vacío]` — **requiere E7f**; esqueleto en `plantillas/ficha_metodo.md` |
| C. Mapa DS → ALSIE | Este archivo |

---

## 4. Vacíos registrados (lo que no tiene fuente)

| # | Apartado del IFI | Qué falta | Etapa que lo produce | Pregunta al tesista |
|:--|:--|:--|:--|:--|
| V1 | 6.6 Hipótesis | Principios de diseño validados | E10 | **RESUELTA 30 oct (`DEC-127`): la hipótesis se confirmó sin ajustes; solo queda `E10`** |
| V2 | 6.7 Aporte teórico | Principios de diseño validados | E10 | **RESUELTA 30 oct (`DEC-127`): el aporte se confirmó sin ajustes; solo queda `E10`** |
| V3 | 6.8 Significación práctica | Enlace propuesta ↔ solución y evaluación | E9/E8 | **RESUELTA 30 oct (`DEC-127`): la significación se confirmó sin ajustes; la magnitud queda para `E8`** |
| V4 | 9. Capítulo III | Principios de diseño y propiedades del modelo | E10 | **RESUELTA 30 oct (`DEC-127`): se confirmaron los 5 componentes, las 5 relaciones y las 9 propiedades; solo queda `E10`** |
| V5 | 10. Capítulo IV | Plan de construcción, construcción, evaluación, matriz de trazabilidad | E7d/E7e/E8/E9 | — (depende de etapas) |
| V6 | 11. Conclusiones | Resultados por capítulo | E8/E10 | — (depende de etapas) |
| V7 | 12. Recomendaciones | Trabajo futuro | E10 | — (depende de etapas) |
| V8 | 14. Anexo B | Ficha reproducible del artefacto | E7f | — (depende de etapas) |
| V9 | 10.2 Capítulo IV | Estructura oficial con autor de la propuesta | Tutor | **CON EL TUTOR desde el paquete del 30 oct (`DEC-117`); se propuso el DSRM de Peffers et al. (2007)** |
| V10 | 1. Carátula | Logo institucional | Tesista | ¿Se inserta el logo en el maquetado final? |
| V11 | 2. Agradecimientos | Inclusión del tutor | Tesista | **RESUELTA 30 oct (`DEC-127`): el tutor entra, con texto dictado por la tesista** |
