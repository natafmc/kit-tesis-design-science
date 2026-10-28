# E7c — Diseño del artefacto

> **Estado:** en curso — abierta el 28 oct 2026 (`DEC-87`).
> **Suerte de artefacto:** método, con instanciación de apoyo *exemplar* (`DEC-70`, punto 2).
> **Abre con el gate de E7b en 3 de 4** — es el segundo paso previo del punto 3, el de `θ`.
> **Qué es esta etapa:** diseña. **No construye** —construir es `E7d`/`E7e` (`07b_requisitos.md` §4.3).

---

## 1. Por qué esta etapa se abre hoy

Se abrió el 28 oct 2026 por `DEC-87`, y no antes por una sola razón: **el orden estaba mal escrito entre dos archivos.**

`07b_requisitos.md` §4.3 exigía fijar el valor de `θ` con los cinco pasos de su §4.2, y el paso 1 de ese procedimiento dice:

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

**Las tres ramas siguen abiertas, tal como las dejó `DEC-81`:**

- **(a)** depurar esas filas **como paso del método** —extendería `DEC-75`, `P4`;
- **(b)** dejarlas **y declararlas en limitaciones**;
- **(c)** **medirlas primero** y decidir en función de cuánto contaminan.

**Lo que esta etapa no tiene todavía y cualquier rama va a pedir:** `DEC-86`, punto 5, advierte que **no está medida la posición de esas celdas en el ranking de desviación** —que es lo que decide si molestan de verdad— porque para eso hace falta la referencia del ciclo anual, **que es el entregable 3.1.** En otras palabras: **3.1 se resuelve antes que 3.2**, aunque los dos los pone la misma línea de `07a`.

*Pregunta de la etapa: ver §7, P2.*

### 3.3 — Cómo se prueban los segmentos

**Fuente:** `07a_alternativas.md` L168 · `07b_requisitos.md` L131.

A3 —normalidad por segmento— se reclasificó como **paso previo obligatorio del método** y no como alternativa competidora (`DEC-70`, punto 1). L131 lo deja claro: *«R7 no compite con R1.2: la segmentación es el paso previo y la comparación contra el ciclo anual es el criterio dentro de cada segmento.»*

**Falta:** qué segmento, con qué variable de corte, y **con qué prueba se demuestra que el corte es razonable** y no una partición a conveniencia. *Pendiente: no está escrito en ningún archivo y no se decide hasta que 3.1 avance.*

### 3.4 — El tratamiento de la contingencia A1

**Fuente:** `07a_alternativas.md` L157, L159 y L178 · `07b_requisitos.md` L95 —R4.4— y L139 —R8.1—.

A1 —ventana de 6 meses— **ya no es alternativa**: es regla de contingencia, para *«cuentas con menos de cuatro ciclos anuales completos»* (`DEC-70`, punto 1), y R4.4 exige que la alerta **lo diga** cuando ocurra.

**Falta traducir eso a una regla ejecutable:** **cómo se cuenta un ciclo completo** —¿tiene que tener las 12 lecturas, o basta con que exista el mes?— y **quién dispara A1**: el criterio es por cuenta (`R8.1`), pero el hallazgo del 3.1 es que **también hay una carencia por año que ninguna de las dos formulaciones cubre hoy.**

*Depende de 3.1: no se decide antes.*

### 3.5 — El valor del criterio 4 (aplicabilidad) y su procedimiento

**Fuente:** `07b_requisitos.md` L231.

El criterio 4 está **fijado como requisito R10**; **su valor se fija en E7c con procedimiento**, que es lo que dice esa línea literalmente. *Pendiente: no se toca hasta que 3.1 y 3.2 estén resueltos, porque el valor depende de qué tan costoso sea aplicar el método.*

### 3.6 — El paso de depuración como paso del método

**Fuente:** `DEC-75`, `P4`.

Se decidió que la depuración **es un paso del método**, no un arreglo previo. **Falta escribirlo como paso**: en qué punto de la secuencia entra, con qué regla, y **qué se registra cuando corre**.

**Punto de contacto directo con 3.2:** si se elige la rama (a), **la depuración de las 38 969 pasa a ser este paso**, y la rama (a) deja de ser una opción suelta para volverse la descripción de un paso del método.

---

## 4. Condición transversal — lo que esta etapa tiene que poder mostrar

`DEC-84`, punto 5: el Capítulo IV *«es la concreción del modelo teórico»* —`guia_ifi_contenido.md` L336— y *«La propuesta se constituye en la concreción de lo modelado en el Capítulo III»* —`indicadores_revision_ifi.md` L221—.

**Traducción operativa:** lo que E7c diseñe tiene que poder expresarse como **componentes y relaciones**, con su representación gráfica, porque ese es justamente lo que el Capítulo III del IFI va a modelar. **No es un séptimo entregable: es una condición de cierre que se aplica a los seis.**

---

## 5. Gate de E7c — abierto: **1 de 6**

**Se cierra esta etapa cuando se cumplan seis cosas:**

1. **CUMPLIDO el 28 oct 2026 — la referencia anual.** **La fórmula quedó escrita en §3.1** con las tres decisiones de `DEC-90` dentro y con la restricción `referencia > 0`, **y el autocalculeo de cierre corrió y cerró** (`A2.3.c`, `DEC-96`). **Las tres comprobaciones:** `suma_las_cuatro` = **1 485 556** —exacto, sin hueco y sin solape— · `diferencia_contra_el_panel` = **0** · `diferencia_celdas_2026` = **0**. **Y la cuarta, que era la de no perder celdas por el `LEFT JOIN`:** `celdas_2026_clasificadas` = **264 384** = `celdas_2026_en_el_panel`. **`cuentas` = 30 411, la misma de `A2.3.b` (`DEC-80`),** de modo que el panel con el que se clasificó es el panel verificado. *La fórmula se aplicó a las 1 485 556 celdas **sin definir ninguna variable nueva** —usó solo `consumo` y `mes`— y devolvió **valor** para las que caen dentro del universo y **declaración** para las que quedan fuera, que era la condición del punto.*
2. **EN CURSO — las 38 969 celdas.** **Medidas y censadas** —`A2.3.d` y `A2.3.e`, `DEC-96` y `DEC-97`—, **y la rama (c) de `DEC-81` —medir y decidir— se cumplió.** **Falta UNA sola cosa: elegir entre (a) depurar y (b) declarar.** *Lo que ya se sabe para elegir:* **la clase tiene 2 758 celdas en el universo de 2026** —541 calculables, 2 158 en A1, 59 sin `referencia`—, **y solo las 541 pueden generar alerta**, que son **60,1 al mes, el 24,8 % del techo de 242**. **La regla se escribe ANTES de aplicarse y el punto 2 no cierra hasta que esté escrita.** *Autocalculeo de cierre: la regla aplicada deja un número de celdas y de cuentas afectadas, y ese número se registra con su consulta.*
3. **PENDIENTE — los segmentos A3.** Corte propuesto y prueba de que es razonable.
4. **PENDIENTE — la contingencia A1.** Regla ejecutable: qué cuenta un ciclo completo y cuándo entra A1.
5. **PENDIENTE — el criterio 4, aplicabilidad.** Valor y procedimiento, como pide `07b_requisitos.md` L231.
6. **PENDIENTE — el paso de depuración.** Escrito como paso del método, con su lugar en la secuencia y su registro (`DEC-75`, `P4`).

**Cadena de cierre que se desata al pasar de 0 de 6 a 6 de 6:** E7c cierra → **se ejecutan los cinco pasos de §4.2** con la referencia ya fijada → **se registra `θ` con su sello de fecha** → se vuelca al criterio 2 de `02_delimitacion.md` → **el punto 3 del gate de E7b pasa a cumplido → E7b cierra 4 de 4**.

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
- **P2 — Las 38 969 celdas.** (a) depurar / (b) declarar / (c) medir y decidir. **MEDIDA Y CENSADA — `A2.3.d` y `A2.3.e`, `DEC-96` y `DEC-97`. La rama (c) se cumplió.** ***La rectificación de lectura, puesta primero porque es lo que cambia la decisión:*** `A2.3.d` midió **mediana 5,666667** contra **0,434783** del resto —**13,0 veces**, sobre el umbral de 2× fijado antes de correr—, **pero midió a 541 celdas y el censo de `A2.3.e` reveló que la clase es de 2 758**: **541 con valor —19,62 %— · 2 158 en A1 —78,24 %— · 59 sin `referencia` —2,14 %—, y las nueve filas suman 264 384 exacto.** **O sea que `13,0×` describe a una quinta parte de la clase y no a la clase, y se declara así.** ***Pero el dato que decide no es esa proporción: las otras 2 217 celdas con índice cero ya estaban fuera del cálculo por reglas ajenas a esta decisión —A1 y `referencia` no positiva—, de modo que la única celda con índice cero que puede generar una alerta es de las 541.*** **La cuenta de capacidad: 541 en 9 meses = 60,1 alertas/mes = 24,8 % del techo de 242** (`DEC-45`, `DEC-54`), **gastándose en lecturas que `DEC-86` ya describió como incoherentes —índice en cero con consumo 86,7 veces el del resto—.** **QUEDA POR DECIDIR, Y ES EL ÚNICO BLOQUEO DEL PUNTO 2: (a) depurar o (b) declarar.** *Abierta el 27 oct 2026 (`DEC-81`), reprogramada al 28 oct (`DEC-87`).*
- **P3 — El estadístico de la referencia.** (a) media aritmética de los mismos meses de los años anteriores / (b) mediana / (c) el año anterior solamente / (d) se decide al ver cuál de (a) o (b) es menos sensible a los extremos que midió `DEC-86`. **RESUELTA el 28 oct 2026 — `P3` = (b): la mediana.** *Justificación en `DEC-90`, punto 3.*
- **P4 — El criterio 1 contra los nueve meses.** `P1` = (a) acota la detección a enero–septiembre de 2026, y la cobertura retrospectiva —criterio 1— está fijada sobre **174 procedentes y 1 053 reclamos de 57 meses**. **¿Se mide la base de 2026?** **(a)** **medir** cuántos reclamos y cuántos procedentes caen en esos nueve meses —consulta nueva, con criterio fijado antes de correr— y reevaluar el criterio 1 sobre esa ventana; **(b)** **no medir** y dejar la base de 57 meses como línea descriptiva, declarando en limitaciones que el método retroevaluable alcanza solo 9 meses; **(c)** **medir** y, si la base de 2026 es demasiado pequeña para sostener la evaluación, **reabrir `P1`** para (b). **RESUELTA el 28 oct 2026 — `P4` = (b): NO SE ABRE NINGUNA CONSULTA NUEVA.** La base de 57 meses se conserva íntegra como **caracterización empírica del problema (E6)**, y **la limitación queda escrita en `propuesta_borrador_v1.md` §10**: el **protocolo de retroevaluación algorítmica aplica sobre los nueve meses de 2026**, por disponibilidad de los cuatro ciclos previos que exige R1.2.

---

*Archivo creado el 28 oct 2026. Ningún número de este documento está inventado: cada uno trae su decisión o su consulta de origen. Las dos derivadas de §3.1 se marcan como cuenta propia y autoverifican contra `57 = 9 + 48`, que es `meses` de `A2.3.b` (`DEC-80`).*
