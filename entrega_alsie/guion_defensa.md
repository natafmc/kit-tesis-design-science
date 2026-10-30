# Guion de defensa oral — 20 minutos (modelo ALSIE)

> **Documento rector:** `plantillas/presentacion_defensa_alsie.md`.
> **Fuente del contenido:** `entrega_alsie/IFI_ALSIE.md` (IFI ya traducido).
> **Tesis:** *Método de detección y verificación previa a la facturación de lecturas anómalas en distribución eléctrica.*
> **Postulante:** Natalia Fabiola Medrano Cambará · **Tutor:** Luis Roberto Pérez Rios, Ph.D.
> **Fecha:** 29 de octubre de 2026.
> **Advertencia de estado:** el IFI aún tiene apartados parciales o pendientes (`E7d`, `E7e`, `E7f`, `E8`, `E9`, `E10`). Los bloques 10, 11, 12 y 13 del guion dependen de ese material; se marcan `[PENDIENTE]` y **no se rellenan con supuestos**. El resto del guion está completo.

---

## 0. Propósito y criterio de éxito

La defensa **no es un resumen del IFI, es una argumentación priorizada**. El criterio de éxito es doble:

1. Que el tribunal reconstruya, sin leer el documento, la cadena **problema → objeto → campo → objetivo → hipótesis → modelo → propuesta → validación → aporte → conclusiones**.
2. Que quede claro qué **conocimiento** nuevo se aporta —no qué herramienta se construyó— y que está respaldado por evidencia.

**Jerarquía de protagonismo (fija):** el **Modelo teórico** y el **Aporte teórico** son el corazón; la **Propuesta** es su concreción; el **Diagnóstico** y el **Marco teórico** son sustento.

---

## 1. Reglas no negociables

1. **20 minutos máximo.** Ensayar con cronómetro; si un bloque se pasa, se recorta del siguiente.
2. **No se lee.** La diapositiva muestra el dato, la figura o la relación; el postulante habla.
3. **El gráfico del modelo teórico es irrenunciable.** La defensa se detiene en él.
4. **La hipótesis se enuncia completa** y se conecta con la propuesta.
5. **El aporte teórico se expresa como conocimiento**, nunca como "se desarrolló un método".
6. **Cada afirmación de resultado se respalda con un dato** de la validación.
7. **Idioma y tono:** español académico formal, trato de "usted"; sin siglas no aclaradas la primera vez.
8. **Nada de términos de Design Science sin traducir:** se habla de "propuesta", "modelo", "validación"; no de "artefacto", "principio de diseño" ni "evaluación formativa".

---

## 2. Distribución de tiempo y diapositivas

| # | Bloque | Tiempo | Diapositivas | Qué debe quedar claro |
|:--|:--|:--|:--|:--|
| 1 | Portada | — | 1 | Título, postulante, tutor, programa |
| 2 | Apertura: relevancia y problema | 1,5 min | 1 | Por qué importa, a quién afecta, cuánto cuesta |
| 3 | Problema científico, objeto y campo | 2 min | 1–2 | La cadena problema → objeto → campo |
| 4 | Objetivo general, específicos e hipótesis | 2 min | 1–2 | Qué se propone, para qué, y la hipótesis |
| 5 | Diseño metodológico | 1 min | 1 | Métodos y población/muestra |
| 6 | Diagnóstico: línea base y hallazgos | 1,5 min | 1–2 | El estado actual con datos |
| 7 | Marco teórico esencial | 1 min | 1 | Solo lo que fundamenta el modelo, con toma de posición |
| 8 | **Modelo teórico (corazón)** | **3,5 min** | 2 | Gráfico + componentes + relaciones |
| 9 | Propuesta (concreción del modelo) | 2 min | 1–2 | Estructura oficial con autor y concreción del modelo |
| 10 | Demostración breve | 1,5 min | 1 | La propuesta aplicada en el caso real |
| 11 | Validación y resultados | 1,5 min | 1 | Evidencia de que resuelve el problema |
| 12 | Aporte teórico y significación práctica | 1,5 min | 1 | El conocimiento nuevo y su utilidad |
| 13 | Conclusiones y recomendaciones | 1 min | 1 | Resultados por objetivo |
| 14 | Cierre | — | 1 | Agradecimiento y apertura a preguntas |
| **Total** | | **20 min** | **≈ 16** | |

---

## 3. Mapa defensa ↔ IFI ↔ `tesis_ds/`

| Bloque | Apartado del IFI | Fuente en `tesis_ds/` |
|:--|:--|:--|
| Apertura | Introducción (contexto) | `01_areas_y_temas.md`, `06_diagnostico.md` |
| Problema, objeto y campo | Introducción (§6.1–§6.3) | `02_delimitacion.md`, `03_perfil_ds.md` |
| Objetivos e hipótesis | Introducción (§6.4–§6.6) | `03_perfil_ds.md`, `10_contribucion_conclusiones.md` |
| Diseño metodológico | Introducción (§6.9–§6.10) | `06_diagnostico.md`, `08_evaluacion.md` |
| Diagnóstico | Capítulo I | `06_diagnostico.md` |
| Marco teórico esencial | Capítulo II | `04_marco_teorico.md`, `05_estado_del_arte.md` |
| Modelo teórico | Capítulo III | `07c_diseno_artefacto.md`, `07b_requisitos.md` |
| Propuesta | Capítulo IV | `07a_alternativas.md`, `07c_diseno_artefacto.md` |
| Demostración breve | Capítulo IV (metodología) | `07f_ficha_artefacto.md`, `09_enlace_solucion.md` |
| Validación y resultados | Capítulo IV (validación) y Conclusiones | `08_evaluacion.md`, `09_enlace_solucion.md` |
| Aporte y significación | Introducción (§6.7–§6.8) | `10_contribucion_conclusiones.md` |
| Conclusiones y recomendaciones | Conclusiones y Recomendaciones | `10_contribucion_conclusiones.md` |

---

## 4. Guion por bloque

### Bloque 1 — Portada (diapositiva 1)

**Muestra:** título, postulante, tutor, programa, institución, mes y año.

---

### Bloque 2 — Apertura: relevancia y problema (1,5 min · diapositiva 2)

**Qué decir:** una oración que sitúe el problema y cuantifique su costo.

> [En la regional que estudio, de 29 750 cuentas, solo el 0,88 % de las lecturas facturables lleva un código de irregularidad. El 99,12 % restante no se barre en ningún momento. La detección que existe es manual, no está escrita y depende de una sola persona. El costo se mide en reclamos: 1 053 en 57 meses, de los cuales 174 fueron procedentes y 136 —el 78,16 %— provinieron de lecturas sin código, es decir, de anomalías que nadie advirtió y que el usuario reclamó después de facturar.]

**Qué mostrar:** las cifras de impacto (0,88 % · 99,12 % · 1 053 · 174 · 136).

**Qué evitar:** la historia de la empresa, el organigrama, el repaso tecnológico.

---

### Bloque 3 — Problema científico, objeto y campo (2 min · diapositivas 3–4)

**Qué decir:** la cadena encadenada.

> [La situación real es que las lecturas con consumo incoherente que no fueron marcadas no se detectan antes de facturar, y eso genera reclamos y desplazamientos. La brecha de conocimiento es que la literatura sabe puntuar una lectura y sabe que hay que priorizar inspecciones, pero no documenta cómo convertir esa puntuación en una decisión operativa dentro de un ciclo de lecturación-facturación sujeto a un catálogo regulatorio. De esa brecha se deriva el objeto —la detección y verificación de lecturas anómalas en el ciclo de lecturación y facturación— y, de él, el campo de acción: la segmentación, el criterio escrito, la priorización bajo capacidad, la agrupación por ruta, la explicación y el registro.]

**Qué mostrar:** un diagrama de tres viñetas encadenadas: problema → objeto → campo.

**Qué evitar:** enunciar el objeto sin conectarlo con el problema; confundir el objeto (área del conocimiento) con la propuesta (el método).

---

### Bloque 4 — Objetivos e hipótesis (2 min · diapositivas 5–6)

**Qué decir:** objetivo general, objetivos específicos (uno por capítulo) y la hipótesis completa.

> [El objetivo general es diseñar, construir y evaluar un método de detección y verificación previa a la facturación de lecturas anómalas no declaradas, y articular los principios de diseño que de su aplicación se desprenden. Los objetivos específicos son uno por capítulo: diagnosticar, sistematizar los fundamentos, modelar y elaborar y validar la propuesta.]

**Hipótesis (destacada):**

> *Si se aplica un método de detección y verificación que compara el consumo de cada cuenta contra su propio ciclo anual —el mismo mes de los cuatro años anteriores—, con un umbral escrito y calibrado contra un techo de capacidad, y que emite sus alertas agrupadas por ruta con la comparación que las originó, entonces se identifican lecturas anómalas no declaradas que hoy no se detectan, sin exceder la capacidad del equipo de verificación, porque concentra el esfuerzo en las cuentas cuya desviación respecto de su propio patrón estacional es mayor y devuelve al verificador la evidencia necesaria para aceptar o descartar cada alerta.*

**Qué mostrar:** la hipótesis con la flecha "si se propone X con características Y, entonces se logra Z, porque M".

**Qué evitar:** objetivos redactados como tareas; una hipótesis sin mecanismo.

*[PENDIENTE — validación: la hipótesis es provisional hasta que cierre E10.]*

---

### Bloque 5 — Diseño metodológico (1 min · diapositiva 7)

**Qué decir:** qué métodos se usaron y para qué objetivo; población y muestra en una línea.

**Qué mostrar:** tabla compacta método → objetivo específico.

| Método | Objetivo específico |
|:--|:--|
| Análisis de bases de datos, observación | I. Diagnóstico |
| Revisión bibliográfica con protocolo, análisis-síntesis | II. Marco teórico |
| Modelación, sistémico | III. Modelo teórico |
| Entrevista, estudio de caso, calibración | IV. Propuesta y validación |

**Población y muestra:** 29 750 cuentas; selección analítica (caso representativo de la clase de contextos).

**Qué evitar:** enumerar métodos sin propósito; detallar instrumentos (van al diagnóstico).

---

### Bloque 6 — Diagnóstico (1,5 min · diapositiva 8)

**Qué decir:** la línea base con sus indicadores y las regularidades.

> [El diagnóstico midió tres cosas. Primero, la magnitud: el 99,12 % del facturable circula sin código. Segundo, el costo: de 174 reclamos procedentes, 136 vinieron de lecturas sin código. Tercero, la carga: 242,2 correcciones manuales por mes, que equivalen a unas 11 visitas diarias y fijan el techo de capacidad. La regularidad central es que el código de irregularidad es una señal de riesgo —31,3 veces la tasa de procedencia por lectura— pero no un ámbito de trabajo, porque la mayoría de los procedentes no lo lleva.]

**Qué mostrar:** tabla de línea base (Indicadores 1–3).

**Qué evitar:** narrar cómo se aplicó cada instrumento; repetir el mismo dato en tabla y figura.

---

### Bloque 7 — Marco teórico esencial (1 min · diapositiva 9)

**Qué decir:** solo las teorías que sustentan el modelo, con la toma de posición.

> [El marco se apoya en cuatro decisiones. La anomalía es contextual, no de punto: un consumo solo lo es respecto de su estación y su cuenta. Bajo desequilibrio de clases, la métrica correcta es precisión-exhaustividad, no exactitud. La capacidad de verificación no es una comodidad, es el criterio de viabilidad. Y una alerta que no se explica no se adopta. De ahí salen los componentes del modelo.]

**Qué mostrar:** mapa mínimo "teoría → componente del modelo".

**Qué evitar:** el listado de autores sin valoración.

---

### Bloque 8 — Modelo teórico (3,5 min · diapositivas 10–11) — el corazón

**Diapositiva 10a — Estructura del modelo.**

**Qué decir:** la fundamentación breve, luego los componentes, luego las relaciones.

> [El modelo tiene cinco componentes: depuración, segmentación, detección, verificación y resolución y registro. La relación esencial es un ciclo: la depuración precede a la segmentación y a la detección; la detección produce alertas con su explicación; la verificación las confirma o descarta; y el registro alimenta el ciclo siguiente. El techo de capacidad limita el volumen de la detección, y la agrupación por ruta organiza la salida.]

**Qué mostrar:** **el gráfico del modelo**, grande y legible (la figura del Capítulo III).

**Diapositiva 10b — Explicación.**

> [La relación nueva que el estudio aporta es que la comparación contra el propio ciclo anual de la cuenta resuelve la estacionalidad sin fuente externa, y que la capacidad opera como techo de viabilidad y no como preferencia. El orden depuración → segmentación → detección no es arbitrario: es el único que evita clasificar celdas que después se excluyen.]

**Qué evitar:** saltarse el gráfico; describir el modelo sin mostrarlo; confundirlo con la herramienta.

*[PENDIENTE — validación: los componentes y relaciones son provisionales hasta que cierre E10.]*

---

### Bloque 9 — Propuesta (2 min · diapositivas 12–13)

**Qué decir:** la definición asumida, la estructura oficial con autor y cómo concreta el modelo.

> [La propuesta es un método: pasos, roles, entradas, salidas, precondiciones y productos de trabajo. Se elabora sobre la estructura de proceso del DSRM de Peffers et al. (2007). Cada componente del modelo se materializa en un paso: la depuración, la segmentación por perfil y familia de código, la detección contra el ciclo anual con umbral calibrado, la verificación con explicación y la resolución con registro.]

**Qué mostrar:** la traza "componente del modelo → elemento de la propuesta".

**Qué evitar:** describir la propuesta sin anclarla al modelo; detalles técnicos de implementación.

*[PENDIENTE — confirmar la estructura oficial con autor (§10.2 del IFI).]*

---

### Bloque 10 — Demostración breve (1,5 min · diapositiva 14)

**Tipología de la propuesta: método.** La demostración es la **aplicación del método en el caso real** (la exemplar): mostrar los pasos ejecutados y el producto de trabajo resultante.

**Qué decir:**

> [Apliqué el método sobre el panel de consumo real: 1 485 556 celdas, 30 411 cuentas, 57 meses. La depuración excluyó 541 celdas de 411 cuentas. La segmentación asignó a cada cuenta su perfil y su familia de código. La detección calculó la desviación contra el ciclo anual y produjo el listado de alertas agrupadas por ruta, con la comparación que originó cada una.]

**Qué mostrar:** el producto de trabajo —el listado de alertas agrupadas por ruta con su explicación— y los pasos ejecutados.

**Qué evitar:** describir de nuevo el diseño; una sola función o un solo caso, preparado de antemano.

*[PENDIENTE — E7f/E8: la exemplar y su producto de trabajo se producirán en esas etapas.]*

---

### Bloque 11 — Validación y resultados (1,5 min · diapositiva 15)

**Qué decir:** cómo se puso a prueba la propuesta y qué datos confirman que resuelve el problema; la comparación línea base → resultado.

**Qué mostrar:** tabla de resultados con los indicadores de éxito, antes y después.

| Indicador | Línea base | Resultado |
|:--|:--|:--|
| Cobertura retrospectiva de reclamos procedentes | 136 de 174 (78,16 %) sin código | *[pendiente E8]* |
| Falsos positivos | sin criterio actual | *[pendiente de la calibración de θ]* |
| Carga de verificación | 242,2 correcciones/mes | ≤ 242 alertas/mes (techo) |
| Aplicabilidad | sin procedimiento escrito | 100 % de las alertas de la muestra (umbral fijado) |

**Qué evitar:** afirmar éxito sin dato; confundir "el método se aplica" con "resuelve el problema".

*[PENDIENTE — E8: los resultados de la validación se producirán en esa etapa.]*

---

### Bloque 12 — Aporte teórico y significación práctica (1,5 min · diapositiva 16)

**Qué decir:** el aporte como conocimiento nuevo y su utilidad concreta, con el vínculo entre ambos.

> [El aporte no es el método, sino la formalización de la detección como un proceso con componentes y relaciones explícitas, y las regularidades que explican el comportamiento del objeto: que la comparación contra el propio ciclo anual resuelve la estacionalidad sin fuente externa; que la capacidad opera como techo de viabilidad; y que la explicabilidad de la alerta es condición de su adopción. La significación práctica es que la distribuidora puede incorporar detección sistemática sin ampliar su equipo de verificación.]

**Qué mostrar:** la regularidad formulada, con su contexto y su mecanismo.

**Qué evitar:** presentar el método como si fuera el aporte; inflar la generalización.

*[PENDIENTE — E10: el aporte definitivo se redactará con los principios de diseño.]*

---

### Bloque 13 — Conclusiones y recomendaciones (1 min · diapositiva 17)

**Qué decir:** una conclusión por objetivo específico, en términos de resultados; una recomendación viable.

**Qué mostrar:** lista numerada que mapee objetivo → resultado.

*[PENDIENTE — E8/E10: las conclusiones y recomendaciones se redactarán al cerrar esas etapas.]*

**Qué evitar:** conclusiones en términos de sugerencias; recomendaciones inviables.

---

### Bloque 14 — Cierre (diapositiva 18)

**Muestra:** agradecimiento y apertura a preguntas.

---

## 5. Demostración breve del artefacto o propuesta

La demostración **no reemplaza a la validación**: muestra que la propuesta es aplicable; la validación muestra que resuelve el problema. Como la propuesta es un **método**, la demostración es la **aplicación del método en el caso real** (la exemplar): mostrar los pasos ejecutados y el producto de trabajo resultante.

**Reglas:** una sola función o un solo caso, preparada de antemano, con respaldo por si falla la conexión en vivo. Si la propuesta no es software, la "demostración" es la exemplar de aplicación, no una excusa para describir de nuevo el diseño.

---

## 6. Priorización y errores que penaliza el tribunal

### Irrenunciable (nunca se corta)

1. La cadena problema → objeto → campo → objetivo.
2. La hipótesis completa, con su mecanismo.
3. El gráfico del modelo teórico y su explicación.
4. El aporte teórico formulado como conocimiento.
5. Al menos un dato de la validación que respalde la solución.
6. Las conclusiones en términos de resultados.

### Se corta si el tiempo aprieta (en este orden)

1. El detalle histórico del contexto (Bloque 2).
2. La enumeración de métodos sin propósito (Bloque 5).
3. La lista de autores del marco (Bloque 7) — se conserva solo la toma de posición.
4. El detalle de construcción de la propuesta (Bloque 9).
5. La segunda figura del diagnóstico, si una tabla ya lo muestra.

### Errores que el tribunal penaliza

1. Empezar por la tecnología en lugar del problema.
2. Confundir el objeto de estudio con la propuesta.
3. No mostrar el gráfico del modelo, o mostrarlo ilegible.
4. Presentar el método como si fuera el aporte teórico.
5. Afirmar éxito sin dato de validación.
6. Leer las diapositivas palabra por palabra.
7. Pasarse del tiempo y no dejar margen para las preguntas.
8. Usar términos de Design Science ("artefacto", "principio de diseño").
9. Conclusiones redactadas como sugerencias.
10. Recomendaciones inviables o desconectadas de las conclusiones.

---

## 7. Lista de verificación previa a la defensa

- [ ] La presentación suma 20 minutos o menos, medida con cronómetro.
- [ ] El gráfico del modelo teórico es legible desde el fondo de la sala.
- [ ] La hipótesis aparece completa y vinculada a la propuesta.
- [ ] El aporte teórico está redactado como conocimiento, no como herramienta.
- [ ] Cada resultado citado tiene su dato de validación a la vista.
- [ ] Las relaciones esenciales se ven en la secuencia de diapositivas.
- [ ] No queda ningún término de Design Science sin traducir.
- [ ] La demostración tiene respaldo (captura o video).
- [ ] Las conclusiones son resultados por objetivo, no sugerencias.
- [ ] El número de diapositivas está entre 14 y 16.
- [ ] La portada y el cierre incluyen los datos institucionales.

---

## 8. Diapositivas redactadas (adaptadas a esta tesis)

### Diapositiva 2 — Apertura (1,5 min)

**Título:** Detección de lecturas anómalas antes de facturar

- Regional de 29 750 cuentas; 1 389 941 lecturas facturables en 57 meses.
- Solo el **0,88 %** lleva código de irregularidad; el **99,12 %** no se barre.
- **1 053** reclamos; **174** procedentes; **136 (78,16 %)** de lecturas sin código.

> [En la regional que estudio, la marca de irregularidad cubre menos del uno por ciento del facturable y el resto no se recorre. La detección que existe es manual y depende de una sola persona. El costo se mide en reclamos que llegan después de facturar.]

### Diapositiva 3 — Problema, objeto y campo (2 min)

**Título:** Problema científico, objeto de estudio y campo de acción

- **Problema:** las lecturas con consumo incoherente no marcadas no se detectan antes de facturar; la detección manual no está escrita ni tiene umbral.
- **Objeto:** la detección y verificación de lecturas anómalas en el ciclo de lecturación y facturación.
- **Campo:** segmentación, criterio escrito, priorización bajo capacidad, agrupación por ruta, explicación y registro.

> [La brecha es que la literatura sabe puntuar una lectura y sabe que hay que priorizar, pero no documenta cómo convertir esa puntuación en una decisión operativa dentro de un ciclo regulado. De esa brecha se derivan el objeto y el campo.]

### Diapositiva 5 — Objetivos e hipótesis (2 min)

**Título:** Objetivo e hipótesis

- **Objetivo general:** diseñar, construir y evaluar un método de detección y verificación previa a la facturación de lecturas anómalas no declaradas, y articular los principios de diseño que de su aplicación se desprenden.
- **Hipótesis:** *Si se aplica un método que compara el consumo de cada cuenta contra su propio ciclo anual, con un umbral escrito y calibrado contra un techo de capacidad, y que emite alertas agrupadas por ruta con su comparación, entonces se identifican lecturas anómalas no declaradas sin exceder la capacidad del equipo, porque concentra el esfuerzo en las mayores desviaciones y devuelve al verificador la evidencia para decidir.*

### Diapositiva 8 — Diagnóstico (1,5 min)

**Título:** Diagnóstico: línea base

| Indicador | Valor (57 meses) |
|:--|:--|
| Lecturas sin código sobre el facturable | 99,12 % |
| Reclamos procedentes sin código | 136 de 174 (78,16 %) |
| Razón de tasas con/sin código | 31,3 × |
| Correcciones manuales mensuales | 242,2 (≈ 11 visitas/día) |

> [El código es una señal de riesgo de alta potencia, pero no un ámbito de trabajo: la mayoría de los procedentes no lo lleva. La capacidad de verificación es un límite real.]

### Diapositiva 10 — Modelo teórico (3,5 min, dos diapositivas)

**Diapositiva 10a — Estructura del modelo**

**Título:** Modelo teórico: componentes y relaciones

- **Componentes:** depuración · segmentación · detección · verificación · resolución y registro.
- **Relación esencial:** ciclo con retroalimentación; el techo de capacidad limita la detección.

*(Gráfico del modelo en bloque, grande y legible.)*

**Diapositiva 10b — Explicación**

> [La comparación contra el propio ciclo anual resuelve la estacionalidad sin fuente externa. La capacidad opera como techo de viabilidad. El orden depuración → segmentación → detección es el único que evita clasificar celdas que después se excluyen.]

### Diapositiva 12 — Propuesta (2 min)

**Título:** Propuesta: el método como concreción del modelo

- **Definición:** método (pasos, roles, entradas, salidas, precondiciones, productos).
- **Estructura oficial:** DSRM de Peffers et al. (2007).
- **Traza:** cada componente del modelo → un paso del método.

### Diapositiva 14 — Demostración breve (1,5 min)

**Título:** Aplicación del método en el caso real

- Panel: 1 485 556 celdas · 30 411 cuentas · 57 meses.
- Depuración: 541 celdas de 411 cuentas excluidas.
- Producto: listado de alertas agrupadas por ruta con su explicación.

> [Apliqué el método sobre el panel real y obtuve el listado de alertas agrupadas por ruta, cada una con la comparación que la originó.]

### Diapositiva 15 — Validación y resultados (1,5 min)

**Título:** Validación: línea base frente a resultado

| Indicador | Línea base | Resultado |
|:--|:--|:--|
| Cobertura retrospectiva | 136 de 174 sin código | *[pendiente E8]* |
| Falsos positivos | sin criterio actual | *[pendiente de θ]* |
| Carga de verificación | 242,2/mes | ≤ 242 alertas/mes |
| Aplicabilidad | sin procedimiento | 100 % de las alertas de la muestra |

### Diapositiva 16 — Aporte y significación práctica (1,5 min)

**Título:** Aporte teórico y significación práctica

- **Aporte:** la formalización de la detección como proceso con componentes y relaciones, y las regularidades que explican el comportamiento del objeto.
- **Significación práctica:** incorporar detección sistemática sin ampliar el equipo de verificación.

> [El aporte no es el método, sino las relaciones que explican por qué funciona y que antes no estaban documentadas para este tipo de contexto.]

### Diapositiva 17 — Conclusiones (1 min)

**Título:** Conclusiones

*[PENDIENTE — E8/E10: una conclusión por objetivo específico, en términos de resultados.]*

---

*Guion generado por el agente `traductor-alsie` el 29 de octubre de 2026 a partir de `entrega_alsie/IFI_ALSIE.md`. Los bloques 10 a 13 dependen de etapas aún abiertas y se completarán al cerrar `E7f`, `E8` y `E10`.*
