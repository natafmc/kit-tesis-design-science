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
| Primer borrador de propuesta | lunes 5 de octubre de 2026 | Comunicación de la tesista, 28 sep 2026 |
| Predefensa y propuesta completa (ítems 11–14) | fin de octubre de 2026 — confirmado vigente | Confirmado por la tesista el 28 sep 2026 |
| Defensa final, traducción ALSIE y presentación (ítems 15–16) | finales de noviembre de 2026 — confirmado vigente | Confirmado por la tesista el 28 sep 2026 |

## Etapas

| Etapa | Estado | Archivo | Fecha de cierre |
|:--|:--|:--|:--|
| E0. Encuadre | **cerrada** | `00_estado.md` | 24 sep 2026 |
| E1. Áreas y temas | **cerrada** | `01_areas_y_temas.md` | 24 sep 2026 |
| E2. Delimitación | **cerrada** | `02_delimitacion.md` | 26 sep 2026 |
| E3. Perfil de investigación DS | **cerrada** | `03_perfil_ds.md` | 26 sep 2026 |
| E4. Marco teórico | **cerrada** | `04_marco_teorico.md` | 2 oct 2026 |
| E5. Estado del arte | **cerrada** | `05_estado_del_arte.md` | 2 oct 2026 |
| E6. Diagnóstico con indicadores | en curso (línea base medida) | `06_diagnostico.md` | |
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
| 26 sep 2026 | El histórico **`tfv_historico_lecturador`** conserva la lectura bruta sin sobrescribir *(el nombre `tfv_histo_lec` usado el 26 sep era incorrecto; corregido el 2 oct 2026)* | Respuesta de la tesista; elimina el riesgo de pérdida del valor original |
| 26 sep 2026 | El reclamo de la ODECO en `tfv_reclamo` se adopta como candidato a etiqueta independiente del lecturador | Los códigos los asigna el lecturador y no pueden usarse simultáneamente como entrada y como verdad de referencia |
| 26 sep 2026 | Título provisional: sin la expresión "mediante aprendizaje automático" | Confirmación explícita de la tesista (respuesta 5 del 26 sep 2026) |
| 26 sep 2026 | **Opción 2:** el método debe detectar anomalías **no declaradas** por el lecturador, barriendo el histórico completo | Elección explícita de la tesista. Eleva el riesgo de alcance y convierte a la técnica de detección en decisión central de E7a |
| 26 sep 2026 | Cadena de verificación vigente adoptada como estructura de roles del método y como fuente de evaluadores independientes | Descripción de la tesista: recepción del ODECO → validación en sitio → respuesta al ODECO → conciliación por el encargado de facturación |
| 26 sep 2026 | Datos preliminares de reclamos: ~50/mes, ~40 procedentes/mes — **retirados el 1 oct**: el dato medido es 314 en 21 meses (≈ 15/mes) y 62 procedentes (≈ 3/mes) | Estimado de la tesista, sustituido por la extracción `DATOS.xlsx` |
| 26 sep 2026 | Cronograma: perfil 28 sep, propuesta fin de octubre, defensa finales de noviembre — **fechas exigidas** | Confirmación explícita de la tesista; obliga a tres días de rediseño como mínimo y a recorte de alcance en E7d si hay deslizamiento |
| 26 sep 2026 | Borrador del perfil de investigación entregado (`03_perfil_ds.md`) | Elaborado sobre E1 y E2 para cumplir la fecha del 28 de septiembre |
| 26 sep 2026 | **Oración de contribución adoptada** (gate de E3): "Este estudio construye un método de detección y verificación previa a la facturación de lecturas sin código de irregularidad que presentan consumos atípicos, y de su aplicación y evaluación en ENDE se desprenden principios de diseño que permiten a una distribuidora regulada por la AETN incorporar detección sistemática a su ciclo de lecturación sin exceder la capacidad de su equipo de verificación." | Escrita y adoptada por la tesista tras dos correcciones: incorpora conocimiento transferible, elimina la promesa de reducir reclamos como logro, corrige "lecturas normales con consumos atípicos" y reorienta la tipología a método |
| 28 sep 2026 | El borrador se presenta el **lunes 5 de octubre** en lugar del 28 de septiembre | Comunicación de la tesista. La semana ganada se asigna a E4 y E5, no a construcción |
| 28 sep 2026 | El entregable del 5 de octubre es el **primer borrador de propuesta**, no solo el perfil; el resto del calendario (propuesta completa fin de octubre, defensa finales de noviembre) se mantiene | Confirmación de la tesista. Borrador iniciado en `propuesta_borrador_v1.md`,13 secciones, con E4 y E5 como secciones pendientes |
| 30 sep 2026 | ~~**Evidencia del problema obtenida:** en el ciclo de agosto, 207 reclamos procedentes, de los cuales 200 (96,6 %) correspondieron a lecturas sin código de irregularidad~~ — **retirada el 1 oct 2026** por decisión de la tesista; no se reproduce | Queda suprimida. Sustituto verificado: `DATOS.xlsx` (314 reclamos y 62 procedentes en 21 meses; 5 reclamos en agosto de 2026) |
| 30 sep 2026 | ~~El indicador que se publica es la **razón de tasas** entre lecturas con y sin código, no el 96,6 % aislado~~ — decisión **modificada el 1 oct**: el 96,6 % se retira por completo y la razón de tasas se sostiene con el dato medido (33,1×) | El porcentaje sin la proporción base del universo no es informativo. Ya no hay dos cifras en competencia: solo queda `DATOS.xlsx` |
| 1 oct 2026 | **Línea base consolidada de E6** a partir de `DATOS.xlsx`: 314 reclamos en 21 meses, 62 procedentes (74,19 % Tipo 1), 98,96 % del facturable es Tipo 1, 242,2 correcciones manuales mensuales en 2026 | Extracción real de FACTUR; todos los porcentajes verificados aritméticamente. Registrado en `06_diagnostico.md` |
| 1 oct 2026 | **Se invalida la cifra del 30 sep** (207 procedentes en agosto, 96,6 %) — *ampliada el mismo día en la decisión siguiente: retiro definitivo* | El archivo consolidado registra 5 reclamos en agosto de 2026. Probable duplicación de filas por enlace mal ajustado. No pueden convivir las dos cifras en un documento |
| 1 oct 2026 | Las opciones 1 y 2 **no son excluyentes**: el método barre todo el conjunto y usa la familia de código como variable de priorización | Las lecturas con código son el 1,04 % del universo pero originan el 25,81 % de los procedentes y tienen 33 veces más tasa; descartarlas ignora la señal más intensa |
| 1 oct 2026 | Las correcciones manuales pre-facturación (TI sombra, ~242,2/mes) se adoptan como línea base del criterio de carga y como respuesta a la objeción de "el problema ya está resuelto" | El cambio queda en el log pero **no hay reporte accesible ni constancia del criterio** (*corregido el 2 oct*); es el trabajo que el método formalizaría |
| 1 oct 2026 | **Población exacta: 29 750 cuentas.** Se retira el redondeo de 29 000 y se corrige el "25 % de lecturas con código" por el **1,04 %** medido (5 528 de 532 258) | Confirmación de la tesista y `DATOS.xlsx`. Se reescribieron el problema de diseño en `02_delimitacion.md`, `03_perfil_ds.md` y `propuesta_borrador_v1.md` |
| 1 oct 2026 | La cifra de **20 000 usuarios** declarada en E1 se retira: era un estimado sin base, ya no significa nada | Declaración expresa de la tesista. Corregido en `01_areas_y_temas.md` |
| 1 oct 2026 | **Causa de la ruptura de junio de 2025:** hubo capacitaciones al personal **en mayo y junio de 2025**. La serie 2025 deja de ser línea base única; la base utilizable es post-capacitación (295 → 242,2) | Declaración de la tesista. Implica que la capacitación es una **alternativa existente** que debe incluirse y compararse en E7a, y que el problema no es la inacción sino el **residual** que la capacitación no eliminó |
| 1 oct 2026 | **Las lecturas las registra personal terciarizado de la empresa**, no personal de ENDE | Declaración de la tesista. Afecta la estructura de roles del método: quien toma la lectura, quien la corrige y quien verifica son tres actores distintos, y el primero es externo |
| 1 oct 2026 | **Naturaleza de las correcciones manuales: lectura mal tomada.** No son estimaciones por impedimento ni correcciones de datos | Declaración de la tesista. Fija qué debe sustituir el método: errores de captura detectados y corregidos a mano antes de facturar |
| 1 oct 2026 | **La evidencia fotográfica de la corrección no se guarda en el sistema** | Declaración de la tesista. Vacío de trazabilidad: la corrección que evita el reclamo deja un rastro que no puede auditarse después |
| 1 oct 2026 | **Se retira definitivamente la cifra de 207** (30 sep). No se reproduce ni se investiga más | Decisión de la tesista. Sustituto verificado: `DATOS.xlsx`, 5 reclamos en agosto de 2026 y 62 procedentes en 21 meses |
| 2 oct 2026 | **Cadena de corrección descrita en cinco pasos y cinco roles**, con el encargado de facturación como punto único que detecta, solicita verificación y corrige | Declaración de la tesista. Reemplaza la descripción anterior de "corrección manual en hoja de cálculo", que omitía la visita y los actores |
| 2 oct 2026 | **Regla de detección vigente:** desviación del consumo frente a los **últimos 6 meses**, en **ambas direcciones** (superior e inferior), **sin umbral numérico ni registro** de la decisión | Declaración de la tesista. Formaliza lo que hoy hace el encargado de facturación; convierte el umbral en decisión de diseño de E7b y el tratamiento de estacionalidad en requisito de E7c |
| 2 oct 2026 | **La evidencia fotográfica sí se conserva**, en la computadora del encargado de facturación — **se corrige** la anotación del 1 oct que decía que no quedaba | Declaración de la tesista. El problema no es la pérdida sino el **silo**: la foto no está en el sistema ni enlaza con la lectura corregida |
| 2 oct 2026 | **El histórico `tfv_historico_lecturador` llega hasta 2022**: 57 meses y cuatro ciclos anuales completos. Se levanta la restricción de estacionalidad | Declaración de la tesista. Consecuencia inmediata: hay que **ampliar la extracción**, porque `DATOS.xlsx` solo cubre 21 meses y eso es lo que hoy sostiene el documento |
| 2 oct 2026 | **Confirmado:** `tfv_reclamo` y las correcciones **también llegan a 2022**, con **mismo esquema**, y la extracción ampliada es **viable** | Respuesta de la tesista. Permite especificar A2.1–A2.4 en `consultas_base_datos.md`, con prueba de reproducibilidad contra las tres cifras de `DATOS.xlsx` antes de publicar nada |
| 2 oct 2026 | **Corrección de la trazabilidad:** la corrección **sí queda en el log del sistema**. Se retiró "sin trazabilidad" y "sin registro de decisiones" de todos los documentos | Declaración de la tesista. Lo que falta es un **reporte accesible** con fecha y lectura nueva, y la **constancia del criterio y de la evidencia**. Se corrigieron `02_delimitacion.md`, `03_perfil_ds.md`, `06_diagnostico.md`, `propuesta_borrador_v1.md` y `matriz_coherencia.md` |
| 2 oct 2026 | **Bloque 0 cerrado:** tablas reales `tfv_historico_lecturador`, `tfv_reclamo`, `tfv_reclamo_lectura`. Escritas las consultas A2.1–A2.4 en `sql_a2_extraccion.sql` | Esquema entregado por la tesista. Se corrigió el nombre `tfv_histo_lec` en cuatro documentos y se marcó como superado el SQL antiguo |
| 2 oct 2026 | **Dos huecos del esquema: [B1] falta la tabla de tipo de lectura y código de irregularidad; [B2] falta la tabla de la lectura facturada** | Consecuencia directa de listar los campos. Sin B1 no se reproduce el 74,19 % ni la segmentación de la Opción 2; sin B2 no se derivan las 242,2 correcciones |
| 2 oct 2026 | **A2.2 es viable por comparación:** las correcciones se reconstruyen enfrentando la lectura facturada con `tfv_historico_lecturador.lec_actual`. **Confirmado además** que cada reclamo permite ubicar cuenta y mes | Respuesta de la tesista. Habilita la verdad de referencia de E8 y permite verificar los 242,2/mes por vía independiente de la hoja de cálculo. *Sujeto a resolver [B2]* |
| 2 oct 2026 | **E4 cerrada.** Marco de cuatro ejes con prueba de eliminación aplicada: **15 de 17 secciones se conservan y 2 se eliminan** | Las eliminadas —auditoría y control interno; marco regulatorio como sección teórica— no cambiaban el diseño. Sus exigencias entran por E2, E6 y E7b. Registro en `04_marco_teorico.md` §6 |
| 2 oct 2026 | **La contribución NO puede ser una técnica nueva de detección** | Gregor y Hevner (2013): dominio del problema escaso y dominio de la solución abundante —tres revisiones sistemáticas desde 2020—. Confirma el alcance de la oración de contribución adoptada en E3 |
| 2 oct 2026 | **La exactitud (accuracy) queda descartada como criterio de éxito**; los criterios 1 y 2 son precisión-exhaustividad | Saito y Rehmsmeier (2015): bajo desequilibrio la curva ROC es optimista. El criterio 3 —carga dentro de capacidad— se eleva a **criterio de viabilidad** por la falacia de la tasa base (Axelsson, 2000) y por costar cada falsa alarma un desplazamiento |
| 2 oct 2026 | **Cada alerta debe llevar la comparación que la originó, y la resolución debe registrarse con criterio y evidencia** | Nwafor et al. (2023) y Noorchenarboo y Grolinger (2025): una alerta que no se explica no se adopta. Convierte el registro de resolución en requisito, no en preferencia de redacción |
| 2 oct 2026 | **La segmentación por perfil es paso previo a la detección, no salida** | Piscitelli et al. (2026): el perfilado precede a la detección a nivel de medidor. Confirma la estructura segmentada ya anunciada en la propuesta §7 |
| 2 oct 2026 | **La ventana de 6 meses de la regla vigente no cubre el ciclo anual** —consecuencia lógica de la definición de la regla, no afirmación bibliográfica— | La ventana no incluye el mismo mes del año anterior. Sustento empírico: histórico de 57 meses desde 2022. El tratamiento de estacionalidad queda como requisito de E7c y **exige ejecutar la extracción ampliada antes de construir** |
| 2 oct 2026 | **E5 cerrada como búsqueda preliminar, no como revisión sistemática.** Corpus: **15 trabajos** (6 del eléctrico como fenómeno y 9 de detección e inspección) + 7 de Design Science = **22 entradas**; 21 por DOI en Crossref y 1 en AISeL. **No se citan materiales internos** | Declaración explícita del alcance en `05_estado_del_arte.md` §2.2. Las afirmaciones de brecha quedan **provisionales** hasta la ampliación decidida |
| 2 oct 2026 | **La brecha se formula así:** la literatura sabe puntuar una lectura y sabe que inspeccionar exige priorizar, pero no documenta cómo convertir esa puntuación en una decisión operativa dentro de un ciclo de lecturación-facturación sujeto a catálogo regulatorio, con etiquetas escasas y retardadas, coste de alerta no recuperable, alternativa vigente ya eficaz y universo sin barrer | `05_estado_del_arte.md` §8. **Provisional** hasta cerrar el protocolo |
| 2 oct 2026 | **Se descarta rellenar el hueco de auditoría y control interno con una fuente dudosa**: la cadena de búsqueda no devolvió nada pertinente | Regla de no inventar referencias. **Decisión complementaria del asesor:** una búsqueda más en bases de regulación y política energética antes de la propuesta completa; si no hay fuente, el tema queda fuera del marco teórico por decisión explícita |
| 2 oct 2026 | **[DEC-1] El estado del arte se amplía a IEEE Xplore y SciELO/LILACS** antes de la propuesta completa, **con cuenta de registros identificados, eliminados e incluidos**; Scopus y Web of Science quedan fuera del alcance de este ciclo | Sin ese conteo no hay flujo de criba y la brecha no puede pasar de provisional a definitiva. Resuelve parcialmente E5-1 |
| 2 oct 2026 | **[DEC-2] Los artefactos comerciales y de código abierto se difieren a después de la defensa de propuesta** | La sección 9 del borrador los declaraba dentro de su alcance; quedan **fuera de esta versión**, no como pendiente dentro de ella. Resuelve E5-2 |
| 2 oct 2026 | **[DEC-3] Búsqueda complementaria sobre control interno y auditoría** en bases de regulación y política energética, antes de la propuesta completa | Decisión abierta heredada de E4-3; si no devuelve fuente, se cierra por decisión explícita y se deja constancia en `04_marco_teorico.md` §5.2 y §6 |
| 2 oct 2026 | **[DEC-4] No se citan los capítulos `referencias/ds_ch*.md`.** Sus afirmaciones se sustituyeron por la fuente primaria —Peffers et al. (2007), Wieringa (2014), Venable et al. (2016), March y Smith (1995), Hevner et al. (2004)— o se reformularon como criterio adoptado por este estudio | Cierra E4-1. **Salvedad:** no todo tenía fuente primaria verificable; lo que no la tuvo se marcó `[por verificar]` —hoy la plantilla de principios de Wieringa (2014) |
| 2 oct 2026 | **[DEC-5] Hevner et al. (2004): se conserva el rango 75–105** y se retira la nota de discrepancia del borrador | Cierra E4-2. Crossref reporta 75–106; se prevalece la lista canónica del asesor, que es la fuente institucional del trabajo. La discrepancia queda registrada en `04_marco_teorico.md` §9 |
| 2 oct 2026 | **[DEC-6] IEEE Xplore se consultará sobre metadatos y resúmenes públicos, sin acceso institucional.** SciELO y LILACS sí son abiertos | Respuesta de la tesista. **Es una limitación del protocolo, no un detalle operativo:** se declara en `05_estado_del_arte.md` §2.1 y §2.2 y en el borrador §9.1, porque condiciona qué se pudo leer de cada registro |
| 2 oct 2026 | **[DEC-7] DEC-1 y DEC-3 se ejecutan el fin de semana del 3 y 4 de octubre**, no en la ventana 6–12 oct | Respuesta de la tesista. **Motivo:** si la ampliación corre antes, la brecha de E5 deja de ser provisional para la entrega del borrador del 5 oct. **Costo:** compite con la revisión final del borrador — hay que resguardar el tiempo de esta entrega |
| 2 oct 2026 | **[DEC-8] Scopus y Web of Science quedan fuera de alcance —confirmado.** La ampliación se circunscribe a Crossref + IEEE Xplore (metadatos) + SciELO/LILACS | Respuesta de la tesista. Ya estaba escrito en el protocolo de E5 y en el borrador §9.1; queda confirmado, no deducido |

## Preguntas abiertas

- **Bloque 0 — nombres reales de tablas y columnas:** ~~cerrado el 2 oct 2026~~ → `tfv_historico_lecturador`, `tfv_reclamo`, `tfv_reclamo_lectura`. El nombre `tfv_histo_lec` usado en los documentos **era incorrecto** y ya fue sustituido.
  - **[B1] Falta la tabla del tipo de lectura (0/1/2/3) y del código de irregularidad.** Sin ella no se reproduce el 74,19 % ni la segmentación de la Opción 2.
  - **[B2] Falta la tabla de la lectura facturada**, para derivar las ~242,2 correcciones mensuales.
  - **[B3] Confirmar** si `sw_proceso` equivale al `sw_procedente` (1/2/4) de `DATOS.xlsx`.
- ~~**Corregir `tfv_histo_lec` en los documentos**~~ → **cerrado el 2 oct 2026.** Corregido en `propuesta_borrador_v1.md`, `03_perfil_ds.md`, `02_delimitacion.md` y `06_diagnostico.md`. Falta sustituir el SQL antiguo de `consultas_base_datos.md`, marcado como superado por `sql_a2_extraccion.sql`.
- **Ampliar la extracción a enero de 2022:** *confirmado el 2 oct 2026* — reclamos y correcciones llegan a 2022, mismo esquema, extracción viable. **Pendiente de ejecutar** con la especificación A2.1–A2.4 de `consultas_base_datos.md`, incluida la prueba de reproducibilidad.
- **Consulta al tutor — plantilla de principios de diseño:** *por enviar.* Necesitamos que indique **capítulo y página** de Wieringa (2014) donde consta la plantilla **objetivo → contexto → mecanismo → principio**. Fue la última afirmación atribuida a un material interno, y al sustituirlo por la fuente primaria esta es la única que no se pudo confirmar — cuatro búsquedas y tres PDF ilegibles el 2 oct 2026. *Bloquea E4-4; no bloquea la entrega del lunes: la plantilla se usa con la atribución marcada.*
- **Tiempo promedio por corrección manual:** consulta enviada, pendiente de respuesta (2 oct 2026). Debe venir **desglosado por rama** —revisión en pantalla y visita con fotografía—. De eso depende el valor numérico del criterio 3 (carga de verificación).
- **Visitas que no terminan en corrección:** cuántas solicitudes de visita terminan sin cambiar la lectura. Es la tasa de falsos positivos de la detección manual actual y la línea base del criterio 2.
- **Consulta 2.3:** tiempos de respuesta reales en la ODECO frente al plazo reglamentario de 3 a 15 días hábiles. *Hipótesis de campo disponible:* `fecha_odeco − fecha_hora_reg` en `sql_a2_extraccion.sql`, pendiente de confirmar qué significa `fecha_odeco`.
- **Destino completo de la fotografía:** se confirma que vive en la computadora del encargado; falta saber si además se imprime o se copia y qué pasa si ese equipo falla.
- **Conciliar los totales:** 2025-01 suma 27 370 en la Tabla 2 y 28 355 en la Tabla 3. Hay que declarar el filtro de cada tabla.
- **Competencias en detección:** la tesista declara no haber entrenado modelos predictivos. La técnica de detección se decide en E7a; condiciona el alcance de "construir" y su curva de aprendizaje en un calendario exigido.
- **Eslabones huérfanos de `matriz_coherencia.md`:** valores numéricos de los criterios de éxito (parcialmente disponibles) — pendientes de E6 y E7b. ~~Base de conocimiento verificada (E4)~~ → **cerrado el 2 oct 2026**: `04_marco_teorico.md` y `05_estado_del_arte.md`.

### Gate de E4 y E5 — puntos abiertos

**Cerrados por decisión del asesor el 2 de octubre de 2026:**

- ~~[E4-1] Título y forma de citación del manuscrito `referencias/ds_ch*.md`~~ → **DEC-4: no se citan materiales internos**; se sustituyen por fuente primaria.
- ~~[E4-2] Discrepancia de páginas en Hevner et al. (2004)~~ → **DEC-5: se conserva 75–105** y se retira la nota del borrador.
- ~~[E4-3] Decidir sobre la búsqueda de control interno y auditoría~~ → **DEC-3: se hace una búsqueda complementaria** en bases de regulación y política energética.
- ~~[E5-1] Decidir sobre la ampliación del protocolo~~ → **DEC-1: se amplía a IEEE Xplore y SciELO/LILACS**, con cuenta de registros. *Ampliación decidida, pendiente de ejecutar.*
- ~~[E5-2] Decidir sobre artefactos comerciales y de código abierto~~ → **DEC-2: diferidos a después de la defensa de propuesta.**

**Abiertos:**

- **[E4-4]** Confirmar el **capítulo y la página de Wieringa (2014)** donde consta la plantilla objetivo → contexto → mecanismo → principio. **Cuatro búsquedas el 2 oct 2026 no la localizaron**; los PDF de Springer, la Universidad de Twente y GBV no se pudieron leer. **Confirmado el 2 oct: la tesista no tiene el libro → la consulta va al tutor**, que lo cita en su manuscrito. *Estado: por enviar.* Hoy es el único `[por verificar]` del marco teórico. **La plantilla se usa igualmente**; lo pendiente es solo la atribución.
- **[E4-5]** **DEC-3 ejecutada el 3–4 oct (DEC-7).** Si no devuelve fuente verificable, cierre por decisión explícita con constancia en `04_marco_teorico.md` §5.2 y §6.
- **[E5-1a]** **DEC-1 ejecutada el 3–4 oct (DEC-7):** IEEE Xplore **sobre metadatos y resúmenes** (DEC-6) + SciELO/LILACS abiertos, produciendo la **cuenta de registros identificados, eliminados e incluidos**. **Sin ese conteo E5 no se cierra.**
- **[E5-3] Revisar la brecha** de `05_estado_del_arte.md` §8 tras E5-1a: confirmar, ampliar o retirar. **Hasta entonces es provisional.**
- **[E5-4]** Verificar si existe literatura que use **"lectura mal tomada"** como categoría de anomalía: es la categoría central del estudio y no se localizó. Forma parte de E5-1a.

### Cerradas

- ~~Causa de la ruptura de junio de 2025~~ → capacitaciones en mayo y junio de 2025.
- ~~Naturaleza de las correcciones~~ → lectura mal tomada, por personal terciarizado.
- ~~Regla de detección actual~~ → desviación frente a 6 meses, dos direcciones, sin umbral (2 oct 2026).
- ~~Antigüedad de `tfv_histo_lec`~~ → **desde 2022**, cuatro ciclos anuales completos (2 oct 2026).
- ~~Cadena de corrección~~ → cinco pasos, cinco roles; el encargado de facturación concentra detectar, pedir verificación y corregir (2 oct 2026).
- ~~Destino de la fotografía~~ → computadora del encargado, fuera del sistema (2 oct 2026).
- ~~Procedencia de la cifra de 207~~ → retirada definitivamente (1 oct 2026).
- ~~Población 29 000 / 20 000~~ → 29 750 exactas (1 oct 2026).

## Próximo paso

- **3 – 4 oct (DEC-7):** ejecutar **DEC-1** —ampliación a IEEE Xplore por metadatos y resúmenes + SciELO/LILACS, con la cuenta de registros identificados, eliminados e incluidos— y **DEC-3** —búsqueda de control interno y auditoría en bases de regulación y política energética—. Con DEC-1 ejecutada, **E5-3** decide si la brecha se confirma, amplía o retira: deja de ser provisional. **La ampliación no puede comerse el tiempo de revisión del borrador.**
- **4 oct:** entregar E4 y E5 al correo del grupo. **5 oct:** entregar `propuesta_borrador_v1.md` — **13 de 13 secciones escritas**, con 22 entradas de referencia (21 por DOI en Crossref, 1 en AISeL) y **cero entradas sin verificar**.
- **6 – 12 oct:** ejecutar la extracción ampliada a 2022 (`sql_a2_extraccion.sql`, A2.1–A2.4) y resolver B1, B2 y B3; primera pasada de E6. Paralelamente, **E4-4**: obtener del tutor el capítulo y la página de la plantilla en Wieringa (2014).
- **13 – 26 oct:** E6, donde se fijan los valores numéricos de los criterios de éxito antes de construir; después E7a–E7c. **E7b es el 13 de octubre**: ahí vence también la consulta de tiempo por corrección.
- **27 – 31 oct:** propuesta completa (E7d).
