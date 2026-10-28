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
| **Forma de `θ` y procedimiento de calibración** | fijados, sin valor | `07b_requisitos.md` §4.1 y §4.2 |
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

**Lo que falta decidir son dos cosas, y ninguna está escrita:**

**(a) Con qué estadístico se resume el ciclo.** La media, la mediana o el año anterior solamente no están escogidos en ningún archivo, y son distintos entre sí: con consumos de la magnitud que tiene el panel —`DEC-86` mide extremos de **−1 343 050** a **39 987 040**— una media y una mediana no quedan en el mismo orden de magnitud.

**(b) Cuántos de los 57 meses pueden usar cuatro ciclos.** *Cuenta propia, no medida por consulta:* la ventana cierra el 30/9/2026 (`DEC-69`), de modo que 2026 aporta **9 meses** y cada año anterior, 12. Para el mismo mes de cada año, los años previos disponibles dentro de la ventana son:

| Año del mes a evaluar | Meses | Años previos en la ventana | Cuatro ciclos completos |
|:--|--:|:--|:--|
| 2026 | 9 | 2022 · 2023 · 2024 · 2025 | **sí** |
| 2025 | 12 | 2022 · 2023 · 2024 | no — tres |
| 2024 | 12 | 2022 · 2023 | no — dos |
| 2023 | 12 | 2022 | no — uno |
| 2022 | 12 | ninguno | no — **cero** |

**Cuadra con un dato ya verificado: 9 + 48 = 57 = `meses` de `A2.3.b` (`DEC-80`).** De ahí salen dos derivadas: **48 de 57 meses —84,2 %— no pueden usar cuatro ciclos**, y **los 12 de 2022 no tienen ningún año previo dentro de la ventana**, o sea que `referencia` no existe para ellos y `desviación` no se puede calcular.

**Consecuencia que hay que resolver aquí y no más adelante:** el `AC4` de `DEC-72` acredita que *la ventana **contiene** cuatro ciclos*, lo cual es cierto y es lo que permitió elegir A2; **pero eso no dice que cada uno de los 57 meses tenga cuatro ciclos para compararse.** Son dos afirmaciones distintas y hasta ahora se han leído como una sola.

*Pregunta de la etapa: ver §7, P1.*

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

## 5. Gate de E7c — abierto: **0 de 6**

**Se cierra esta etapa cuando se cumplan seis cosas:**

1. **PENDIENTE — la referencia anual.** Forma de `referencia` decidida: con qué estadístico, con cuántos años, y **qué pasa en cada uno de los 57 meses**. *Autocalculeo de cierre: la fórmula, tal como quedó escrita, debe poder evaluarse sobre las 1 485 556 celdas del panel sin definir ninguna variable nueva —las que no se puedan evaluar se declaran, no se rellenan.*
2. **PENDIENTE — las 38 969 celdas.** Una de las tres ramas de `DEC-81`, punto 5, **con la regla escrita ANTES de aplicarse**. *Autocalculeo de cierre: la regla aplicada deja un número de celdas y de cuentas afectadas, y ese número se registra con su consulta.*
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

- **P1 — Meses sin cuatro ciclos (48 de 57, y 12 de 2022 sin ninguno).** ¿Qué se hace con los meses que no tienen cuatro años previos en la ventana? **(a)** calcular la desviación **solo donde sí hay cuatro** —los 9 meses de 2026— y ajustar §4.2, que hoy dice *cada cuenta y cada mes*; **(b)** calcular con **los ciclos disponibles según el año** y dejar que los 12 de 2022 caigan en la contingencia A1; **(c)** **medir primero** cuántas cuentas tienen realmente cuatro ciclos completos antes de elegir entre (a) y (b). *Abierta el 28 oct 2026.*
- **P2 — Las 38 969 celdas.** (a) depurar / (b) declarar / (c) medir y decidir. **Depende de 3.1** —`DEC-86`, punto 5—: sin la referencia no está medido su lugar en el ranking. *Abierta el 27 oct 2026 (`DEC-81`), reprogramada al 28 oct (`DEC-87`).*
- **P3 — El estadístico de la referencia.** (a) media aritmética de los mismos meses de los años anteriores / (b) mediana / (c) el año anterior solamente / (d) se decide al ver cuál de (a) o (b) es menos sensible a los extremos que midió `DEC-86`. *Abierta el 28 oct 2026.*

---

*Archivo creado el 28 oct 2026. Ningún número de este documento está inventado: cada uno trae su decisión o su consulta de origen. Las dos derivadas de §3.1 se marcan como cuenta propia y autoverifican contra `57 = 9 + 48`, que es `meses` de `A2.3.b` (`DEC-80`).*
