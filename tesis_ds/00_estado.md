# Estado de la tesis

## Datos generales

- **Tesista:** Natalia Fabiola Medrano Cambará
- **Programa:** Maestría en Ingeniería de Software (fijado)
- **Tutor:** Luis Roberto Pérez Rios, Ph.D. (fijado)
- **Institución de destino:** se define durante la traducción al modelo institucional
- **Fecha de inicio:** 24 de septiembre de 2026
- **Tema candidato (aún no es título):** Detección de anomalías en lecturación y facturación mediante aprendizaje automático
- **Título provisional (se cierra en E3):** *Método de detección y verificación de lecturas anómalas en el ciclo de lecturación y facturación de energía eléctrica: aplicación en ENDE*. Variantes según la definición de anomalía elegida en E2 (ver `02_delimitacion.md`).

## Calendario declarado por la tesista

| Hito | Fecha | Fuente |
|:--|:--|:--|
| Perfil entregado | lunes 28 de septiembre de 2026 | `assets/sesion1.md` |
| Predefensa y propuesta completa (ítems 11–14) | fin de octubre de 2026 | `assets/sesion1.md` |
| Defensa final, traducción ALSIE y presentación (ítems 15–16) | finales de noviembre de 2026 | `assets/sesion1.md` |

## Etapas

| Etapa | Estado | Archivo | Fecha de cierre |
|:--|:--|:--|:--|
| E0. Encuadre | **cerrada** | `00_estado.md` | 24 sep 2026 |
| E1. Áreas y temas | **cerrada** | `01_areas_y_temas.md` | 24 sep 2026 |
| E2. Delimitación | **cerrada** | `02_delimitacion.md` | 26 sep 2026 |
| E3. Perfil de investigación DS | **cerrada** | `03_perfil_ds.md` | 26 sep 2026 |
| E4. Marco teórico | pendiente | `04_marco_teorico.md` | |
| E5. Estado del arte | pendiente | `05_estado_del_arte.md` | |
| E6. Diagnóstico con indicadores | pendiente | `06_diagnostico.md` | |
| E7a. Alternativas de solución | pendiente | `07a_alternativas.md` | |
| E7b. Requisitos del artefacto | pendiente | `07b_requisitos.md` | |
| E7c. Diseño del artefacto | pendiente | `07c_diseno_artefacto.md` | |
| E7d. Plan de construcción y versiones | pendiente | `07d_plan_construccion.md` | |
| E7e. Construcción y verificación interna | pendiente | `07e_construccion_verificacion.md` | |
| E7f. Ficha del artefacto | pendiente | `07f_ficha_artefacto.md` | |
| E8. Evaluación | pendiente | `08_evaluacion.md` | |
| E9. Enlace propuesta ↔ solución | pendiente | `09_enlace_solucion.md` | |
| E10. Contribución y conclusiones | pendiente | `10_contribucion_conclusiones.md` | |

## Decisiones tomadas

| Fecha | Decisión | Justificación |
|:--|:--|:--|
| 24 sep 2026 | Tema de trabajo: detección de anomalías en lecturación y facturación con aprendizaje automático ("Tema 1" de la sesión 1) | Elegido por la tesista; cumple los ítems del checklist del grupo según `assets/sesion1.md` |
| 24 sep 2026 | Trabajar bajo Design Science con producción en Markdown y APA 7 | Reglas del asesor; fijadas en E0 |
| 24 sep 2026 | Contexto de investigación: ENDE, sistema de distribución comercial de facturación y venta de energía eléctrica; la tesista es administradora del sistema con acceso total a base de datos y código | Respuesta de la tesista en E1; elimina el riesgo de acceso identificado en `assets/sesion1.md` |
| 24 sep 2026 | Pila tecnológica del contexto: PHP, PostgreSQL, JavaScript | Respuesta de la tesista en E1 |
| 24 sep 2026 | Tema elegido en la variante A: método de detección y verificación de irregularidades en lecturación y facturación | Tipología que evita exigir entrenamiento de modelos (competencia que la tesista declara no tener) y permite *exemplar* sobre el sistema que administra. Registro en `01_areas_y_temas.md` |
| 24 sep 2026 | Tipología del artefacto: **método** | Elección explícita de la tesista en E1; fija el diseño de E7, la verificación de E7e y el método de evaluación de E8 (aplicabilidad y efectividad) |
| 24 sep 2026 | La técnica de detección no se promete en el título; queda como decisión de diseño de E7a | La tesista declara no haber entrenado modelos; prometer aprendizaje automático en el título sería una afirmación más amplia que la evidencia |
| 26 sep 2026 | El histórico `tfv_histo_lec` conserva la lectura bruta sin sobrescribir | Respuesta de la tesista; elimina el riesgo de pérdida del valor original |
| 26 sep 2026 | El reclamo de la ODECO en `tfv_reclamo` se adopta como candidato a etiqueta independiente del lecturador | Los códigos los asigna el lecturador y no pueden usarse simultáneamente como entrada y como verdad de referencia |
| 26 sep 2026 | Título provisional: sin la expresión "mediante aprendizaje automático" | Confirmación explícita de la tesista (respuesta 5 del 26 sep 2026) |
| 26 sep 2026 | **Opción 2:** el método debe detectar anomalías **no declaradas** por el lecturador, barriendo el histórico completo | Elección explícita de la tesista. Eleva el riesgo de alcance y convierte a la técnica de detección en decisión central de E7a |
| 26 sep 2026 | Cadena de verificación vigente adoptada como estructura de roles del método y como fuente de evaluadores independientes | Descripción de la tesista: recepción del ODECO → validación en sitio → respuesta al ODECO → conciliación por el encargado de facturación |
| 26 sep 2026 | Datos preliminares de reclamos: ~50/mes, ~40 procedentes/mes | Estimado de la tesista; conversión exacta pendiente para E6 |
| 26 sep 2026 | Cronograma: perfil 28 sep, propuesta fin de octubre, defensa finales de noviembre — **fechas exigidas** | Confirmación explícita de la tesista; obliga a tres días de rediseño como mínimo y a recorte de alcance en E7d si hay deslizamiento |
| 26 sep 2026 | Borrador del perfil de investigación entregado (`03_perfil_ds.md`) | Elaborado sobre E1 y E2 para cumplir la fecha del 28 de septiembre |
| 26 sep 2026 | **Oración de contribución adoptada** (gate de E3): "Este estudio construye un método de detección y verificación previa a la facturación de lecturas sin código de irregularidad que presentan consumos atípicos, y de su aplicación y evaluación en ENDE se desprenden principios de diseño que permiten a una distribuidora regulada por la AETN incorporar detección sistemática a su ciclo de lecturación sin exceder la capacidad de su equipo de verificación." | Escrita y adoptada por la tesista tras dos correcciones: incorpora conocimiento transferible, elimina la promesa de reducir reclamos como logro, corrige "lecturas normales con consumos atípicos" y reorienta la tipología a método |

## Preguntas abiertas

- **Dato decisivo para E6:** cuántos de los ~40 reclamos procedentes mensuales corresponden a lecturas **sin** código de irregularidad. Es la evidencia de que la detección existente deja pasar anomalías y la línea base del diagnóstico. Consulta entregada, pendiente de ejecución.
- **`tfv_reclamo`:** conversión a conteo anual exacto y campo de procedencia.
- **Datos de E6:** periodicidad confirmada de las 5 000 lecturas con código; total de cuentas en todas las regionales; número de participantes de la evaluación y su disponibilidad.
- **Cuantificación económica:** facturas observadas y energía no facturada. La tesista declara no disponer de esas cifras; si no se obtienen, la línea base se apoya en horas de verificación y en reclamos procedentes.
- **Competencias en detección:** la tesista declara no haber entrenado modelos predictivos. La técnica de detección se decide en E7a; condiciona el alcance de "construir" y su curva de aprendizaje en un calendario exigido.
- **Eslabones huérfanos de `matriz_coherencia.md`:** valores numéricos de los criterios de éxito y base de conocimiento verificada (E4) — ambos pendientes.

## Próximo paso

- **28 sep:** entrega del perfil de investigación (E0–E3 cerradas).
- **29 sep – 12 oct:** E4 (marco teórico que sustenta el diseño) y E5 (estado del arte sobre artefactos existentes). Requieren verificación de fuentes con búsqueda web antes de citar.
- Después: E6, donde se fijan los valores de los criterios de éxito antes de construir.

## Próximo paso

- Cerrar E1: área de experiencia mayor, contexto real de construcción y evaluación, y tipo de artefacto probable.
