# Informe Final de Investigación — maestría (modelo ALSIE)

> **Fuente de la estructura:** `instituciones/alsie/guia_ifi_contenido.md` — los **14 apartados** y sus reglas. Criterios de evaluación en `instituciones/alsie/indicadores_revision_ifi.md`.
> **Estado, 27 oct 2026 (DEC-77):** **2 de 14 apartados escritos** — **1. Carátula** y **4. Resumen**. Los 12 restantes esperan a **E7c**, según `DEC-76` `Q4` = (c): *alternar, no bloque*.
> **Regla de este documento:** ningún dato entra sin estar dictado o sin su fuente. Lo que falta se marca **`[POR VERIFICAR]`** y no se rellena.

---

## 1. Carátula

**Escrita el 27 oct 2026 con datos dictados por la tesista (`DEC-77`). El logo se inserta en el maquetado final.**

| | |
|:--|:--|
| **Institución que titula** | UNIVERSIDAD AUTÓNOMA DEL BENI "JOSÉ BALLIVIÁN" / ALSIE CONSULTORES PEDAGÓGICOS |
| **Logo** | _Se inserta en el maquetado final._ |
| **Título del trabajo** | **Método de detección y verificación previa a la facturación de lecturas anómalas en distribución eléctrica** |
| **Modalidad y nivel** | Tesis de maestría para optar al grado de Magíster en Ingeniería de Software |
| **Postulante** | Natalia Fabiola Medrano Cambará |
| **Tutor** | Luis Roberto Pérez Rios, Ph.D. |
| **Mes y año de presentación** | Octubre de 2026 |
| **Ciudad y país** | Cochabamba, Bolivia |

**Control del título — las dos reglas que el anterior incumplía, ahora cerradas:**

| Regla de la guía | Título anterior | Título fijado |
|:--|:--|:--|
| **máximo 15 palabras** (regla 9) | **24** — reprobaba | **15** — pasa |
| **sin siglas** (regla 8) | contenía **`ENDE`** | **ninguna** |
| **no una sola palabra** (regla 10) | cumplía | cumple |

> **Tres títulos distintos convivían en el repositorio** —`00_estado.md`, `03_perfil_ds.md` y `propuesta_borrador_v1.md`— y **los tres reprobaban las mismas dos reglas**. **La guía dice que las características «aplican para todos los títulos del trabajo»**, de modo que con `DEC-77` los tres pasaron al título fijado.

---

## 2. Agradecimientos

**`[POR VERIFICAR]` — pendiente de redacción; la decisión de incluirlo ya está tomada (`DEC-85`, `Q2` = (c)).** *Guía:* apartado propio, sin regla de extensión. **Tres reglas al redactar:** **L122** —agradecer *«cualquier ayuda importante recibida de cualquier persona»*— · **L126** —*«No hay nada que sea realmente científico en esta sección»*— · **L130** —evitar la palabra **«deseo»**, que *«en muchas ocasiones es superflua y expresa un sentido negativo»*—. **Sin decidir: a quién se agradece y si aparece el nombre de la empresa** —la prohibición de nombrarla es del **resumen** (`DEC-77`), y la guía no la extiende a este apartado, **pero eso tampoco la autoriza**—.

---

## 3. Dedicatoria

**RECTIFICADO EL 28 OCT 2026 (`DEC-92`): SE INCLUYE — HABRÁ DEDICATORIA.**

**Lo que había decidido `DEC-85` el 27 oct era exactamente lo contrario: su titular es literal *«NO SE INCLUYE».*** Lo revirtió la tesista el 28 oct —*«mantener el apartado, ya no omitirlo, se hará la dedicatoria»*—, de modo que **queda anulada la negativa de `DEC-85` punto 1 y se mantiene todo lo demás de esa decisión.**

**Y con esto se cierra la pregunta de numeración que `DEC-85` dejó abierta, y por una tercera vía que allí no estaba planteada:** la guía lista **14 apartados numerados —L19 a L47—** y la dedicatoria es el **3**; **como se incluye, los 14 se conservan y NINGUNO se marca como *omitido*.** *Quedan descartadas las dos opciones de `DEC-85` por igual: ni «14 con el 3 omitido» ni «renumerar a 13».*

**El índice no se ve afectado:** arranca **a partir de la Introducción** —guía L186—, o sea en el apartado 6, **y `indicadores_revision_ifi.md` L49 lo confirma: el índice no incluye Resumen, Agradecimientos ni Dedicatoria.**

**Reglas que trae al redactarse, tal como están en la guía — L134 a L148:** es **homenaje a personas o instituciones que colaboraron significativamente con la realización del estudio** —L134— · **se dirige a quienes colaboraron con el estudio** —L138— · **suelen ser breves** —L140— · **generalmente se escriben en primera persona** —L144— · **deben caracterizarse por la seriedad del texto** —L146— · **no deben ser demasiado emotivas ni sentimentales** —L148—. **Y L142 —«su presencia no es de carácter obligatorio»— es justamente lo que hace de esto una decisión y no una obligación, en las dos direcciones: se pudo omitir y se pudo incluir.**

*Pendiente: la redacción, que es suya.*

---

## 4. Resumen

**Escrito el 27 oct 2026 (`DEC-77`, `Q4` = (a)).** **241 palabras** —el tope es 250—, **un solo párrafo**, **tiempo pasado y voz pasiva**, **sin siglas**, **sin tablas ni fórmulas**, ubicado **justamente antes del índice**.

> Se estudió la detección de lecturas con consumo atípico previa a la facturación en la distribución de energía eléctrica, con el propósito de sustituir la revisión reactiva por una detección sistemática que no excediera la capacidad del equipo de verificación. Se analizó el histórico de lecturación de una empresa distribuidora nacional correspondiente a los 57 meses comprendidos entre enero de 2022 y septiembre de 2026, y se revisó la literatura sobre detección de anomalías en consumo eléctrico. Se constató que el 0,88 % de las lecturas facturables, esto es 12 300 de 1 389 941 registros, fue marcado con un código de irregularidad, y que la oficina de atención al consumidor recibió 1 053 reclamos en el mismo periodo, de los cuales 174 resultaron procedentes y 136 correspondieron a lecturas marcadas sin código; la revisión bibliográfica no arrojó evidencia de su aplicación previa a la facturación en la literatura consultada. Sobre esa evidencia se propuso un método de detección y verificación previa a la facturación, entendido como artefacto de tipo método, diseñado para operar sobre un panel de consumo con una fila por cuenta y mes, agrupado por ruta de lecturación, y para el que se fijó un procedimiento de calibración del umbral contra el techo de capacidad de 242 alertas mensuales. Se concluyó que era viable incorporar detección sistemática al ciclo de lecturación sin ampliar el equipo de verificación, y quedó pendiente la evaluación del método sobre el histórico completo.

**Cuatro reglas de contenido que se comprueban una por una:**

| Regla | Cómo se cumple |
|:--|:--|
| **1. Objetivos** | *«con el propósito de sustituir la revisión reactiva por una detección sistemática…»* |
| **2. Metodología** | análisis de 57 meses de histórico + revisión de literatura |
| **3. Resultados** | 0,88 % · 12 300 de 1 389 941 · 1 053 reclamos · 174 procedentes · 136 sin código · 0 evidencia previa |
| **4. Conclusiones** | viabilidad sin ampliar el equipo; **evaluación declarada pendiente** (`DEC-77`, `Q4` = (a)) |

> **Sin siglas, a propósito:** ni la empresa distribuidora ni la oficina de consumidor se nombran —la regla 8 lo prohíbe—. **`ENDE` y `ODECO` no aparecen.** Las cifras del problema quedan escritas por su valor, no por su sigla.

**Trazabilidad de las cifras — `DEC-13`: ningún número entra a un documento sin su consulta y su fuente.**

| Cifra del resumen | De dónde sale o cómo se calculó | Comprobación |
|:--|:--|--:|
| **0,88 %** | 12 300 ÷ 1 389 941 | **0,8849 %** → redondea a **0,88** ✓ |
| **12 300** | registros con código de irregularidad, ene 2022 – sep 2026 | `06_diagnostico.md` L17 |
| **1 389 941** | lecturas facturables tipo 1 en 57 meses | `06_diagnostico.md` L72 |
| **57 meses** | ene 2022 a sep 2026 **inclusive**: 48 (2022–2025) + 9 (ene–sep 2026) | **57** ✓ |
| **1 053** | reclamos tramitados por la oficina de consumidor en 57 meses | `06_diagnostico.md` L57 |
| **174** | reclamos procedentes | 174 ÷ 1 053 = **16,52 %** ✓ |
| **136** | de los 174, correspondientes a lecturas sin código | 136 ÷ 174 = **78,16 %** ✓ |
| **242 alertas** | techo de capacidad: 242 correcciones/mes ÷ 22 días hábiles ≈ 11/día | `DEC-45` · criterio 3 de `02_delimitacion.md` |

> **Advertencia para quien vuelva a verificar esto:** **la cuenta de meses tiene que ser inclusiva.** *Enero de 2022* es el mes 1 y *septiembre de 2026* es el mes **57**; una cuenta que omite un extremo da **56** y es errónea. Lo comprobado por conteo de fechas, no por una resta.

---

## 5. Índice

**`[POR VERIFICAR]` — pendiente.** *Se genera al cerrar el documento.* **Debe salir inmediatamente después del resumen** (guía, regla 11).

---

## 6. Introducción

**`[POR VERIFICAR]` — pendiente.** *Guía:* **máximo 10 % del documento.** *Insumo directo:* `03_perfil_ds.md`. *Tiempos verbales:* **presente**.

---

## 7. Capítulo I. Diagnóstico de la investigación

**`[POR VERIFICAR]` — pendiente.** *Insumo directo:* `06_diagnostico.md`, con las cifras de 57 meses ya verificadas.

---

## 8. Capítulo II. Marco teórico de la investigación

**`[POR VERIFICAR]` — pendiente.** *Insumo directo:* `04_marco_teorico.md`. *Tiempos verbales:* **presente**. *Pendiente abierto:* la atribución de la plantilla de principios de diseño (`DEC-12`, consulta al tutor **sin enviar**).

---

## 9. Capítulo III. Modelo teórico de la investigación

**`[POR VERIFICAR]` — pendiente y SIN INSUMO.** *Guía:* el modelo teórico define la estructura conceptual sobre la que se construye. **No existe todavía**: es el apartado que E7c y la verificación del panel tienen que producir.

**Representación gráfica — DECIDIDA EL 28 OCT 2026 (`DEC-92`): DOS FIGURAS SEPARADAS.** **La primera modela el artefacto** —el objeto de investigación— **y la segunda el proceso de lecturación y facturación** —el campo de acción—, **en ese orden, que es el que fijó `DEC-84`: primero el objeto y después el campo, conforme a `indicadores_revision_ifi.md` L197 y `guia_ifi_contenido.md` L288.** **Con esto se cierra el ítem (i) que `DEC-84` dejó abierto en su punto 7 —dos figuras o una con dos capas—.**

**Dos vigilancias que `DEC-84` puso y siguen vivas:** la guía exige **«representación gráfica de los componentes y relaciones esenciales»** —L320— y **«se debe representar gráficamente la estructura que se modela»** —L290—, **y dos figuras cumplen eso solo si cada una es una estructura y no un diagrama de flujo**; **y la salvedad del punto 3 de `DEC-84` no cambia: si el bloque del proceso termina siendo un recuento de tablas, está duplicado contra el Capítulo I y hay que recortarlo.**

*Siguen sin decidir, según `DEC-84(7)`: la **fundamentación epistemológica** y la **«ley fundamental de la profesión»** —L318—, y **si el capítulo se redacta antes o después de E7c**.*

---

## 10. Capítulo IV. Propuesta de la investigación

**`[POR VERIFICAR]` — pendiente.** *Insumos:* `propuesta_borrador_v1.md` (§1 a §12), `07a_alternativas.md` (gate cerrado) y `07b_requisitos.md` (R1–R10, gate **2 de 4**).

---

## 11. Conclusiones

**`[POR VERIFICAR]` — pendiente.** *Regla dura:* **al menos una conclusión por capítulo**, es decir **mínimo seis** —introducción y los cuatro capítulos más, según cuente—. **No se redactan hasta que existan resultados.**

---

## 12. Recomendaciones

**`[POR VERIFICAR]` — pendiente.** *Se deriva de cada conclusión.*

---

## 13. Referencias bibliográficas

**`[POR VERIFICAR]` — pendiente.** *Insumo:* §8 y §9 de `propuesta_borrador_v1.md` —**21 referencias comprobadas contra Crossref por DOI el 2 oct 2026** y 1 en AISeL—. *Regla:* **doble correspondencia** —toda cita en el texto tiene su entrada y toda entrada está citada—.

---

## 14. Anexos

**`[POR VERIFICAR]` — pendiente.** *Regla:* **numerados en orden ascendente** y en el orden en que se citan.

---

**Registro de decisiones:** `DEC-76` (`Q4` = (c), vía de avance del IFI) · `DEC-77` (datos de carátula, título fijado, redacción de la modalidad, alcance del resumen).
