# Mapeo Design Science → ALSIE (IFI Maestría)

> Archivo de trabajo que registra la trazabilidad entre los productos de `tesis_ds/` y los apartados del IFI de ALSIE. Se genera **antes** de redactar el IFI y se vuelca como **Anexo C** del propio IFI (referenciado en el cuerpo con "Ver anexo C").
>
> **Nota de actualización, 5 de noviembre de 2026 (segunda ronda, sincronizada al commit `a384ba4` de `00_estado.md`):** el gate de construcción de `07d` quedó en **6 de 6 cerrado** —primera ejecución sin depuración con 1 732 alertas y **segunda ejecución con la depuración aplicada** (commit `1acbba0` de `sql_a2_extraccion.sql`) con **1 515 alertas** (1 402 A2 + 113 A1, máximos 217 A2 en abril y 23 A1 en marzo, 0 sin ruta, 0 sin orden) validando los puntos 2 a 4, más el registro por alerta (punto 5) y el exemplar de tres alertas (punto 6); las etapas `E7e` y `E7f` **cerraron el 5 de noviembre**; y `E8`/`E9`/`E10` quedaron **en curso** —`E8` inició su fase formativa **por simulación con datos ya disponibles, sin ir a terreno**, con verificadores ajenos de ENDE (decisión de la tesista registrada el 5 nov en `00_estado.md`)—. Se refrescan además la muestra medida (4 nov: 19/109; universo ODECO = tipo 3 con 1 062/1 061) y la ficha volcada al Anexo B. **Respuestas de la tesista del 5 de noviembre de 2026:** (1) `E8`, `E9` y `E10` **siguen abiertas** —se valida en campo, ahora por simulación—; (3) carátula: **noviembre de 2026**; (4) estructura oficial: **DSRM de Peffers et al. (2007)**; (5) **dos verificadores ajenos** para la validación —**aclaración posterior: ambos son técnicos de ENDE que no participaron del estudio**—. *La inconsistencia heredada —la fila de la tabla de etapas que marcaba `E8`/`E9`/`E10` como «cerradas por decisión escrita»— **quedó resuelta en la fuente** por los commits `1acbba0` y `4280905` de esta misma tarde: `00_estado.md` ya no la contiene. Salvedad vigente: `07d_construccion.md` conserva su tabla de gate en 1 de 6 (última actualización 3 nov); el cierre completo consta en la tabla de etapas de `00_estado.md`.*

---

## 1. Equivalencias terminológicas (DS → ALSIE)

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

---

## 2. Mapa apartado por apartado (IFI → `tesis_ds/`)

| Apartado del IFI (ALSIE) | Fuente en `tesis_ds/` | Transformación | Estado trazabilidad |
|:--|:--|:--|:--|
| **Carátula** | Datos del tesista (`00_estado.md` L5-L8) + programa | Completar con el tesista; no inventar | ✅ Datos disponibles |
| **Agradecimientos** | — | Opcional; pedir al tesista o dejar como nota | ❓ Pendiente tesista |
| **Dedicatoria** | — | Opcional; pedir al tesista o dejar como nota | ❓ Pendiente tesista |
| **Resumen** | `03_perfil_ds.md` (objetivo, método), `08_evaluacion.md` (resultados), `10_contribucion_conclusiones.md` (conclusiones) | Sintetizar objetivo, métodos, resultados y conclusiones; 200–250 palabras, un párrafo, en pasado | ✅ Material completo |
| **Índice** | Estructura del propio IFI | Generar lista de apartados, capítulos, epígrafes y subepígrafes | ✅ Automático |
| **Introducción** (perfil completo) | `01_areas_y_temas.md`, `02_delimitacion.md`, `03_perfil_ds.md`, `06_diagnostico.md` | Redactar perfil con fórmulas 6.1–6.9; ≤ 10 % del total | ✅ Material completo |
| Intro → **Problema científico** | `02_delimitacion.md` §1, `06_diagnostico.md` | Fórmula 6.1: situación real + brecha, sin anticipar solución | ✅ Material completo |
| Intro → **Objeto de estudio** | `02_delimitacion.md` §3, `03_perfil_ds.md` §4 | Fórmula 6.2: área del conocimiento (resignificación inversa) | ✅ Material completo |
| Intro → **Campo de acción** | `02_delimitacion.md` §4, `03_perfil_ds.md` §6 | Fórmula 6.3: propiedades y relaciones esenciales | ✅ Material completo |
| Intro → **Objetivo general y específicos** | `03_perfil_ds.md` §5, `10_contribucion_conclusiones.md` | Fórmula 6.4: verbo de conocimiento + uno por capítulo | ✅ Material completo |
| Intro → **Hipótesis** | `10_contribucion_conclusiones.md` (principios de diseño) | Fórmula 6.5: desde principios validados (objetivo→contexto→mecanismo→principio) | ✅ Material completo |
| Intro → **Aporte teórico** | `10_contribucion_conclusiones.md`, `03_perfil_ds.md` §10 | Fórmula 6.6: conceptos, relaciones, regularidades nuevas | ✅ Material completo |
| Intro → **Significación práctica** | `09_enlace_solucion.md`, `08_evaluacion.md` | Fórmula 6.7: utilidad concreta + vínculo teórico-práctico | ✅ Material completo |
| Intro → **Métodos y técnicas** | `07c_diseno_artefacto.md`, `07e_construccion_verificacion.md`, `08_evaluacion.md` | Fórmula 6.8: reclasificar en teóricos, empíricos, técnicas | ✅ Material completo |
| Intro → **Población y muestra** | `06_diagnostico.md`, `08_evaluacion.md` §3 | Fórmula 6.9: delimitar población, unidades, muestra, fundamentar selección | ✅ Material completo |
| **Capítulo I. Diagnóstico** | `06_diagnostico.md`, `08_evaluacion.md` | Volcado completo: descripción contextual, indicadores con línea base, operacionalización, instrumentos, resultados, regularidades | ✅ Material completo; notas de deriva (`DEC-134`) y de alcance ODECO (`DEC-142`) volcadas 5 nov |
| **Capítulo II. Marco teórico** | `04_marco_teorico.md` + `05_estado_del_arte.md` | Volcado completo: revisión bibliográfica + sistematización; antecedentes, definiciones, categorías, análisis histórico-lógico, valoración crítica, toma de posición | ✅ Material completo |
| **Capítulo III. Modelo teórico** | `10_contribucion_conclusiones.md`, `07c_diseno_artefacto.md`, `07b_requisitos.md` | Fórmula 6.10 + volcado completo: fundamentación epistemológica, componentes, relaciones, gráfico Mermaid, propiedades del modelo | ✅ Material completo |
| **Capítulo IV. Propuesta** | `07a_alternativas.md`, `07c_diseno_artefacto.md`, `07d_construccion.md`, `07d_metodo_escrito.md`, `07e_construccion_verificacion.md`, `07f_ficha_artefacto.md`, `08_evaluacion.md`, `09_enlace_solucion.md` | Fórmula 6.11 + volcado completo: alternativas, requisitos, diseño, estructura oficial DSRM (§10.2), construcción (gate **6 de 6 cerrado 5 nov**, ejecución depurada 1 515 alertas), verificación y ficha (etapas `E7e`/`E7f` cerradas 5 nov), evaluación (muestra medida; `E8` en curso por simulación con resultados preliminares: cobertura 0 de 19 y carga cumplida), matriz de trazabilidad | ⚠️ Parcial: resultados de `E8`, cierre de `E9`, principios de `E10` |
| **Conclusiones** | `10_contribucion_conclusiones.md`, `08_evaluacion.md` | Una por capítulo, en términos de resultados (no sugerencias) | ✅ Material completo |
| **Recomendaciones** | `10_contribucion_conclusiones.md` (trabajo futuro) | Sugerencias viables, vinculadas a conclusiones | ✅ Material completo |
| **Referencias bibliográficas** | `propuesta_borrador_v1.md` §12 (22 entradas verificadas) + `04_marco_teorico.md` §9 (19 fuentes) | APA 7; correspondencia bidireccional cita ↔ referencia | ✅ Material completo |
| **Anexos** | `06_diagnostico.md` (instrumentos), `07f_ficha_artefacto.md`, **este mapeo** | Instrumentos en blanco, ficha reproducible (Anexo B, volcada 5 nov), mapa DS→ALSIE (Anexo C) | ✅ Material completo |

---

## 3. Trazabilidad detallada por archivo fuente

### `00_estado.md`
- Datos de carátula: tesista, programa, tutor, fechas
- Calendario y decisiones transversales (DEC-1 a DEC-142)

### `01_areas_y_temas.md`
- Área de experiencia, contexto real (ENDE, 29 750 cuentas, pila PHP/PostgreSQL/JS)
- Temas candidatos y decisión de E1 (variante A, tipología método)
- Riesgos registrados

### `02_delimitacion.md`
- **Problema de diseño** (contexto, problema, solución conceptual, criterios de éxito)
- **Problema de investigación** (brecha cerrada DEC-35)
- **Objeto de estudio** (artefacto = método)
- **Campo de acción** (temático, temporal, institucional, clase de contextos)
- **Propuesta** (método de 4 momentos + exemplar)
- **Roles identificados** (5 roles, 5 pasos, separación de muestras)

### `03_perfil_ds.md`
- Título fijado (DEC-77): 15 palabras, sin siglas
- Planteamiento del problema (diseño + investigación)
- Pregunta principal y 4 subpreguntas
- Objeto de estudio y tipología (método + exemplar)
- Objetivo general y 5 específicos
- Tipología del artefacto
- Fundamentación en base de conocimiento (4 ejes, prueba de eliminación)
- Diseño metodológico (DSRM + ciclos Wieringa)
- Estrategia de evaluación (FEDS, formativa→sumativa, criterios)
- Tipo de contribución (principios de diseño nivel clase, transferibilidad analítica)
- Selección y muestra (29 750 cuentas, regional ENDE)
- Cronograma exigido
- Plan de análisis
- **Oración de contribución** (gate E3, cerrada 26 sep 2026)

### `04_marco_teorico.md`
- Eje 4: Design Science (tipología, 7 principios Hevner, 3 ciclos Hevner, DSRM+Wieringa, FEDS, Gregor y Hevner, plantilla principios)
- Eje 1: Anomalía (definición operativa, supervisado/no supervisado, métrica desequilibrio, falacia tasa base, explicabilidad, priorización)
- Eje 2: Perfil y estacionalidad (perfil precede a detección, ventana 6 meses no basta)
- Eje 3: Ciclo de relevancia (catálogo, plazos ODECO, capacidad, 5 roles) + eliminación auditoría/control interno
- Prueba de eliminación (15 conservadas, 2 eliminadas)
- Definiciones operativas (13 términos)
- Lo que NO decide (técnica, umbral, estacionalidad, criterios, capacitación)
- Registro de verificación de fuentes (19 fuentes, todas con DOI)
- Gate E4 (8 criterios cumplidos)

### `05_estado_del_arte.md`
- Protocolo de búsqueda (Crossref, ampliación OpenAlex/DOAJ, limitaciones acceso)
- Cuenta de registros (DEC-14, DEC-15, DEC-16: 448 identificados = 389 eliminados + 59 incluidos → 54 trabajos)
- Corpus verificado (15 trabajos dominio + 7 DS = 22 entradas)
- Eje A: Pérdidas no técnicas (concepto, revisiones, contexto regional)
- Eje B: Detección (dato, etiqueta, métrica, explicabilidad)
- Eje C: Del algoritmo a la visita (Guerrero, Massaferro, Xia)
- Por qué no bastan (tabla comparativa 10 dimensiones)
- **Brecha identificada** (cerrada DEC-35, opción ampliar)
- Qué se buscó y no se encontró (auditoría, reclamos, Bolivia, artefactos, "lectura mal tomada")
- Consecuencia para etapas siguientes
- Registro de verificación (15/15 dominio, 1 AISeL)
- Gate E5 (8 criterios cumplidos)

### `06_diagnostico.md`
- Población y alcance (29 750 cuentas, 57 meses, 1 389 941 lecturas facturables)
- Línea base multianual 57 meses (reclamos por gestión, tipos de lectura, correcciones, tasas)
- **Indicador 1**: Reclamos ODECO por tipo y procedencia (78,16 % sin código, razón 31,3×)
- **Indicador 2**: Correcciones manuales (242,2/mes 2026, cadena 5 pasos/5 roles, regla vigente, ruptura 2025)
- **Indicador 3**: Volumen y carga de reclamos (1 053 totales, 174 procedentes 16,52 %, 83,48 % improcedentes)
- Indicadores previstos y estado (9 indicadores, 3 medidos con línea base 57 meses)
- Dato invalidado (207 procedentes agosto 2026, retirado)
- Vacíos que restan (tiempo por corrección, visitas sin corrección, conciliación totales, consulta 2.3, destino foto, personal)

### `07a_alternativas.md`
- Tres filtros que constriñen (F1 dato mensual, F2 etiquetas escasas, F3 priorización bajo capacidad, F4 agrupación por ruta)
- Línea base A0 (regla vigente, capacitación 2025, detección reactiva ODECO)
- 4 alternativas candidatas (A1 ventana 6m, A2 ciclo anual, A3 segmento, A4 supervisado)
- Matriz de comparación (4 filtros + 2 requisitos marco + estacionalidad + capacitación + costo + riesgo)
- **Selección** (DEC-70): A2 principal, A1 contingencia, A3 paso previo, tipología método
- Consecuencias para E7b, E7c, E8, A2.3

### `07b_requisitos.md`
- 10 requisitos (R1 escrito/reproducible, R2 capacidad techo, R3 agrupación ruta, R4 explicación, R5 registro, R6 priorización, R7 segmentación precede, R8 contingencia, R9 precondiciones, R10 aplicabilidad)
- Umbral θ: forma, calibración (8 pasos, 2 umbrales θ_A2 y θ_A1), valor (PENDIENTE → FIJADO DEC-121)
- Tensión criterio 2 vs 3 (capacidad manda)
- Valores criterios tras E7b (1 fijado, 2 procedimiento fijado/valor pendiente, 3 fijado, 4 fijado/medición pendiente)
- Gate E7b (4/4 cumplidos 30 oct 2026)

### `07c_diseno_artefacto.md`
- 6 entregables: referencia anual (mediana 4 ciclos, solo 9 meses 2026, referencia > 0), huecos serie (depurar solo observada, 541 celdas excluidas), segmentación (perfil 4 cuartiles, familia 3 bandas, prueba estabilidad 59,1 %), contingencia A1 (definición A: mes existe, umbral θ_A1), criterio 4 aplicabilidad (100 % alertas muestra, verificador ajeno), depuración como paso del método
- Condición transversal: expresable como componentes y relaciones para Capítulo III
- Gate E7c (6/6 cumplidos 29 oct 2026)
- Preguntas abiertas resueltas (P1-P4)

### `07d_construccion.md`
- Plan: método escrito, procedimiento ejecutable, listado alertas, registro
- MPV: método escrito + una alerta completa + registro
- Criterio de suficiencia: 100 % alertas muestra resueltas por verificador ajeno
- Gate E7d (**6 de 6 cerrado el 5 nov 2026**, tabla de gate de `07d_construccion.md` actualizada el 5 nov con la evidencia de los seis puntos, commit `af05b11`, en concordancia con `00_estado.md`: punto 1 método escrito 3 nov `DEC-137`; punto 2 ejecución depurada `1acbba0` —1 515 alertas, 1 402 A2 + 113 A1, máximos 217 A2 abril / 23 A1 marzo, 0 sin ruta, 0 sin orden—; punto 3 23 columnas de declaración presentes en cada fila; punto 4 ruta en todas las alertas y prioridad por desviación DESC dentro de la ruta; punto 5 registro con estado `pendiente`, criterio y evidencia por alerta; punto 6 exemplar de tres alertas —una A2 normal, una A1 con contingencia, una con código— (`DEC-125`))
- Procedimiento ejecutable: consulta SQL agregada al archivo de consultas el 4 nov (commit `04327b5`); **depuración `lec_actual = 0` aplicada el 5 nov** (commit `1acbba0`)
- Ejecuciones del 5 nov: primera sin depuración (1 732 alertas = 1 619 A2 + 113 A1) y segunda depurada (1 515 = 1 402 + 113)

### `07e_construccion_verificacion.md`
- **Cerrada el 5 nov 2026** (`00_estado.md`): puntos 2 a 4 del gate válidos con la ejecución depurada; verificación interna completa. Verifica la consistencia interna del método escrito: fórmulas completas, cupos respetados, trazabilidad R1-R10, autocalculeos 1-9 cerrados

### `07f_ficha_artefacto.md`
- Escrita el 4 nov 2026 a partir de `plantillas/ficha_artefacto.md`; **etapa cerrada el 5 nov** (`00_estado.md`), completa con requisitos `R1` a `R10`
- Identificación, problema, requisitos (R1-R10), diseño (depuración→segmentación→fórmula), decisiones de diseño (7 con alternativas y justificación), versiones, verificación interna, uso, limitaciones conocidas (6), relación con base de conocimiento (CIMO)
- **Volcada íntegra al Anexo B del IFI el 5 nov 2026** (términos DS traducidos: artefacto → propuesta, problema de diseño → problema que resuelve)

### `08_evaluacion.md`
- Qué evalúa, contra qué (verdad de referencia: reclamos procedentes), métricas (precisión-exhaustividad)
- 4 criterios con valores fijados antes de construir
- **Muestra medida 4 nov 2026** (19 procedentes con lectura sobre 109 con lectura en la ventana de nueve meses; 1 843 procedentes sobre 2 713 reclamos; universo ODECO = tipo 3 con 1 062/1 061, `DEC-142`)
- Dos fases: formativa 9-15 nov, rediseño 16-18 nov, sumativa 19-24 nov (**modo de ejecución decidido el 5 nov: formativa por simulación con datos ya disponibles, sin ir a terreno, con dos verificadores ajenos de ENDE** — `00_estado.md` y aclaración de la tesista)
- **§6 Resultados de la formativa por simulación (5 nov 2026, commits `2ca6233`, `45184f5`, `00e6691`):** datos de entrada validados (1 515 alertas depuradas, máx A2=217 abril / A1=23 marzo, 0 sin ruta, 0 sin orden, 9 meses); tabla de mediciones — criterio 1 (cobertura) **medido: 0 de 19 (0 %)**, criterio 2 (falsos positivos) **medido: 1 515 de 1 515 (100 %)**, criterio 3 (carga) **cumplido** (máx 228 en abril ≤ 242) ✅, criterio 4 (aplicabilidad) **pendiente**; **hallazgo de la formativa**: declarado tal cual, sin reinterpretarlo ni ajustarlo al comparador del 16,52 %; el rediseño documentado (16–18 nov) es la instancia para analizar por qué no detectó los reclamos procedentes; verificador ajeno: personal técnico de la oficina de ENDE (la tesista aclaró que son dos, ambos de ENDE); qué falta para cerrar la formativa: criterio 4 y volcado en el gate punto 3
- Gate E8 (6 puntos; punto 1 prerequisito cumplido el 5 nov con el cierre de `E7e`/`E7f`; punto 2 cumplido con la muestra medida; **etapa en curso desde el 5 nov** — iniciada por la tesista, respuesta 1 = (b)—, con **dos verificadores ajenos, ambos técnicos de ENDE**; punto 3 en curso con el criterio 3 ya medido)

### `09_enlace_solucion.md`
- Matriz 13 secciones propuesta ↔ solución (10 cerradas, 3 en curso)
- Matriz requisitos (pendiente llenar al abrir E7d)
- Gate E9 (4 criterios)

### `10_contribucion_conclusiones.md`
- Contribución: principios de diseño nivel clase (oración gate E3)
- Plantilla principio: objetivo→contexto→mecanismo→principio (atribución van Aken/Denyer/Gregor, Wieringa como problema)
- Conclusiones responden a 4 preguntas (P1-P4)
- Limitaciones (escritas + por agregar de E8)
- Gate E10 (6 criterios, prerequisito: E8 sumativa cerrada)

### `matriz_coherencia.md`
- Cadena de coherencia (15 eslabones)
- Oración de contribución
- Trazabilidad propuesta↔solución (plantilla)
- Riesgos de construcción (9)
- Eslabones huérfanos (6, 4 cerrados)

### `propuesta_borrador_v1.md` §12
- 22 referencias verificadas (21 Crossref + 1 AISeL), APA 7

---

## 4. Vacíos que requieren respuesta del tesista

| # | Apartado IFI | Dato faltante | Pregunta al tesista |
|:--|:--|:--|:--|
| 1 | Carátula | Institución que titula | ~~¿Cuál es la institución?~~ **Resuelto:** UNIVERSIDAD AUTÓNOMA DEL BENI "JOSÉ BALLIVIÁN" / ALSIE CONSULTORES PEDAGÓGICOS (carátula del IFI) |
| 2 | Carátula | Mes y año de presentación | ~~¿Mes y año?~~ **Resuelto el 5 nov 2026:** **Noviembre de 2026** |
| 3 | Carátula | Ciudad y país | ~~¿Ciudad y país?~~ **Resuelto:** Cochabamba, Bolivia |
| 4 | Agradecimientos | Texto o decisión de omitir | ~~¿Incluye agradecimientos?~~ **Resuelto:** texto redactado y volcado (apartado 2) |
| 5 | Dedicatoria | Texto o decisión de omitir | ~~¿Incluye dedicatoria?~~ **Resuelto:** texto redactado y volcado (apartado 3) |
| 6 | Hipótesis | Validación de la formulación | ~~¿Confirma la formulación?~~ **Resuelto el 30 oct (`DEC-127`):** confirmada sin ajustes; se conserva `[PROVISIONAL]` solo por los principios de `E10` |
| 7 | Aporte teórico | Confirmación de formulación | ~~¿Confirma?~~ **Resuelto el 30 oct (`DEC-127`):** confirmado tal como está escrito; redacción definitiva en forma CIMO pendiente de `E10` |
| 8 | Significación práctica | Confirmación de formulación | ~~¿Confirma?~~ **Resuelto el 30 oct (`DEC-127`):** confirmada; la magnitud depende de `E8` |
| 9 | Población y muestra | Número exacto de evaluadores en E8 | ~~¿Cuántos verificadores?~~ **Resuelto el 5 nov 2026:** **dos verificadores ajenos, ambos técnicos de ENDE que no participaron del estudio**, confirmados por la tesista |
| 10 | Capítulo IV | Estructura oficial con autor | ~~¿Qué estructura oficial asume?~~ **Resuelto el 5 nov 2026:** **DSRM de Peffers et al. (2007)**, confirmado por la tesista (volcado en §10.2) |
| 11 | Capítulo III | Gráfico del modelo teórico | ~~¿Desea que lo convierta a figura APA 7?~~ **Resuelto el 5 nov 2026:** sí —convertido a **figura APA 7** (número, título en cursiva arriba del gráfico y nota abajo) en §9.4 del IFI; el diagrama en bloque Mermaid se conserva como gráfico renderizable dentro de la figura. |
| 12 | Evaluación | Resultados de E8 (formativa, rediseño, sumativa) | **Estado al 5 nov:** `E8` **en curso desde el 5 nov** (respuesta 1 = (b)); muestra medida; dos verificadores ajenos confirmados; **formativa por simulación con datos ya disponibles, sin ir a terreno** (decisión de la tesista, `00_estado.md`); **§6 de `08_evaluacion.md` volcó los resultados preliminares**: criterio 1 medido en **0 de 19 (0 %)**, criterio 2 medido en **1 515 de 1 515 (100 % de falsos positivos)** con hallazgo de la formativa declarado tal cual, criterio 3 cumplido (máx 228 ≤ 242), criterio 4 pendiente, verificador ajeno = personal técnico de la oficina de ENDE (dos verificadores, ambos de ENDE). La conclusión del Capítulo IV se redactará cuando las fases se ejecuten. |
| 13 | Estado de etapas | Contradicción `00_estado.md` vs `DEC-142` sobre `E8`, `E9`, `E10` | **Resuelto el 5 nov 2026 (respuesta 1 = (b)) y en la fuente:** las tres etapas **siguen abiertas** —hoy **en curso**, iniciadas el 5 nov—, en concordancia con `DEC-142(6)`. La fila que las marcaba «cerradas por decisión escrita» **ya no existe en `00_estado.md`**: la corrigieron los commits `1acbba0` y `4280905` de esa misma tarde. |

---

## 5. Decisiones de traducción ya tomadas (no requieren consulta)

| Decisión | Fundamento |
|:--|:--|
| Título del IFI = Título fijado DEC-77 (15 palabras, sin siglas) | `guia_ifi_contenido.md` L110-L112 |
| Problema científico = fusión problema diseño + problema investigación (Fórmula 6.1) | `guia_ifi_contenido.md` L208-L210; `indicadores_revision_ifi.md` L61-L62 |
| Objeto de estudio = "gestión de la detección de lecturas anómalas no declaradas en ciclos de lecturación-facturación regulados" (resignificación inversa) | Fórmula 6.2; `indicadores_revision_ifi.md` L63-L64 |
| Campo de acción = criterios y relaciones de priorización (impacto de cambio y riesgo de falla) en contexto regulado | Fórmula 6.3; `indicadores_revision_ifi.md` L71-L72 |
| Objetivos específicos = uno por capítulo (Diagnóstico, Marco teórico, Modelo, Propuesta) | Fórmula 6.4; `indicadores_revision_ifi.md` L69-L70 |
| Hipótesis = desde principios de diseño validados (Fórmula 6.5) | `indicadores_revision_ifi.md` L73-L80 |
| Aporte teórico = principios como conocimiento (conceptos, relaciones, regularidades) | Fórmula 6.6; `indicadores_revision_ifi.md` L81-L82 |
| Significación práctica = utilidad concreta + vínculo teórico-práctico | Fórmula 6.7; `indicadores_revision_ifi.md` L83-L86 |
| Métodos reclasificados en teóricos/empíricos/técnicas | Fórmula 6.8; `indicadores_revision_ifi.md` L87-L90 |
| Población = 29 750 cuentas (regional ENDE); muestra = 19 reclamos procedentes con lectura (ventana 9 meses 2026) + verificadores ajenos | Fórmula 6.9; `08_evaluacion.md` §3 |
| Capítulo III (Modelo) = construcción original desde principios y diseño | `guia_ifi_contenido.md` L280-L333; `indicadores_revision_ifi.md` L191-L208 |
| Capítulo IV (Propuesta) = concreción del modelo + estructura oficial con autor | `guia_ifi_contenido.md` L334-L358; `indicadores_revision_ifi.md` L209-L229 |
| Evaluación (ciclos formativa/sumativa) = dentro del Capítulo IV, no capítulo aparte | `guia_ifi_contenido.md` L336; `indicadores_revision_ifi.md` L209-L229 |
| Anexos incluyen: instrumentos (Anexo A), ficha artefacto (Anexo B), este mapeo (Anexo C) | `guia_ifi_contenido.md` L418-L439; `indicadores_revision_ifi.md` L273-L284 |
| Tiempos verbales: Resumen (pasado), Introducción/Marco/Modelo (presente), Métodos/Resultados (pasado) | `guia_ifi_contenido.md` L440-L452 |
| APA 7 obligatorio en todo el documento | Regla 3 del prompt |

---

*Archivo generado como parte del proceso de traducción DS → ALSIE. Se vuelca como Anexo C del IFI y se referencia en el cuerpo con "Ver anexo C".*