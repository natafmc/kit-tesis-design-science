# E7c — Diseño del artefacto

> **Estado:** en curso — abierta el 28 oct 2026 (`DEC-87`).
> **Suerte de artefacto:** método, con instanciación de apoyo *exemplar* (`DEC-70`, punto 2).
> **Abre con el gate de E7b en 3 de 4** — es el segundo paso previo del punto 3, el de `θ`.
> **Qué es esta etapa:** diseña. **No construye** —construir es `E7d`/`E7e` (`07b_requisitos.md` §4.3).

---

## 1. Por qué esta etapa se abre hoy

Se abrió el 28 oct 2026 por `DEC-87`, y no antes por una sola razón: **el orden estaba mal escrito entre dos archivos.**

`07b_requisitos.md` §4.3 exigía fijar el valor de `θ` con los ocho pasos de su §4.2, y el paso 1 de ese procedimiento dice:

> *Calcular `desviación` para **cada cuenta y cada mes** del panel.*

La fórmula de §4.1 —misma página— es:

```
desviación = abs(consumo_observado − referencia) / referencia
```

**Y nadie había decidido qué es `referencia`.** La decisión estaba puesta en esta etapa desde antes de abrirla: `07a_alternativas.md` **L168** le entrega a E7c

> *«Cómo se calcula la referencia anual con los 57 meses; qué hacer con los huecos de serie; cómo se prueban los segmentos; el tratamiento de la regla de contingencia A1.»*

**La dependencia es unidireccional: `θ` depende de E7c, no al revés.** Ninguno de los cuatro temas de arriba necesita saber el valor de `θ` para resolverse. De modo que **el punto 3 del gate de E7b no podía cerrarse sin esta etapa**, y lo que se corrigió el 28 oct fue el orden, no una regla: la de *fijar los valores antes de construir* se sigue cumpliendo, porque **construir es `E7d`/`E7e` y E7c diseña**.

---

## 2. Insumos

| Insumo | Estado | Dónde está verificado |
|:--|:--|:--|
| **Alternativa elegida: A2 — ciclo anual por cuenta** | cerrado | `07a_alternativas.md` L142 · `DEC-70` |
| **Requisitos R1 a R10** | borrador v1, gate 3 de 4 | `07b_requisitos.md` |
| **Forma de `θ` y procedimiento de calibración** | fijados, sin valor | `07b_requisitos.md` §4.1 y §4.2 — **paso 1 ajustado el 28 oct con `P1` = (a) y `P3` = (b), `DEC-90`** |
| **Referencia: estadístico y alcance** | **decidido** | `DEC-90`: **mediana** · **solo los nueve meses de 2026** · cuatro ciclos previos |
| **Panel de consumo** | verificado | `DEC-80`: 1 485 556 celdas · 30 411 cuentas · 57 meses · 5 619 duplicados colapsados |
| **Cuatro ciclos anuales completos disponibles** | verificado | `AC4` de `A2.3.a` (`DEC-72`): la ventana 2022-01 a 2026-09 contiene 2022, 2023, 2024 y 2025, **de modo que A2 es calculable y la contingencia A1 no se activa por falta de historial** |
| **Cierre de la ventana** | fijado | `DEC-69`: la ventana cierra el 30/9/2026 |
| **Celdas con índice cero** | medidas | `DEC-86`: 38 969 celdas · 8 728 cuentas —28,70 %— · 57 meses · consumo 86,7 veces el del resto |
| **Techo de alertas** | fijado | `DEC-45` y `DEC-54`: ≤ 242 alertas por mes |
| **Ruta de atención** | fijado | `DEC-74` —`CONTROL 6`—; agrupación por ruta, `DEC-57` |
| **Depuración ya declarada como paso del método** | decidido | `DEC-75`, `P4` |
| **Tratamiento de la estacionalidad** | puesto a E7c | `matriz_coherencia.md` L52 y L61 —se la llama *estacionalidad* allí— |

**Condiciones que constriñen el diseño** — están en la base de conocimiento y no se pueden ignorar al decidir: `04_marco_teorico.md` §3.1, §3.3, §3.4, §3.5 y §3.6; y R1.2, R4.4, R7 y R8.1 de `07b_requisitos.md`.

---

## 3. Los seis entregables

Están **asignados antes de abrir la etapa**: tres los pone `07a_alternativas.md` L168, uno lo pone `07b_requisitos.md` L231, uno es `DEC-75` `P4` y uno lo abrió `DEC-81`. **La apertura no inventó ningún criterio: los juntó.**

### 3.1 — Cómo se calcula la referencia anual con los 57 meses

**Fuente:** `07a_alternativas.md` L168 · `07b_requisitos.md` L51 —R1.2— y L56.

R1.2 dice que se compara contra *«su propio ciclo anual —el mismo mes de los años anteriores—»* y L56 fija que *«la referencia se calcula con **cuatro ciclos anuales completos** (E4 §4.2)»*.

**Dos cosas había que decidir. Las dos se resolvieron el 28 oct 2026 (`DEC-90`):**

**(a) Con qué estadístico se resume el ciclo — RESUELTO. `P3` = (b): LA MEDIANA.** Se descartaron la media y el año anterior solamente por el mismo motivo: con consumos de la magnitud que tiene el panel —`DEC-86` mide extremos de **−1 343 050** a **39 987 040**— **un solo valor extremo arrastraría la referencia de los otros tres años**, y **la mediana no se arrastra**. Además, con los cuatro ciclos que garantiza `P1` = (a), **la mediana es el promedio de los dos valores centrales**, que es **recalculable a mano por un verificador que no participó del estudio (R1.4)**. *La opción (c) —el año anterior solamente— se descartó por usar **1 de los 4 ciclos**; la (d) —decidir después de medir— ya no hace falta: se eligió con el dato de `DEC-86` a la vista.*

**(b) Cuántos de los 57 meses pueden usar cuatro ciclos — RESUELTO. `P1` = (a): SOLO LOS 9 DE 2026.** *Cuenta propia, no medida por consulta:* la ventana cierra el 30/9/2026 (`DEC-69`), de modo que 2026 aporta **9 meses** y cada año anterior, 12. Para el mismo mes de cada año, los años previos disponibles dentro de la ventana son:

| Año del mes a evaluar | Meses | Años previos en la ventana | Cuatro ciclos completos |
|:--|--:|:--|:--|
| 2026 | 9 | 2022 · 2023 · 2024 · 2025 | **sí** |
| 2025 | 12 | 2022 · 2023 · 2024 | no — tres |
| 2024 | 12 | 2022 · 2023 | no — dos |
| 2023 | 12 | 2022 | no — uno |
| 2022 | 12 | ninguno | no — **cero** |

**Cuadra con un dato ya verificado: 9 + 48 = 57 = `meses` de `A2.3.b` (`DEC-80`).** De ahí salen dos derivadas: **48 de 57 meses —84,2 %— no pueden usar cuatro ciclos**, y **los 12 de 2022 no tienen ningún año previo dentro de la ventana**, o sea que `referencia` no existe para ellos y `desviación` no se puede calcular.

**La regla de referencia que resulta de las dos decisiones — esta es la entrega 3.1 en su parte de decisión:**

- **Universo de detección: los nueve meses de 2026** —enero a septiembre—. Sobre los otros **48 meses no se calcula `desviación`**: no se les asigna ningún valor de relleno, la detección simplemente no corre ahí.
- **Para cada cuenta y cada mes de 2026:** `referencia` = **mediana** de los `consumo` de esa misma cuenta en ese mismo mes de **2022, 2023, 2024 y 2025**, o sea cuatro valores.
- **Si a la cuenta le falta alguno de los cuatro ciclos:** **no entra al paso 1 de §4.2 y cae en A1** —ventana de 6 meses, R8.1—, **y la alerta lo declara** —R4.4—.
- **Restricción que hay que escribir en la fórmula y hasta hoy no estaba escrita: `referencia` no puede ser 0 ni negativa.** §4.1 divide entre ella y el panel tiene `consumo` desde **−1 343 050** (`DEC-86`). **Lo que cumpla eso se declara, no se rellena.**
- **La segmentación no se acota:** **A3 se sigue midiendo sobre los 57 meses.** Se acota el paso de detección, no el dato.

**La fórmula, escrita completa antes de correrla — esto es la entrega 3.1 en su parte formal.** Se aplica a las **1 485 556 celdas del panel** —`A2.3.b`, `DEC-80`— y usa **solo dos campos que el panel ya trae: `consumo` y `mes`.** **No define ninguna variable nueva**, que era la condición del autocalculeo.

**Paso A — la referencia.** Para cada cuenta `c` y cada mes `m` del año:

    referencia(c, m) = mediana { consumo(c, m, 2022), consumo(c, m, 2023),
                                  consumo(c, m, 2024), consumo(c, m, 2025) }

Con exactamente cuatro valores —que es lo que garantiza `P1` = (a)— **la mediana es el promedio de los dos centrales una vez ordenados los cuatro**, y eso es lo que la hace recalculable a mano por un verificador que no participó del estudio (R1.4):

    referencia(c, m) = ( v₂ + v₃ ) / 2        con v₁ ≤ v₂ ≤ v₃ ≤ v₄

**Paso B — la desviación.** Para cada cuenta `c` y cada mes `m` **de enero a septiembre de 2026**:

    desviación(c, m) = | consumo_observado(c, m) − referencia(c, m) | / referencia(c, m)

**Paso C — las cuatro salidas. Son excluyentes y cubren el panel entero:** toda celda cae en **exactamente una**.

| Salida | Condición | Qué devuelve |
|:--|:--|:--|
| **valor** | `mes` ∈ enero–septiembre 2026 · la cuenta tiene las cuatro celdas previas de ese mes · `referencia > 0` | `desviación(c, m)` |
| **declaración A1** | `mes` ∈ enero–septiembre 2026 · **a la cuenta le falta alguna de las cuatro celdas previas** | *sin desviación — entra a la contingencia A1, ventana de 6 meses (R8.1); la alerta lo declara (R4.4)* |
| **declaración sin `referencia`** | `mes` ∈ enero–septiembre 2026 · tiene las cuatro · **`referencia ≤ 0`** | *sin desviación — la referencia no es positiva y §4.1 divide entre ella* |
| **declaración fuera** | `mes` ∈ 2022–2025 | *sin desviación — fuera del universo de detección (`P1` = (a))* |

**Las tres decisiones de `DEC-90` quedan dentro de la fórmula y no como nota al margen:** el estadístico —la mediana, `P3` = (b)— · el alcance —los nueve meses de 2026, `P1` = (a)— · **y la restricción de positividad, que era la que faltaba escrita**: `referencia > 0`, porque §4.1 divide entre ella y el panel alcanza `consumo` de **−1 343 050** (`DEC-86`).

**Lo que esta fórmula NO es — dos aclaraciones que evitan leerla mal:**

- **No es un umbral.** `θ` se fija aparte —gate de E7b, punto 3—, calibrando sobre las desviaciones que esta fórmula devuelve. **La fórmula produce el dato; el umbral se decide sobre él y después.**
- **No es la segmentación.** A3 sigue midiendo sobre los 57 meses, porque **se acota el paso de detección y no el dato**.

**Un matiz que la fórmula necesita y que todavía no cierra, declarado para que no se lea como omisión:** para saber si una celda de 2026 tiene sus cuatro ciclos previos basta con **que exista la celda de ese mismo mes en ese año** —eso es lo que la fórmula pregunta—. **Qué cuenta un ciclo *completo* a nivel de año —las doce lecturas, o solo la existencia del mes— es el entregable 3.4 y sigue abierto.** La fórmula no lo espera porque no necesita esa definición para aplicarse.

---

**Autocalculeo de cierre de 3.1 — el que tiene que cerrar para que el punto 1 del gate pase a cumplido.** La fórmula se aplica al panel entero y la salida tiene que mostrar, en este orden:

1. **Las cuatro salidas suman exactamente 1 485 556** —cubrimiento completo, sin hueco y sin solape—.
2. **Ninguna celda recibe valor de relleno:** las que quedan fuera del universo devuelven **declaración**.
3. **Dentro del universo de 2026:** `valor` + `A1` + `sin referencia` = el total de celdas de 2026.
4. **Las celdas de 2026 clasificadas coinciden con las que el panel trae en 2026** —que no se escape ninguna por filtro ni por un `LEFT JOIN` que no encuentre su referencia—.

*Consulta escrita en `sql_a2_extraccion.sql`, bloque `A2.3.c`, **con su criterio fijado antes de correrla**. La corrida y sus cifras se registran como decisión nueva —`DEC-96`— en el momento de correrla y no antes.*

**RESULTADO — corrido el 28 de octubre de 2026 (`DEC-96`). Los cuatro autocalculeos cierran.**

| Salida | Celdas | Cuentas | % del universo 2026 |
|:--|--:|--:|--:|
| **1 valor calculado** | **183 541** | 22 978 | **69,42 %** |
| **2 declaración A1 — le faltan ciclos** | **75 319** | 13 856 | **28,49 %** |
| **3 declaración sin `referencia` — no positiva** | **5 524** | 1 834 | **2,09 %** |
| **4 declaración fuera del universo** | **1 221 172** | 29 784 | — |
| **Total panel** | **1 485 556** | **30 411** | — |

*Los tres porcentajes del universo suman 100,00 % sobre **264 384 celdas de 2026** —183 541 + 75 319 + 5 524—, que es el 17,80 % del panel. **`cuentas` por grupo NO se suman** —38 668 contra 30 411— porque **una cuenta puede caer en más de un grupo**: tener ciclos en algunos meses y faltarle en otros no es una contradicción, es lo normal.*

**Tres cosas que esta salida enseña y que ninguna decisión preveía:**

- **Más de una cuarta parte del universo de detección no puede evaluarse con la regla principal.** **75 319 celdas —28,49 %— caen en A1** porque a la cuenta le falta al menos uno de los cuatro ciclos previos de ese mes. **Eso no es un detalle: significa que la contingencia A1 no es un caso raro para cuentas nuevas, es el camino que tomará más de una de cada cuatro celdas de 2026.** Le da peso real al entregable 3.4.
- **La restricción `referencia > 0` mordió de verdad: 5 524 celdas —2,09 %—.** Consume histórico cuyo valor central de los cuatro años es cero o negativo. **Si esa restricción no se hubiera escrito, esas celdas habrían producido divisiones entre cero o desviaciones negativas sin que se viera**, y ahora salen rotuladas.
- **183 541 celdas sí reciben valor** —69,42 %—, **y esa es la masa sobre la que se calibrará `θ`.**

*La desviación máxima del panel —**1 999 597**— pertenece al grupo con índice cero (`A2.3.d`). Con desviaciones de esa magnitud conviene recordar, para cuando se calibre `θ`, que **la razón se dispara por denominadores chicos y no por consumos enormes**: `desviación` divide entre `referencia`, y una referencia pequeña multiplica la razón aunque el consumo sea corriente.*

**La afirmación que había que separar, porque se leía como una sola — y `DEC-90` la separa:** el `AC4` de `DEC-72` acredita que *la ventana **contiene** cuatro ciclos*, lo cual es cierto y es lo que permitió elegir A2; `P1` = (a) decide que **la desviación se calcula solo donde los cuatro están**. **Son dos afirmaciones distintas: una es sobre los datos y la otra sobre el paso del método.** **Por eso E7a no se reabre:** `07b_requisitos.md` L56 condiciona la reapertura a que el histórico **no alcance** cuatro ciclos, y sí los alcanza —lo que cambia es cuántos meses se les aplica, no si existen—.

**Consecuencia declarada en `DEC-90`, punto 5, y todavía sin decidir: el criterio 1 se acota a esos mismos nueve meses.** La cobertura retrospectiva está fijada sobre **174 procedentes y 1 053 reclamos de 57 meses** (`DEC-64`, `DEC-65`); si la detección solo corre en enero–septiembre de 2026, **solo ahí se puede medir retroactivamente**. *No está medido cuántos reclamos caen en esos nueve meses — ver §7, P4.*

*Resuelta: ver §7, P1 — `DEC-90`.*

### 3.2 — Qué hacer con los huecos de serie: las 38 969 celdas

**Fuente:** `07a_alternativas.md` L168 · cifras de `DEC-86` · opciones de `DEC-81`, punto 5.

`7.f` midió **39 064 filas con `lec_actual = 0`** en la ventana y `7.g` midió que, **después del colapso de duplicados, quedan 38 969 celdas del panel afectadas**, repartidas en **8 728 cuentas —28,70 % de las 30 411—** y en **los 57 meses**, con un consumo promedio de **59 563,2** contra los **686,9** del resto —**86,7 veces**—.

El criterio que se escribió **antes** de correr el `7.g` quedó activado (`DEC-86`, punto 4): *los promedios se despegaron, luego no se calibra hasta que se decida qué hacer con ellas.*

**Las tres ramas que dejó `DEC-81` quedaron cerradas el 28 oct 2026:**

- **(a)** depurar esas filas **como paso del método** —**elegida, `DEC-98`**;
- **(b)** dejarlas **y declararlas en limitaciones** —**descartada**;
- **(c)** **medirlas primero** y decidir —**ya cumplida en `DEC-96` y `DEC-97`**.

**Lo que 3.1 no tenía todavía y 3.2 pidió:** `DEC-86`, punto 5, advierte que **no estaba medida la posición de esas celdas en el ranking de desviación**, porque para eso hacía falta la referencia del ciclo anual, **que es el entregable 3.1.** En otras palabras: **3.1 se resolvía antes que 3.2**, aunque los dos los pone la misma línea de `07a`. **Así ocurrió: sin la fórmula no se puede decir cuánto molestan, y con ella sí se puede medir exactamente dónde.**

**Lo que `DEC-98` abrió y no estaba visto: el ALCANCE de la depuración.** **(i)** depurar **solo la celda observada** de 2026 —el histórico queda intacto aunque traiga celdas con índice cero dentro de la referencia—, o **(ii)** depurar **también el histórico** de 2022 a 2025.

**`A2.3.f` midió ambas (`DEC-99`), con criterio y dos autocalculeos antes de correr:**

| | **(i) solo la observada** | **(ii) también el histórico** |
|:--|:--|:--|
| **Grupos con un solo ciclo corrupto** | **22 856** —la mediana no se toca: producen **la misma referencia** que si estuviera limpio— | **0** |
| **Grupos con dos o más** | **6 004** —quedan con referencia calculada sobre un conjunto corrupto— | **0** |
| **Costo en referencias contaminadas** | **1,71 % de los 350 443 grupos** | **ninguno** |
| **Grupos que dejan de tener cuatro ciclos** | **0** | **16 782** —4,79 %— |
| **Cuentas movidas a A1** | **0** | **5 746** —**19,29 % de las 29 784**— |

**Y un matiz que pesa sobre la opción (ii): A1 no excluye a la cuenta —le da una referencia distinta, la de ventana de 6 meses (R8.1)—, de modo que las 5 746 no se pierden, cambian de base de comparación. Pero la regla de A1 es el punto 4 de este gate y todavía no está escrita.**

**Las tres comprobaciones de `A2.3.f` cerraron, y dos de ellas se comprueban contra otra corrida y no contra una cuenta propia:** **`sin_corrupcion + un_corrupto + dos_o_mas_corruptos` = 350 443, exacto** · **`celdas_indice_cero` = 36 211, que son las 38 969 de `DEC-86` menos las 2 758 de `DEC-97`** · **`cuentas_en_el_historial` = 29 784, la misma cifra de «fuera del universo» en `A2.3.c`.**

**ELEGIDA (i) EL 29 OCT 2026 (`DEC-100`): SE LIMPIA SOLO LA CELDA OBSERVADA DE 2026 Y NO EL HISTÓRICO.** **La regla, escrita antes de aplicarse:**

> *Toda celda del universo 2026 con `lec_actual = 0` se excluye del cálculo de desviación y del listado de alertas; se registran cuántas y de cuántas cuentas. El historial de 2022 a 2025 no se limpia.*

**La limitación que esa elección deja, y que entra a §10 de la propuesta:** ***el 1,71 % de los grupos de referencia de 2022 a 2025 —6 004 de 350 443— se construye sobre dos o más ciclos con `lec_actual = 0`, de modo que su mediana no es robusta y la referencia de esos grupos puede estar afectada.***

**Se declara en vez de corregirse, y la razón es la misma que llevó a elegir (i): corregirla costaba más de lo que corregía.**

**La regla aplicada — `A2.3.g`, `DEC-101`:** **excluye 541 celdas de 411 cuentas de un universo calculable de 183 541 celdas y 22 978 cuentas —0,29 % de las celdas—, y devuelve al canal humano 60,1 alertas al mes, que es el 24,8 % del techo de 242.** **Los tres autocalculeos cerraron exactos —`541 + 183 000 = 183 541`, y las dos comprobaciones contra corridas anteriores—, y una cuarta coincidencia no pedida confirmó el resultado: 183 000 y 22 966 son las mismas cifras del grupo «índice normal» que midió `A2.3.d` por otro camino.**

*Pregunta de la etapa: **cerrada** — ver §7, P2.*

### 3.3 — Cómo se prueban los segmentos

**Fuente:** `07a_alternativas.md` L168 · `07b_requisitos.md` L131.

A3 —normalidad por segmento— se reclasificó como **paso previo obligatorio del método** y no como alternativa competidora (`DEC-70`, punto 1). L131 lo deja claro: *«R7 no compite con R1.2: la segmentación es el paso previo y la comparación contra el ciclo anual es el criterio dentro de cada segmento.»*

**El rol se fijó el 29 oct 2026 (`DEC-103`): (a) caracterización previa que viaja con la alerta.** **Se calcula antes de la detección sobre los 57 meses —`07b` §4.2 lo manda así—, asigna un perfil a cada cuenta y ese perfil se declara en cada alerta. NO cambia qué celdas alertan.**

**Dos decisiones ya fijadas le quitan otros dos trabajos que el gate daba por sentados:**

- **No puede fijar `θ`.** `07b` §4.2 calibra `θ_A2` recorriendo **un orden propio hasta 218 alertas por mes** —más las 24 de `A1`, que suman el techo de 242 (`R2.5`, `DEC-114`)—; un umbral por perfil exigiría reescribir ese procedimiento.
- **No puede sustituir la referencia.** A3 perdió contra A2 en `DEC-70`; **quedó en pie su premisa (`R7`) y no su mecanismo.**

**Lo que (b) —la segunda lente computacional que compara contra el patrón del segmento— habilitaría y aquí no se hace:** ver cuentas **normales para sí mismas pero anómalas para sus pares** (`07a` L103). **Se declara como extensión de diseño en §10 de la propuesta, con su costo escrito: reabrir `§4.2`.**

**Los dos ejes, medidos y ya con corte — `A2.3.h` y `A2.3.i`, ambos cerrados el 29 oct (`DEC-104`):**

| **Eje** | **Cómo se mide** | **Corte** |
|:--|:--|:--|
| **Perfil de consumo** | **Mediana del consumo mensual por cuenta, sobre los 57 meses** —`A2.3.h`, 30 411 cuentas, ambos autocalculeos cerrados— | **Cuatro bandas por cuartiles, con la regla fijada antes de correr y ratificada por la tesista:** **`0` a `26` · `27` a `69` · `70` a `135` · `más de 135`** |
| **Familia de código** | **`tfv_lectura.tipo_lectura` de la lectura de esa celda, enlazando por `id_lectura`** —`A2.3.i`, las 183 541 celdas; **el JOIN no multiplicó ni perdió y `f_sin_dato = 0`**— | **Tres bandas (`DEC-105`):** **(0) no facturada = 15 075 —8,21 %— · (1) lectura normal sin código = 167 036 —91,01 %— · (2+3) con código = 1 430 —0,78 %—** |

**Dos cosas de esos cortes que se declara en vez de esconderlas:**

- **La banda 4 de perfil no tiene techo.** El máximo del perfil es **999 976**, de modo que va de `135` hasta ese valor: **un rango interno de más de siete mil veces**. Los cuartiles garantizan **población** equitativa y no **anchura**. **No se corrige** —el perfil no cambia qué alerta, así que al verificador le basta saber en qué cuartil cae la cuenta—, **se declara.**
- **La banda «con código» es chica y se conserva igual.** **1 430 celdas, 0,78 %** se dejan como banda con su etiqueta en la alerta y **no se fusionan con ninguna otra por ser chicas.**

**Dos hallazgos que la medición produjo sin que nadie los pidiera:**

- **1 861 cuentas —6,12 %— tienen mediana mensual no positiva**, y **928 —3,05 %— no llegan a doce meses observados.**
- **La banda «con código» coincide exactamente con la regla operativa de `DEC-30`** —tipos 2 y 3 son «con código»— **y con lo que la alerta ya declara en `R4.3`.** **Lo nuevo del eje no es que exista: es que «no facturada» queda separada en vez de escondida dentro de «sin código»** —15 075 celdas contra 167 036—.

**Lo único que faltaba para cerrar el punto 3: la prueba de estabilidad.** El gate pide demostrar que el corte es razonable y no una partición a conveniencia. **Los cuartiles ya resuelven la mitad de esa exigencia** —la regla es mecánica y se fijó **antes** de correr, así que ningún número se pudo ajustar—, **pero eso prueba que EL CORTE no está hecho a conveniencia, no que LA VARIABLE sea real**: cualquier columna se reparte en cuartiles y sale equitativo igualmente. **Lo que hace a un perfil útil como segmento es que la cuenta conserve su banda de un periodo al otro.**

**La prueba está corrida y pasó — `A2.3.j`, cerrada el 29 oct (`DEC-108`):**

| Resultado | Valor |
|:--|--:|
| **Conservación de banda** — **criterio fijado antes de correr: ≥ 50 %** | **59,1 %** ✓ |
| Azar con cuatro bandas — el suelo de referencia | 25,0 % |
| **Dentro de una banda** — misma + adyacente | **89,6 %** |
| Dos bandas o más de distancia | 10,4 % |
| **Desplazamiento medio** | **0,539 bandas** |
| Cuentas comparadas sobre el panel | 26 209 de 30 411 |

**Cómo se corrió, y que fuera honesta es parte del resultado:** el panel se partió en **dos mitades —2022-01 a 2024-04, 28 meses, y 2024-05 a 2026-09, 29 meses, que suman los 57 sin recortar nada—**; el perfil se calculó **de cada cuenta en cada mitad por separado**, con **los cuartiles de esa misma mitad**, y se midió cuántas conservaban la banda. **El criterio de rechazo estaba escrito antes de correr y no se movió: 50 % contra el 25 % del azar.** **Y no se trató ningún dato distinto: los `999 976` del máximo siguieron adentro, porque si el perfil es real tenía que serlo también con la cola presente.**

**4 202 cuentas —13,8 %— existen en un solo periodo** y quedan fuera de la comparación por ser un JOIN interno: **la resta cierra, 26 209 + 4 202 = 30 411.** **Se declara para que el 59,1 % se lea sobre 26 209 y no sobre el panel entero.**

**Con esto el punto 3 cierra.** **La segmentación queda como componente de diseño con las tres cosas que `DEC-84`, punto 5, le pide al Capítulo III —rol, ejes y prueba— y con sus relaciones fijadas: no fija `θ` y no sustituye la referencia.**

*Cerrado: punto 3 del gate — E7c en 3 de 6.*

### 3.4 — El tratamiento de la contingencia A1

**Fuente:** `07a_alternativas.md` L157, L159 y L178 · `07b_requisitos.md` L95 —R4.4— y L139 —R8.1—.

A1 —ventana de 6 meses— **ya no es alternativa**: es regla de contingencia, para *«cuentas con menos de cuatro ciclos anuales completos»* (`DEC-70`, punto 1), y R4.4 exige que la alerta **lo diga** cuando ocurra.

**Las dos preguntas se respondieron midiendo, el 29 oct 2026 — `A2.3.k` y `A2.3.k2`, `DEC-110` y `DEC-111`.** Se compararon las dos definiciones **sobre el mismo universo de 264 384 celdas y con la referencia idéntica en las dos** —redefinirla habría reabierto el punto 1 del gate, que ya cerró `DEC-96`—:

| | **A — el mes existe (ELEGIDA)** | **B — las 12 lecturas (descartada)** |
|:--|--:|--:|
| Celdas con valor | **183 541** —69,4 %— | 118 115 —44,7 %— |
| Celdas en A1 | **75 319** —28,5 %— | 140 745 —53,2 %— |
| Cuentas con los 4 años completos | — | 13 285 de 30 411 —43,7 %— |

**B se descartó con el número en la mano:** habría movido **65 426 celdas —el 35,6 % del universo—** a A1 y habría puesto al fallback en mayoría —**el 56,3 % de las cuentas—, lo cual deja sin efecto `R8.3`: *«R8.1 nunca puede ser el criterio principal: es fallback»*.** **Y corre un argumento que no depende de ningún porcentaje: la referencia de un mes `m` se calcula con el mes `m` de cada año, de modo que los otros once meses nunca entran en esa mediana —exigir las 12 lecturas no vuelve más correcta la referencia, solo descarta años cuyo dato para ese mes sí existe—.**

**La regla ejecutable, tal como queda escrita:**

| **Pregunta** | **Regla** |
|:--|:--|
| **Qué cuenta un ciclo completo** | Un año cuenta para el mes `m` si la cuenta **tiene ese mes** en ese año, sobre el panel colapsado con la regla de `A2.3.b`. **No se exigen las 12 lecturas.** |
| **Cuántos ciclos se cuentan** | `ciclos` = número de años entre 2022 y 2025 que tienen ese mes para esa cuenta. |
| **Cuándo entra a A1** | `ciclos < 4` |
| **Cuándo recibe `desviación`** | `ciclos ≥ 4` **y** `referencia > 0` |
| **Cuándo declara sin `referencia`** | `ciclos ≥ 4` **y** `referencia ≤ 0` — **no es A1: son tres salidas distintas.** |
| **Qué ventana usa A1** | Los últimos 6 meses (`R8.1`). |
| **Con qué calcula `A1` su desviación** | `abs(consumo − media_6meses) / media_6meses`, en **ambas direcciones** —la media de los meses previos disponibles, hasta un máximo de seis, sin incluir las celdas con `lec_actual = 0`, y solo cuando sea positiva; `DEC-115` y `DEC-116`—. |
| **Con qué umbral alerta `A1`** | `θ_A1`, fijado por los pasos 6 a 8 de §4.2, dentro del cupo de **24 alertas por mes** (`R2.5`). |
| **Qué pasa cuando la cuenta no tiene seis meses previos** | Se usan **los que existan, hasta un máximo de seis** (`DEC-115`, 30 oct 2026). **No se exigen los seis completos:** hacerlo habría dejado sin desviación a las cuentas nuevas —que es la población a la que `A1` existe para cobrir— y habría vaciado `R8.1`◆F por dentro. |
| **Si las celdas depuradas entran en el cálculo de esa media** | **No entran** (`DEC-116`, 30 oct 2026). El consumo de las celdas con lectura es **86,7 veces mayor**, así que dejar dentro las de índice cero arrastraría la media hacia cero y produciría desviaciones artificiales. **El histórico no se borra: se excluye del cálculo, que es distinto de depurarlo —distinción declarada en §10 de la propuesta—.** |
| **Qué declara la alerta** | Que esa celda cayó en A1 (`R4.4`), marcada como alerta originada en `R8.1` (`R8.2`). |

**Autocalculeo que cerró ANTES de decidir:** `lo_contrario_deberia_ser_cero` = **0**, o sea que **B es subconjunto de A: ninguna celda tiene valor bajo B sin tenerlo bajo A.** **No se midió una hipótesis abierta —se dedujo antes de correr y la corrida lo confirmó—.**

**Un hueco que solo se hizo visible al repartir el techo (29 oct 2026, `DEC-114`):** la regla de alerta de `A1` **ya estaba escrita** —`07a` L85-L87: *«ventana móvil de 6 meses **con umbral escrito**»*— y **nunca se había traído a este diseño**, porque el punto 4 del gate solo preguntaba *«cuándo entra A1»* y no *«con qué alerta»*. **§3.4 quedó entonces con qué entra y qué ventana, pero sin umbral.** **El hueco se descubrió al decidir el reparto: sin la regla de `A1` no se puede medir cuánto consume, y sin esa cifra no se puede calibrar `θ_A2` contra el cupo que le queda.** **Se cierra con las dos filas de la tabla de arriba.**

**Dos cosas que quedan escritas y no son la regla:**

- **`R8.1` se precisó en su unidad el mismo día (`DEC-111`), con su texto original conservado junto al nuevo:** la fórmula decide **por cuenta y mes**, no por cuenta entera —**lo que `07c` §3.1 ya normalizaba al declarar que las `cuentas` por grupo no se suman**—. **La promesa no cambió: ninguna cuenta queda sin cobertura.**
- **La carencia por año se declara y no se resuelve:** bajo la definición A, **un año con 8 meses sigue contando para los 8 meses que sí tiene**, porque son esos y solo esos los que entran en la mediana de ese mes. Queda en §10 de la propuesta.

*Depende de 3.1 — resuelto. Cerrado: punto 4 del gate — E7c en 4 de 6.*

### 3.5 — El valor del criterio 4 (aplicabilidad) y su procedimiento

**Fuente:** `07b_requisitos.md` L231 —y L160-L161, `R10.1` y `R10.2`—; `02_delimitacion.md` L51; `propuesta_borrador_v1.md` L213 y L281.

**El criterio 4 —aplicabilidad— queda fijado hoy con su valor y su procedimiento, el 29 oct 2026 (`DEC-112`).** **Lo que NO queda fijado es la medición, y esa distinción no es cosmética.**

| **Campo** | **Contenido** |
|:--|:--|
| **Qué mide** | Que el equipo técnico sigue el método **sin asistencia de la autora** (`R10.1`). |
| **Procedimiento** | Sobre una **muestra de las alertas que el método produce**, **un verificador que NO participó del estudio** resuelve cada alerta **usando solo el método escrito**. |
| **Umbral** | **100 % de las alertas de la muestra.** |
| **Denominador** | **Las alertas que el método produce —no el universo de celdas—.** |
| **Dónde se mide** | **E7f/E8, no en E7c:** `propuesta` L281 programa E7e y E7f para el **1–8 de noviembre**, y `propuesta` L213 exige verificadores **ajenos** a la autora. |
| **Estado** | **Valor y procedimiento FIJADOS; medición PENDIENTE.** |

**Dos cosas de este criterio que costaron verlas, y se escriben porque sin ellas el número no significa nada.**

**Primera — el denominador.** Con la tasa de alertas ya medida, **un verificador que marcara «sin alerta» en TODAS las celdas coincidiría con el método el 99,70 % de las veces:** ≈ **541 alertas** —60,1 por mes × 9 meses— sobre **183 000 celdas** = **0,30 %**. **Un umbral de coincidencia medido sobre el universo entero se aprueba con solo no alertar nunca,** y el criterio quedaría vacío. **Por eso el umbral se mide sobre las alertas, que es donde está la información.**

**Segunda — el umbral no es un número redondo elegido a gusto.** `R10.1` dice *«el equipo técnico sigue el método sin asistencia de la autora»* **sin calificar**: ni «casi», ni «en su mayoría». **Y `R1.4` ya obligaba a que la referencia sea *recalculable a mano por un verificador que no participó del estudio*,** o sea que el diseño ya estaba comprometido con que un ajeno pueda reproducirlo. **Un umbral menor habría metido una letra que los requisitos no tienen.**

**Lo que no cambió:** `R10.1` y `R10.2` quedan como estaban —solo se les asigna valor—; y `02_delimitacion.md` L51 deja de decir «fijar antes de construir».

**No hay ninguna cifra de aplicabilidad en ningún documento, y no la habrá hasta E7f/E8.**

*Cerrado: punto 5 del gate.*

### 3.6 — El paso de depuración como paso del método

**Fuente:** `DEC-75`, `P4`.

Se decidió que la depuración **es un paso del método**, no un arreglo previo (`DEC-75`, `P4`), y **`P2` = (a) el 28 oct 2026 (`DEC-98`) la convirtió en el paso que absorbe las 38 969**.

**El paso, escrito el 29 oct 2026 (`DEC-100`):**

| **Campo** | **Contenido** |
|:--|:--|
| **Nombre** | **Depuración de las celdas con índice de contador en cero** |
| **Cuándo entra** | **Después de construir el panel y antes del cálculo de desviación** —la sanitización determinista que pidió `DEC-98`— |
| **Regla** | **Toda celda del universo 2026 con `lec_actual = 0` se excluye del cálculo de desviación y del listado de alertas.** |
| **Qué NO hace** | **No limpia el historial de 2022 a 2025.** Su precio era mover 5 746 cuentas a A1, y A1 todavía no tiene regla. |
| **Qué registra** | **Cuántas celdas excluyó y de cuántas cuentas.** |

**Relación con 3.3 — CONFIRMADA, el 29 oct 2026 (`DEC-112`).** **§3.6 fijó la condición exacta: *«ese orden se confirma al escribir A3 en el punto 3 del gate»* —y A3 se escribió (`DEC-103`).**

**La confirmación se sigue de lo que ese punto cerró, y no de una suposición:** si la segmentación **no cambia cuáles celdas tienen valor** —es caracterización que viaja con la alerta y `θ` sigue global—, entonces **tampoco puede rescatar una celda que la depuración ya excluyó.** Con eso el orden queda demostrado y no supuesto:

**depuración → segmentación → fórmula**

**Es el único orden que evita clasificar celdas que después se excluyen**, y es el que §3.2 y §3.3 ya describían.

**Un efecto acotado que se declara en lugar de esconderlo.** Los cortes de perfil de §3.3 —`0–26 · 27–69 · 70–135 · >135`— se midieron sobre el panel **antes** de la depuración —`A2.3.h`, `DEC-104`—, y con el orden confirmado la ejecución real los calcularía **después**. **No se rehace la medición.** **La cota es exacta y pequeña: 541 celdas de 411 cuentas** —el 0,29 % del universo de 2026 y el 1,35 % de las 30 411 cuentas—, y la depuración **no toca el historial de 2022 a 2025**, que es de donde sale la mayor parte de la mediana de perfil.

*Cerrado: punto 6 del gate.*

**Autocalculeo de cierre del paso — CORRIÓ Y CERRÓ (`A2.3.g`, `DEC-101`):** **541 celdas de 411 cuentas excluidas de un universo calculable de 183 541 celdas y 22 978 cuentas —0,29 % de las celdas—; 60,1 alertas al mes devueltas al canal humano, el 24,8 % del techo de 242.** **Las dos comprobaciones contra corridas anteriores cerraron —`celdas_en_el_calculo` = 183 541, la salida «valor» de `A2.3.c`; `celdas_depuradas` = 541, el censo de `A2.3.e`—; y una cuarta coincidencia no pedida las respaldó: 183 000 y 22 966 son el grupo «índice normal» que midió `A2.3.d` por otro camino.**

*La exigencia de registro no se inventa aquí: R4.4 manda que la alerta diga cuándo se aplicó una regla de contingencia, y esta es la misma exigencia aplicada a la depuración.*

---

## 4. Condición transversal — lo que esta etapa tiene que poder mostrar

`DEC-84`, punto 5: el Capítulo IV *«es la concreción del modelo teórico»* —`guia_ifi_contenido.md` L336— y *«La propuesta se constituye en la concreción de lo modelado en el Capítulo III»* —`indicadores_revision_ifi.md` L221—.

**Traducción operativa:** lo que E7c diseñe tiene que poder expresarse como **componentes y relaciones**, con su representación gráfica, porque ese es justamente lo que el Capítulo III del IFI va a modelar. **No es un séptimo entregable: es una condición de cierre que se aplica a los seis.**

---

## 5. Gate de E7c — CERRADO: **6 de 6**

**Se cierra esta etapa cuando se cumplan seis cosas:**

1. **CUMPLIDO el 28 oct 2026 — la referencia anual.** **La fórmula quedó escrita en §3.1** con las tres decisiones de `DEC-90` dentro y con la restricción `referencia > 0`, **y el autocalculeo de cierre corrió y cerró** (`A2.3.c`, `DEC-96`). **Las tres comprobaciones:** `suma_las_cuatro` = **1 485 556** —exacto, sin hueco y sin solape— · `diferencia_contra_el_panel` = **0** · `diferencia_celdas_2026` = **0**. **Y la cuarta, que era la de no perder celdas por el `LEFT JOIN`:** `celdas_2026_clasificadas` = **264 384** = `celdas_2026_en_el_panel`. **`cuentas` = 30 411, la misma de `A2.3.b` (`DEC-80`),** de modo que el panel con el que se clasificó es el panel verificado. *La fórmula se aplicó a las 1 485 556 celdas **sin definir ninguna variable nueva** —usó solo `consumo` y `mes`— y devolvió **valor** para las que caen dentro del universo y **declaración** para las que quedan fuera, que era la condición del punto.*
2. **CUMPLIDO el 29 oct 2026 — las 38 969 celdas.** **La rama se eligió en `DEC-98` —(a) depurar como paso del método—, el alcance en `DEC-100` —(i) solo la celda observada—, la regla se escribió ANTES de aplicarse y el número entró en `A2.3.g` (`DEC-101`).** **La regla: toda celda del universo 2026 con `lec_actual = 0` se excluye del cálculo de desviación y del listado de alertas; se registran cuántas y de cuántas cuentas; el historial de 2022 a 2025 no se limpia.** **El resultado: 541 celdas de 411 cuentas excluidas de un universo calculable de 183 541 celdas y 22 978 cuentas —0,29 % de las celdas—, y 60,1 alertas al mes devueltas al canal humano, el 24,8 % del techo de 242.** **Los tres autocalculeos cerraron exactos, dos de ellos contra corridas anteriores; y una cuarta coincidencia no pedida confirmó el resultado: 183 000 y 22 966 son las mismas cifras del grupo «índice normal» que midió `A2.3.d` por otro camino.** **La limitación que la decisión deja quedó escrita en §10 de la propuesta: el 1,71 % de los grupos de referencia de 2022 a 2025 se construye sobre dos o más ciclos con `lec_actual = 0`.** *Cerrado con su consulta registrada en `sql_a2_extraccion.sql`.*
3. **CUMPLIDO el 29 oct 2026 — los segmentos A3.** **El ROL se fijó en `DEC-103`: caracterización previa que viaja con la alerta, calculada antes de la detección sobre los 57 meses, sin cambiar qué celdas alertan, sin fijar `θ` y sin sustituir la referencia.** **Los DOS EJES se midieron con el criterio escrito antes de correr (`DEC-104`).** **Perfil de consumo:** mediana mensual por cuenta sobre 57 meses, **cuatro bandas por cuartiles —`0–26` · `27–69` · `70–135` · `>135`—, regla fijada antes de correr y ratificada antes de ver los números.** **Familia de código:** **tres bandas —no facturada · lectura normal sin código · con código—** (`DEC-105`), **alineadas con la regla operativa de `DEC-30` y con lo que `R4.3` ya declara.** **La PRUEBA de que no es una partición a conveniencia corrió y pasó (`DEC-108`): conservación de banda del 59,1 % contra el 50 % exigido y el 25 % del azar, con el criterio de rechazo escrito antes de correr y sin moverse después.** **Y la variable resultó ser una propiedad de la cuenta y no ruido: 89,6 % se queda dentro de una banda y el desplazamiento medio es de 0,539 bandas.** **Limitación declarada en §10 de la propuesta: la segunda lente computacional —(b), comparar contra el patrón del segmento— queda como extensión de diseño con su costo escrito, que es reabrir `07b` §4.2.** *(Consultas: `A2.3.h`, `A2.3.i` y `A2.3.j`, las tres con sus autocalculeos cerrando y registradas en `sql_a2_extraccion.sql`.)*
4. **CUMPLIDO el 29 oct 2026 — la contingencia A1.** **Las dos preguntas se midieron y no se decidieron a ojo (`A2.3.k` y `A2.3.k2`, `DEC-110` y `DEC-111`).** **Queda elegida la definición A —un año cuenta si la cuenta tiene ese mes—, con dos constataciones detrás: la referencia de un mes `m` solo usa el mes `m` de cada año, así que exigir las 12 lecturas no la habría vuelto más correcta; y la definición B habría movido 65 426 celdas —el 35,6 % del universo— a A1 y habría puesto al fallback en el 56,3 % de las cuentas, dejando sin efecto `R8.3`.** **La regla ejecutable está escrita en §3.4 en su forma completa: qué cuenta un ciclo, cuántos se cuentan, cuándo entra a A1, cuándo recibe `desviación`, cuándo declara sin `referencia` —tres salidas distintas—, qué ventana usa y qué declara la alerta.** **Autocalculeo de verificación: `lo_contrario_deberia_ser_cero` = 0, que confirma que B era subconjunto de A, deducido antes de correr.** **Con eso se cerraron dos cosas que colgaban de acá: `R8.1` se precisó en su unidad —con su texto original conservado—, y la carencia por año quedó declarada.** *(No se tocó `AC4` ni se reabrió E7a: `07c` §3.1 ya había separado lo que es sobre la ventana de lo que es sobre cada cuenta.)*
5. **CUMPLIDO el 29 oct 2026 — el criterio 4, aplicabilidad (`DEC-112`).** **Quedan fijados su valor y su procedimiento, que es lo que pide `07b_requisitos.md` L231:** sobre una **muestra de las alertas que el método produce**, un verificador **que no participó del estudio** las resuelve **usando solo el método escrito y sin asistencia de la autora**; **umbral: 100 % de las alertas de la muestra.** **El denominador es el de las alertas y no el del universo, y eso se escribió con su razón:** con ≈ 541 alertas sobre 183 000 celdas —0,30 %—, un verificador que nunca alertase **coincidiría con el método el 99,70 %**, de modo que un umbral medido sobre el universo entero **se aprobaría con solo no alertar nunca.** **Y el umbral no es un número elegido a gusto: `R10.1` no califica, y `R1.4` ya obligaba a que la referencia fuera recalculable a mano por un ajeno.** **La medición NO es de E7c: corre en E7f/E8** —`propuesta` L281 la programa para el 1–8 de noviembre y L213 exige verificadores ajenos—. **No existe ninguna cifra de aplicabilidad y no existirá hasta entonces.**
6. **CUMPLIDO el 29 oct 2026 — el paso de depuración, en su lugar de la secuencia (`DEC-112`).** **§3.6 ya tenía el paso escrito** —nombre, cuándo entra, regla, qué NO hace y qué registra—, **y lo que faltaba era confirmar el orden contra lo que cerró el punto 3.** **La condición la había fijado el propio §3.6: *«ese orden se confirma al escribir A3 en el punto 3 del gate»*, y A3 se escribió (`DEC-103`).** **La confirmación es deducida y no supuesta: si la segmentación no cambia cuáles celdas tienen valor, tampoco puede rescatar una celda que la depuración ya excluyó, de modo que el orden queda demostrado —depuración → segmentación → fórmula—.** **Se declaró además un efecto acotado sin rehacer la medición: los cortes de perfil de §3.3 se midieron sobre el panel pre-depurado, y la diferencia está acotada por 541 celdas de 411 cuentas.**

**Cadena de cierre que se desata al pasar de 0 de 6 a 6 de 6:** E7c cierra → **se ejecutan los ocho pasos de §4.2** con la referencia ya fijada → **se registra `θ_A2` y `θ_A1` con su sello de fecha** → se vuelca al criterio 2 de `02_delimitacion.md` → **el punto 3 del gate de E7b pasa a cumplido → E7b cierra 4 de 4**.

*Hasta ese momento el gate de E7b no se reabre: sigue donde está, en 3 de 4.*

---

## 6. Lo que esta etapa NO hace

- **No corre consultas nuevas como su forma de trabajar.** E7c es una etapa de decisión. Si alguno de los seis puntos exige un dato que no existe, la consulta se escribe **con su criterio fijado antes de correrla**, se corre y se registra con su número de decisión —el orden es ese y no el contrario.
- **No construye.** La construcción y su verificación interna son `E7d`/`E7e` (`07b_requisitos.md` §4.3).
- **No fija el valor de `θ`.** Eso es del gate de E7b; esta etapa entrega lo que lo hace posible.
- **No reabre la alternativa.** E7a está cerrada desde `DEC-70` y su condición de reapertura no se activó.
- **No toca el panel ni el 242,2.** Sus cifras siguen como las dejó `DEC-80`, y `242,2 = 2 180 ÷ 9` no depende de esta etapa.

---

## 7. Preguntas abiertas de la etapa

- **P1 — Meses sin cuatro ciclos (48 de 57, y 12 de 2022 sin ninguno).** ¿Qué se hace con los meses que no tienen cuatro años previos en la ventana? **(a)** calcular la desviación **solo donde sí hay cuatro** —los 9 meses de 2026— y ajustar §4.2, que hoy dice *cada cuenta y cada mes*; **(b)** calcular con **los ciclos disponibles según el año** y dejar que los 12 de 2022 caigan en la contingencia A1; **(c)** **medir primero** cuántas cuentas tienen realmente cuatro ciclos completos antes de elegir entre (a) y (b). **RESUELTA el 28 oct 2026 — `P1` = (a).** *Justificación y consecuencias en `DEC-90`.*
- **P2 — Las 38 969 celdas — CERRADA EL 29 OCT 2026 (`DEC-98`, `DEC-99`, `DEC-100`, `DEC-101`).** (a) depurar / (b) declarar / (c) medir y decidir. **MEDIDA Y CENSADA — `A2.3.d` y `A2.3.e`, `DEC-96` y `DEC-97`. La rama (c) se cumplió.** ***La rectificación de lectura, puesta primero porque es lo que cambia la decisión:*** `A2.3.d` midió **mediana 5,666667** contra **0,434783** del resto —**13,0 veces**, sobre el umbral de 2× fijado antes de correr—, **pero midió a 541 celdas y el censo de `A2.3.e` reveló que la clase es de 2 758**: **541 con valor —19,62 %— · 2 158 en A1 —78,24 %— · 59 sin `referencia` —2,14 %—, y las nueve filas suman 264 384 exacto.** **O sea que `13,0×` describe a una quinta parte de la clase y no a la clase, y se declara así.** ***Pero el dato que decide no es esa proporción: las otras 2 217 celdas con índice cero ya estaban fuera del cálculo por reglas ajenas a esta decisión —A1 y `referencia` no positiva—, de modo que la única celda con índice cero que puede generar una alerta es de las 541.*** **La cuenta de capacidad: 541 en 9 meses = 60,1 alertas/mes = 24,8 % del techo de 242** (`DEC-45`, `DEC-54`), **gastándose en lecturas que `DEC-86` ya describió como incoherentes —índice en cero con consumo 86,7 veces el del resto—.** **RESUELTA EL 28 OCT 2026 — `P2` = (a): DEPURAR COMO PASO DEL MÉTODO (`DEC-98`).** **Los tres argumentos de la tesista, registrados tal como los dio:** *consistencia con `DEC-75` `P4` —la depuración ya pertenecía al perímetro formal y esta regla la vuelve determinista y verificable— · optimización del criterio 3 —gastar 60,1 alertas/mes, el 24,8 % del canal humano, en ceros triviales compromete el techo estricto de 242, y filtrarlos con su métrica por separado devuelve capacidad real para auditar desvíos sutiles de tipo 1— · rigor en DSR —el método se encarga de la sanitización determinista antes de someter las lecturas al cálculo—.* **Lo que esa decisión ABRE y todavía no está fijado: el ALCANCE.** **Medido el 29 oct en `A2.3.f` (`DEC-99`), con los tres autocalculeos cerrando y dos de ellos contra otra corrida:** **`celdas_indice_cero` = 36 211** —las **38 969** de `DEC-86` menos las **2 758** de `DEC-97`—. ***Reparto de los 28 860 grupos que traen al menos un ciclo corrupto: 22 856 con EXACTAMENTE UNO —79,20 %— y 6 004 con DOS O MÁS —20,80 %—.*** **(i) Depurar solo la celda observada:** los 22 856 grupos con un solo corrupto producen **exactamente la misma referencia** que si el histórico estuviera limpio —la mediana no se toca—, y el costo entero son **los 6 004 restantes, 1,71 % de los 350 443 grupos, con referencia construida sobre un conjunto corrupto—; A1 no se mueve.** **(ii) Depurar también el histórico:** **cero referencias contaminadas**, y el costo son **16 782 grupos que dejan de tener cuatro ciclos —4,79 %— y 5 746 cuentas que pasan a A1, el 19,29 % de las 29 784.** ***Matiz que pesa: A1 no excluye —le da una referencia de ventana de 6 meses, R8.1—, pero su regla es el punto 4 del gate y todavía no existe.*** **ALCANCE RESUELTO EL 29 OCT 2026 — (i): SE LIMPIA SOLO LA CELDA OBSERVADA DE 2026, CON LA LIMITACIÓN DECLARADA (`DEC-100`).** **La regla quedó escrita ANTES de aplicarse: toda celda del universo 2026 con `lec_actual = 0` se excluye del cálculo de desviación y del listado de alertas; se registran cuántas y de cuántas cuentas; el historial de 2022 a 2025 no se limpia.** **La limitación que deja, para §10 de la propuesta: el 1,71 % de los grupos de referencia de 2022 a 2025 —6 004 de 350 443— se construye sobre dos o más ciclos con `lec_actual = 0`, de modo que su mediana no es robusta y la referencia de esos grupos puede estar afectada. Se declara en vez de corregirse, porque corregirla costaba más de lo que corregía.** **EL NÚMERO DE CIERRE — `A2.3.g`, `DEC-101`: 541 celdas de 411 cuentas excluidas de un universo calculable de 183 541 celdas y 22 978 cuentas —0,29 % de las celdas—; 60,1 alertas al mes devueltas al canal humano, el 24,8 % del techo de 242. Los tres autocalculeos cerraron exactos, dos de ellos contra corridas anteriores, y una cuarta coincidencia no pedida los respaldó: 183 000 y 22 966 son el grupo «índice normal» que midió `A2.3.d` por otro camino. El punto 2 del gate pasó a CUMPLIDO y E7c está en 2 de 6.** *Abierta el 27 oct 2026 (`DEC-81`), reprogramada al 28 oct (`DEC-87`), rama resuelta el 28 oct (`DEC-98`), alcance medido y resuelto el 29 oct (`DEC-99` y `DEC-100`), cerrada con su número el mismo 29 oct (`DEC-101`).*
- **P3 — El estadístico de la referencia.** (a) media aritmética de los mismos meses de los años anteriores / (b) mediana / (c) el año anterior solamente / (d) se decide al ver cuál de (a) o (b) es menos sensible a los extremos que midió `DEC-86`. **RESUELTA el 28 oct 2026 — `P3` = (b): la mediana.** *Justificación en `DEC-90`, punto 3.*
- **P4 — El criterio 1 contra los nueve meses.** `P1` = (a) acota la detección a enero–septiembre de 2026, y la cobertura retrospectiva —criterio 1— está fijada sobre **174 procedentes y 1 053 reclamos de 57 meses**. **¿Se mide la base de 2026?** **(a)** **medir** cuántos reclamos y cuántos procedentes caen en esos nueve meses —consulta nueva, con criterio fijado antes de correr— y reevaluar el criterio 1 sobre esa ventana; **(b)** **no medir** y dejar la base de 57 meses como línea descriptiva, declarando en limitaciones que el método retroevaluable alcanza solo 9 meses; **(c)** **medir** y, si la base de 2026 es demasiado pequeña para sostener la evaluación, **reabrir `P1`** para (b). **RESUELTA el 28 oct 2026 — `P4` = (b): NO SE ABRE NINGUNA CONSULTA NUEVA.** La base de 57 meses se conserva íntegra como **caracterización empírica del problema (E6)**, y **la limitación queda escrita en `propuesta_borrador_v1.md` §10**: el **protocolo de retroevaluación algorítmica aplica sobre los nueve meses de 2026**, por disponibilidad de los cuatro ciclos previos que exige R1.2.

---

*Archivo creado el 28 oct 2026. Ningún número de este documento está inventado: cada uno trae su decisión o su consulta de origen. Las dos derivadas de §3.1 se marcan como cuenta propia y autoverifican contra `57 = 9 + 48`, que es `meses` de `A2.3.b` (`DEC-80`).*
