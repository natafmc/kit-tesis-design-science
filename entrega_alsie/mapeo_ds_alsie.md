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
| 2. Agradecimientos | `ifi_informe_final.md` §2 (`DEC-93`, `DEC-94`) | Texto dictado por la tesista | **Listo** |
| 3. Dedicatoria | `ifi_informe_final.md` §3 (`DEC-93`) | Texto dictado por la tesista | **Listo** |
| 4. Resumen | `ifi_informe_final.md` §4 (`DEC-77`) | 241 palabras, un párrafo, pasado, voz pasiva | **Listo** |
| 5. Índice | Estructura del propio IFI | Generar la lista de apartados, capítulos, epígrafes y subepígrafes | **Generado** |
| 6. Introducción | `01_areas_y_temas.md`, `02_delimitacion.md`, `03_perfil_ds.md`, `06_diagnostico.md` | Perfil de investigación completo con las fórmulas 6.1–6.9 | **Listo (con hipótesis/aporte/significación provisionales)** |
| 6.1 Problema científico | `02_delimitacion.md` §1–§2, `06_diagnostico.md` | Fórmula 6.1 | **Listo** |
| 6.2 Objeto de estudio | `02_delimitacion.md` §3, `03_perfil_ds.md` §4 | Fórmula 6.2 (resignificación inversa) | **Listo** |
| 6.3 Campo de acción | `02_delimitacion.md` §4, `03_perfil_ds.md` §4 | Fórmula 6.3 | **Listo** |
| 6.4 Objetivo general y específicos | `03_perfil_ds.md` §5, `propuesta_borrador_v1.md` §3 | Fórmula 6.4 | **Listo** |
| 6.5 Hipótesis | `10_contribucion_conclusiones.md` `[vacío]` + `07a`/`07b`/`07c` | Fórmula 6.5 (provisional desde el diseño) | **Provisional — requiere validación** |
| 6.6 Aporte teórico | `10_contribucion_conclusiones.md` `[vacío]` + `03_perfil_ds.md` §10 | Fórmula 6.6 (provisional) | **Provisional — requiere validación** |
| 6.7 Significación práctica | `09_enlace_solucion.md` `[vacío]` + `08_evaluacion.md` `[vacío]` + `02_delimitacion.md` | Fórmula 6.7 (provisional) | **Provisional — requiere validación** |
| 6.8 Métodos y técnicas | `03_perfil_ds.md` §8–§9, `07c_diseno_artefacto.md`, `06_diagnostico.md` | Fórmula 6.8 (teóricos/empíricos/técnicas) | **Listo** |
| 6.9 Población y muestra | `06_diagnostico.md`, `03_perfil_ds.md` §11 | Fórmula 6.9 | **Listo** |
| 7. Capítulo I. Diagnóstico | `06_diagnostico.md`, `08_evaluacion.md` `[vacío]` | Volcado completo — ver §3 | **Listo (evaluación pendiente)** |
| 8. Capítulo II. Marco teórico | `04_marco_teorico.md` + `05_estado_del_arte.md` | Volcado completo — ver §3 | **Listo** |
| 9. Capítulo III. Modelo teórico | `10_contribucion_conclusiones.md` `[vacío]` + `07c_diseno_artefacto.md` + `07b_requisitos.md` | Fórmula 6.10 + volcado — ver §3 | **Provisional — requiere E10** |
| 10. Capítulo IV. Propuesta | `07a_alternativas.md`, `07c_diseno_artefacto.md`, `07d_plan_construccion.md` `[vacío]`, `07e_construccion_verificacion.md` `[vacío]`, `08_evaluacion.md` `[vacío]`, `09_enlace_solucion.md` `[vacío]` | Fórmula 6.11 + volcado — ver §3 | **Parcial — E7d/E7e/E8/E9 pendientes** |
| 11. Conclusiones | `10_contribucion_conclusiones.md` `[vacío]`, `08_evaluacion.md` `[vacío]` | Una por capítulo, en términos de resultados | **Pendiente — requiere E8/E10** |
| 12. Recomendaciones | `10_contribucion_conclusiones.md` `[vacío]` (trabajo futuro) | Sugerencias viables | **Pendiente — requiere E10** |
| 13. Referencias bibliográficas | `propuesta_borrador_v1.md` §12 (22 entradas verificadas) | APA 7; correspondencia bidireccional | **Listo** |
| 14. Anexos | `06_diagnostico.md`, `07f_ficha_artefacto.md` `[vacío]` + este mapa | Instrumentos, ficha y mapa DS → ALSIE | **Parcial — ficha pendiente (E7f)** |

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
| Plan de construcción y versiones | `07d_plan_construccion.md` `[vacío]` — **requiere E7d** |
| Registro de construcción y verificación interna | `07e_construccion_verificacion.md` `[vacío]` — **requiere E7e** |
| Evaluación (ciclos formativo y sumativo) con datos y resultados | `08_evaluacion.md` `[vacío]` — **requiere E8** |
| Matriz de trazabilidad propuesta ↔ solución | `09_enlace_solucion.md` `[vacío]` — **requiere E9**; borrador en `matriz_coherencia.md` §"Trazabilidad propuesta ↔ solución" |

### Conclusiones / Recomendaciones
| Contenido del IFI | Fuente exacta |
|:--|:--|
| Conclusiones por capítulo | `10_contribucion_conclusiones.md` `[vacío]` — **requiere E10** |
| Recomendaciones (trabajo futuro) | `10_contribucion_conclusiones.md` `[vacío]` — **requiere E10** |

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
| V1 | 6.5 Hipótesis | Principios de diseño validados | E10 | ¿Valida la hipótesis provisional construida desde el diseño (A2 + techo de capacidad)? |
| V2 | 6.6 Aporte teórico | Principios de diseño validados | E10 | ¿Valida el aporte provisional? |
| V3 | 6.7 Significación práctica | Enlace propuesta ↔ solución y evaluación | E9/E8 | ¿Valida la significación provisional? |
| V4 | 9. Capítulo III | Principios de diseño y propiedades del modelo | E10 | ¿Confirma los componentes y relaciones del modelo provisional? |
| V5 | 10. Capítulo IV | Plan de construcción, construcción, evaluación, matriz de trazabilidad | E7d/E7e/E8/E9 | — (depende de etapas) |
| V6 | 11. Conclusiones | Resultados por capítulo | E8/E10 | — (depende de etapas) |
| V7 | 12. Recomendaciones | Trabajo futuro | E10 | — (depende de etapas) |
| V8 | 14. Anexo B | Ficha reproducible del artefacto | E7f | — (depende de etapas) |
| V9 | 6.5/6.6/6.7 | Estructura oficial con autor de la propuesta | E7c/tesista | ¿Cuál es la estructura oficial (con autor) sobre la que se elabora el método? |
| V10 | 1. Carátula | Logo institucional | Tesista | ¿Se inserta el logo en el maquetado final? |
| V11 | 2. Agradecimientos | Inclusión del tutor | Tesista | ¿Se agradece al tutor (ítem 13, revisión del 30 oct)? |
