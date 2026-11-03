# El método escrito - procedimiento de detección y verificación previa a la facturación de lecturas anómalas no declaradas

> **Archivo del artefacto.** Este documento **es** el método: no lo resume, lo contiene. Fue decidido como archivo propio el 30 de octubre de 2026 (`DEC-125`) y corresponde al **punto 1 del gate de `E7d`** (`07d_construccion.md` §6): *el método está escrito como procedimiento que un verificador ajeno pueda seguir sin la autora* (`R10.1`, `R1.4`).
>
> **Para quién está escrito:** para un verificador que **no participó del estudio** y que debe resolver cada alerta **usando solo este documento** (`07c` §3.5, criterio 4, `DEC-112`).
>
> **Condición que lo define:** `R1.4` exige que la referencia sea **recalculable a mano**, y el criterio 4 exige **100 %** de las alertas de la muestra resueltas con este documento solo. **Un método que solo su autora puede seguir no es un método: es una costumbre** (`07d_construccion.md` §3.1).
>
> **Lo que este documento NO contiene:** ninguna corrida de su ejecución. Las cifras que aparecen aquí son **valores ya fijados y ya medidos en etapas cerradas**, citados con su decisión; el listado de alertas que este método produce **todavía no existe** y es el punto 2 del gate de `E7d`.

---

## 1. Qué hace este método y para qué

**Problema que resuelve.** En el ciclo de lecturación y facturación de energía eléctrica, una lectura con consumo incoherente puede no llevar ningún código de irregularidad y ningún proceso la barre antes de facturar. La irregularidad se advierte después, cuando el usuario reclama, con plazos perentorios de 3 a 15 días hábiles y silencio administrativo positivo a favor del consumidor si la empresa no contesta (`02_delimitacion.md` §1).

**Qué produce.** Un **listado de alertas agrupadas por ruta**, ordenadas por severidad, con la explicación suficiente para que quien las reciba pueda verificarlas y cerrarlas en un registro.

**Sobre qué corre.** Sobre un **panel de 1 485 556 celdas cuenta-mes**, con **30 411 cuentas** y **57 meses**, de enero de 2022 a septiembre de 2026 (`A2.3.b`, `DEC-80`).

**Qué NO es este método:**

| **No es** | **Por qué** |
|:--|:--|
| Un clasificador supervisado | Se descartó: exige corpus etiquetado y solo hay 174 etiquetas retardadas (`07a` §A4) |
| Un umbral único global decidido a gusto | `θ` se **calibra** contra la capacidad real del equipo, no se elige (`07b` §4.2) |
| Un reemplazo del proceso manual | El proceso manual actual es **inmedible**: no tiene denominador registrado (`DEC-43`) |
| Un detector sobre los 57 meses | La detección corre **solo sobre los nueve meses de 2026** (`DEC-90`, `P1` = (a)) |

---

## 2. Precondiciones de entrada

Sin esto, el método no arranca (`R9`).

| **#** | **Precondición** | **Fuente** |
|:--|:--|:--|
| E1 | El histórico crudo está dentro de una **ventana fija**: enero de 2022 a septiembre de 2026, con **cierre obligatorio el 30/09/2026** | `R9.2`, `DEC-69` |
| E2 | El histórico **no** viene con una fila por cuenta y mes: trae duplicados que hay que colapsar | `A2.3.a`, `DEC-80` |
| E3 | Existe el **catálogo de 48 códigos de irregularidad** | `R9.4`, medido 6 oct 2026 |
| E4 | Existe el **identificador de ruta** `tfv_ruta.id_ruta`, presente y único por cuenta | `R3.4`, `CONTROL 6`, `DEC-74` |
| E5 | Las tablas son **vivas**: toda cifra que se tome de ellas lleva **sello de fecha** | `R9.3`, `DEC-55`, `DEC-64` |

---

## 3. Los pasos, en el orden exacto en que se ejecutan

**Orden fijado en `07c` §3.6 y demostrado allí:**

    depuración → segmentación → fórmula

**Es el único orden que evita clasificar celdas que después se excluyen.** Si al ejecutar apareciera un paso que no estaba en este documento, **el diseño estaba incompleto y se registra**: no se agrega en silencio (`07d_construccion.md` §3.1).

### Paso 1. Fijar la ventana y recortar el histórico

Se toma el histórico crudo y se recorta a **enero de 2022 - septiembre de 2026**. Fuera de esa ventana no entra nada. El cierre del 30/09/2026 es **obligatorio**: sin él, el panel incluiría filas posteriores al cierre de la ventana (`DEC-69`, `R9.2`).

### Paso 2. Construir el panel

Se colapsa el histórico a **una fila por cuenta y por mes**.

**Regla de colapso, fijada por la tesista (`DEC-75`, `P1` = (a)):** cuando una misma cuenta-mes aparece más de una vez, **manda la fecha más reciente**; si empata, **desempata el `id_lectura` más alto**.

**Autocalculeo de este paso:** el panel resultante tiene **1 485 556 filas** y **30 411 cuentas** (`A2.3.b`, `DEC-80`).

### Paso 3. Depurar

**Regla (`DEC-100`):** *toda celda del universo 2026 con `lec_actual = 0` se excluye del cálculo de desviación y del listado de alertas.*

| **Campo** | **Contenido** |
|:--|:--|
| **Cuándo entra** | **Después de construir el panel y antes del cálculo de desviación** |
| **Qué NO hace** | **No limpia el historial de 2022 a 2025** |
| **Qué registra** | **Cuántas celdas excluyó y de cuántas cuentas** |

**Autocalculeo ya cerrado (`A2.3.g`, `DEC-101`):** excluye **541 celdas de 411 cuentas** de un universo calculable de **183 541 celdas** y **22 978 cuentas** —0,29 % de las celdas—.

**Por qué se depura:** el consumo de las celdas con lectura es **86,7 veces mayor** que el de las de índice cero, así que dejarlas dentro del cálculo arrastraría los promedios hacia cero y produciría desviaciones artificiales (`DEC-86`, `DEC-97`).

### Paso 4. Segmentar

**Rol (`DEC-103`, `P3`):** la segmentación es **caracterización previa que viaja con la alerta**. **No fija `θ` y no sustituye la referencia.** **No cambia qué celdas alertan** (`R7`).

**Eje 1 - perfil de consumo:** **mediana del consumo mensual por cuenta, sobre los 57 meses**, dividida en **cuatro bandas por cuartiles** con la regla fijada antes de correr (`DEC-104`):

| **Banda** | **Rango** |
|:--|:--|
| 1 | `0` a `26` |
| 2 | `27` a `69` |
| 3 | `70` a `135` |
| 4 | **más de `135`** - sin techo superior, llega hasta el máximo del panel |

**Eje 2 - familia de código:** `tfv_lectura.tipo_lectura` de la lectura de esa celda, enlazando por `id_lectura`, en **tres bandas** (`DEC-105`):

| **Banda** | **Contenido** | **Celdas** |
|:--|:--|--:|
| 0 | no facturada | 15 075 |
| 1 | lectura normal sin código | 167 036 |
| 2 | con código | 1 430 |

**Lo que la segmentación no hace, declarado:** no puede fijar `θ` —exigiría reescribir la calibración entera—, y no puede sustituir la referencia: **A3 perdió contra A2** como criterio principal, y **quedó en pie su premisa y no su mecanismo** (`DEC-70`, `DEC-103`).

### Paso 5. Calcular la referencia

**Para cada cuenta `c` y cada mes `m` del año:**

    referencia(c, m) = mediana { consumo(c, m, 2022), consumo(c, m, 2023),
                                  consumo(c, m, 2024), consumo(c, m, 2025) }

**El estadístico es la mediana** (`DEC-90`, `P3` = (b)): con consumos que van de **-1 343 050** a **39 987 040** (`DEC-86`), **un solo valor extremo arrastraría el promedio**, y la mediana resiste eso.

**Con exactamente cuatro valores, la mediana es el promedio de los dos centrales una vez ordenados los cuatro:**

    referencia(c, m) = ( v₂ + v₃ ) / 2        con v₁ ≤ v₂ ≤ v₃ ≤ v₄

**Eso es lo que la hace recalculable a mano** (`R1.4`): un verificador ordena cuatro números, suma los dos del medio y divide entre dos.

**Condición de positividad:** `referencia > 0`. **§4.1 divide entre ella**, y el panel tiene consumos negativos. Lo que no cumpla eso **se declara, no se rellena**.

**Si a la cuenta le falta alguno de los cuatro ciclos:** no entra a este paso y **cae en A1** —ventana de 6 meses, `R8.1`—, **y la alerta lo declara** (`R4.4`).

**Universo de detección:** los **nueve meses de 2026**. Sobre los otros **48 meses no se calcula `desviación`**: no se les asigna ningún valor de relleno, la detección simplemente no corre ahí (`DEC-90`, `P1` = (a)).

**Autocalculeos ya cerrados (`A2.3.c`, `DEC-96`):**

| **Salida** | **Celdas** |
|:--|--:|
| 1 valor calculado | **183 541** |
| 2 declaración A1 - le faltan ciclos | **75 319** |
| 3 declaración sin `referencia` - no positiva | **5 524** |
| 4 declaración fuera del universo | **1 221 172** |
| **Total panel** | **1 485 556** |

**Las cuatro salidas son excluyentes y suman el panel entero, sin hueco y sin solape.**

### Paso 6. Calcular la desviación

    desviación(c, m) = | consumo_observado(c, m) - referencia(c, m) | / referencia(c, m)

**En valor absoluto**, de modo que **una sola fórmula cubre las dos direcciones** (`R1.3`): un consumo anormalmente alto y uno anormalmente bajo se tratan igual.

**Escribible en una línea** (`R1.1`) y **recalculable a mano** (`R1.4`).

**Lo que esta fórmula NO es:** no es un umbral. **La fórmula produce el dato; el umbral se decide sobre él y después** (`07c` §3.1).

### Paso 7. Aplicar la contingencia A1

**Se decide mes a mes, no por cuenta entera** (`R8.1`, precisado en `DEC-111`).

| **Pregunta** | **Regla** |
|:--|:--|
| **Qué cuenta un ciclo completo** | Un año cuenta para el mes `m` si la cuenta **tiene ese mes** en ese año. **No se exigen las 12 lecturas.** |
| **Cuántos ciclos se cuentan** | `ciclos` = número de años entre 2022 y 2025 que tienen ese mes para esa cuenta |
| **Cuándo entra a A1** | `ciclos < 4` |
| **Cuándo recibe `desviación`** | `ciclos = 4` **y** `referencia > 0` |
| **Cuándo declara sin `referencia`** | `ciclos = 4` **y** `referencia = 0` - **no es A1: son tres salidas distintas** |
| **Qué ventana usa A1** | Los **últimos 6 meses** (`R8.1`) |
| **Con qué calcula su desviación** | `abs(consumo - media_6meses) / media_6meses`, en **ambas direcciones** |
| **Qué pasa si no tiene seis meses previos** | Se usan **los que existan, hasta un máximo de seis** (`DEC-115`) |
| **Si las celdas depuradas entran en esa media** | **No entran** (`DEC-116`) |
| **Qué declara la alerta** | Que esa celda cayó en A1 (`R4.4`), marcada como alerta originada en `R8.1` (`R8.2`) |

**Con qué umbral alerta A1:** con `θ_A1`, dentro de su cupo de **24 alertas por mes**.

**Por qué A1 nunca puede ser el criterio principal:** bajo la definición elegida, **A1 recoge 75 319 celdas —28,49 % del universo—**, de modo que **sería mayoría si mandara**; por eso `R8.3` la declara **fallback** (`DEC-110`, `DEC-111`).

### Paso 8. Aplicar los umbrales dentro de los cupos

**Los dos umbrales, con su sello (`DEC-119`, `DEC-120`):**

| **Canal** | **Umbral** | **Cupo por mes** |
|:--|--:|--:|
| `A2` - núcleo interanual, cuatro ciclos completos | **`θ_A2` = 39,666 666 666 666 7** | **218** |
| `A1` - contingencia por historial corto | **`θ_A1` = 495,362 260 343 088** | **24** |
| **Total** | - | **242** |

**Ambos son el máximo de los nueve cortes**, no el mínimo: el mínimo habría podido superar 242 en algún mes y chocar con `R2.2` (`07b` §4.2).

**El techo no se divide: se divide el derecho a emitir dentro de él** (`DEC-114`). **`R2.1` sigue en 242 y sigue inviolable.**

**Si un mes produce más de 242 alertas, NO se sube el techo: se sube `θ`** (`R2.2`). El procedimiento para recalcular `θ` está en `07b` §4.2, y son **los ocho pasos** que este método ejecuta como calibración:

1. Calcular `desviación` para cada cuenta y cada mes de 2026.
2. Ordenarlas de mayor a menor.
3. Recorrer el orden **hasta acumular 218 alertas por mes**.
4. **`θ_A2` es el valor en el corte.**
5. Verificar que `θ_A2` es **único y estable**: si diera un resultado distinto entre meses, se fija como el **máximo —el más estricto—** y se declara.
6. Calcular la desviación de `A1` para cada celda que entró a ella, contra la media de los meses previos disponibles —hasta un máximo de seis, sin incluir las celdas con `lec_actual = 0`, y solo cuando sea positiva—.
7. Ordenarlas de mayor a menor y recorrer el orden **hasta acumular 24 alertas por mes**.
8. **`θ_A1` es el valor en el corte**, y se somete a la misma verificación de unicidad y estabilidad del paso 5.

**Esos ocho pasos ya se ejecutaron dos veces** —para calibrar `θ_A2` en `A2.3.l` y `θ_A1` en `A2.3.m`—. **Aquí se incluyen porque el método tiene que poder recalibrarse sin la autora** si el régimen de reclamos cambia.

### Paso 9. Agrupar por ruta

**La salida del método es un listado agrupado por ruta, nunca cuentas sueltas** (`R3.1`).

- **El campo con el que se agrupa es `tfv_ruta.id_ruta`** (`R3.4`, `CONTROL 6`, `DEC-74`).
- **La agrupación es parte del método y no un agregado posterior** (`R3.2`): así lo exige la nota de linaje del criterio 3.
- **Cada grupo lleva el número de cuentas y la estimación de tiempo** que implica (`R3.3`).

**Por qué por ruta:** la revisión real se hace **en equipo** —1 a 3 técnicos por oficina, 2 a 3 personas en la visita, 3 a 4 horas como tope—, y **el equipo agrupa las cuentas de una misma ruta antes de salir** (`DEC-57`, respuesta de ENDE del 22 de octubre de 2026).

**La estimación de tiempo se declara como tope y no como multiplicación** (`DEC-45`, `P3`): convertir el techo a horas daría un resultado falso, porque **3 a 4 horas por caso es máximo y no promedio**.

### Paso 10. Priorizar dentro de la ruta

- Las alertas salen **ordenadas por severidad de la desviación** (`R6.1`).
- **La prioridad opera dentro de la ruta, no a nivel global** (`R6.3`).
- **Cuando el mes supera el techo, se descarta la cola del orden, no el orden** (`R6.2`).

### Paso 11. Emitir la alerta con sus declaraciones

Ver §5 de este documento.

### Paso 12. Registrar la resolución

Ver §6 de este documento. **Sin registro, la alerta no cuenta como emitida** (`R5.3`).

---

## 4. Las fórmulas, escritas completas

**Referencia** - para cada cuenta `c` y cada mes `m`:

    referencia(c, m) = mediana { consumo(c, m, 2022), consumo(c, m, 2023),
                                  consumo(c, m, 2024), consumo(c, m, 2025) }

    con cuatro valores:  referencia(c, m) = ( v₂ + v₃ ) / 2   ,  v₁ ≤ v₂ ≤ v₃ ≤ v₄
    restricción:         referencia(c, m) > 0

**Desviación** - para cada cuenta `c` y cada mes `m` de enero a septiembre de 2026:

    desviación(c, m) = | consumo_observado(c, m) - referencia(c, m) | / referencia(c, m)

**Alerta** - con `θ` ya calibrado:

    A2:  alerta si  desviación(c, m) ≥ θ_A2      y  ciclos = 4      y  referencia > 0
    A1:  alerta si  desviación_A1(c, m) ≥ θ_A1   y  ciclos < 4

**Desviación de A1** - para las celdas con `ciclos < 4`:

    media_6meses(c, m) = media { consumo(c, m') : m' entre los meses previos disponibles,
                                 hasta un máximo de seis,  lec_actual ≠ 0 }

    desviación_A1(c, m) = | consumo_observado(c, m) - media_6meses(c, m) | / media_6meses(c, m)

    con  media_6meses(c, m) > 0

**Cupos** - por mes y por canal:

    A2 ≤ 218        A1 ≤ 24        A2 + A1 ≤ 242

**Condiciones que hacen que ninguna de estas fórmulas produzca un número sin sentido:**

| **Condición** | **Qué evita** | **Fuente** |
|:--|:--|:--|
| `referencia > 0` | División entre cero y desviaciones negativas | `07c` §3.1 |
| `media_6meses > 0` | Mismo caso dentro de A1 | `07c` §3.4 |
| `lec_actual ≠ 0` en la media de A1 | Arrastre hacia cero de un consumo 86,7 veces menor | `DEC-116` |
| `ciclos` contado **por cuenta y mes** | Exigir 12 lecturas y dejar sin cobertura a cuentas nuevas | `DEC-111`, `DEC-110` |

---

## 5. Lo que la alerta declara

**Ninguna alerta sale sin estos campos** (`R4`):

| **Campo** | **Contenido** | **Requisito** |
|:--|:--|:--|
| Cuenta y mes | Qué celda alertó | `R4.1` |
| Referencia usada | Contra qué valor se comparó, **qué meses la formaron y cuántos había** | `R4.1`, `R4.2` |
| Dirección y magnitud | En qué sentido se desvió y cuánto | `R4.1` |
| Código de irregularidad | Si la cuenta tenía o no | `R4.3` |
| Contingencia | Si cayó en **A1** por no tener cuatro ciclos, **lo dice** | `R4.4`, `R8.2` |
| Segmentación | Perfil de consumo y familia de código, **como caracterización que viaja** | `DEC-103` |
| Ruta | `tfv_ruta.id_ruta` | `R3.1`, `R3.4` |
| Orden | Severidad de la desviación | `R6.1` |
| Registro | **confirmada / descartada / pendiente**, con criterio y evidencia | `R5.1`, `R5.2` |

**Cuatro reglas que no se pueden omitir:**

- **La agrupación por ruta es parte del método**, no un `GROUP BY` de última hora (`R3.2`).
- **La prioridad opera dentro de la ruta, no a nivel global** (`R6.3`).
- **Si el mes supera el techo, se descarta la cola del orden y no el orden** (`R6.2`).
- **Ninguna alerta usa un acrónimo ni una sigla que el verificador no pueda leer en el sistema** (`R4.5`).

---

## 6. El registro

**Regla mínima:** sin registro, **la alerta no cuenta como emitida** (`R5.3`), y **el registro de las descartadas es obligatorio** (`R5.4`).

| **Campo** | **Contenido** |
|:--|:--|
| Estado | **confirmada** / **descartada** / **pendiente** - sin estado vacío (`R5.1`) |
| Criterio | Qué regla se aplicó para cerrarla (`R5.2`) |
| Evidencia | Qué dato la sustenta (`R5.2`) |

**Por qué el registro es entregable del método y no un trámite posterior:** `R5.4` es la que desbloquea el **criterio 2** del estudio. La línea base de falsos positivos es **inmedible** porque la revisión en pantalla no tiene denominador registrado (`DEC-43`). **Ese vacío lo llena el método, no el estudio** (`07d_construccion.md` §3.4).

---

## 7. Qué debe devolver el método si se ejecuta

**Autocalculeos.** Se escriben **antes** de ejecutar, como en todo el proyecto. Ningún resultado entra a ningún documento sin su consulta y su fuente (`DEC-13`).

**Ya cerrados por corridas anteriores** -no se rehacen, se citan con su decisión:

| **#** | **Autocalculeo** | **Valor** | **Corrida** |
|--:|:--|--:|:--|
| 1 | Las cuatro salidas de la referencia suman el panel entero | **1 485 556** | `A2.3.c`, `DEC-96` |
| 2 | Celdas excluidas por la depuración / cuentas | **541 / 411** | `A2.3.g`, `DEC-101` |
| 3 | Universo calculable antes y después de depurar | **183 541 → 183 000** | `A2.3.g`, `DEC-101` |
| 4 | Alertas de `A2` en los nueve meses | **1 406** | `A2.3.n` |
| 5 | Alertas de `A1` en los nueve meses | **114** | `A2.3.n` |
| 6 | Alertas combinadas | **1 520** | `A2.3.n` |
| 7 | Máximo mensual combinado | **229 - abril** | `A2.3.n` |
| 8 | Meses que superan el techo de 242 | **0** | `A2.3.n` |
| 9 | Meses medidos | **9** | `A2.3.n` |

**Pendientes - son los que cierran el punto 2 del gate de `E7d`:**

| **#** | **Autocalculeo que debe cumplirse** | **Fuente de la exigencia** |
|--:|:--|:--|
| A | **Ningún mes supera 218 alertas de `A2` ni 24 de `A1`** | `R2.1`, `R2.5`, `DEC-114` |
| B | **Ninguna alerta queda sin ruta ni sin orden** | `R3.1`, `R6.1` |
| C | **Las cuatro salidas de la referencia siguen sumando 1 485 556** | `A2.3.c` |
| D | **La depuración excluye 541 celdas de 411 cuentas** | `A2.3.g` |

**Si alguno de estos cuatro no cierra, el método no está construido: está propuesto.**

---

## 8. Límites que este método declara

**Se declaran en lugar de esconderlos, y ninguno se corrige dentro de la construcción.**

| **Límite** | **Alcance** | **Fuente** |
|:--|:--|:--|
| **Referencia construida sobre ciclos corruptos** | **1,71 % de los grupos** -6 004 de 350 443- se construyen sobre dos o más ciclos con `lec_actual = 0`, de modo que su mediana no es robusta | `DEC-100` |
| **La banda 4 de perfil no tiene techo** | Va de `135` hasta el máximo del panel: un rango interno de más de siete mil veces. Los cuartiles garantizan **población** equitativa y no **anchura** | `DEC-104` |
| **La banda "con código" es chica** | **1 430 celdas, 0,78 %**. No se fusiona con ninguna otra por ser chica | `DEC-105` |
| **Los cortes de perfil se midieron antes de la depuración** | `A2.3.h` corrió sobre el panel sin depurar; la ejecución real los calcularía después. **No se rehace la medición** | `07c` §3.6 |
| **48 de 57 meses no reciben desviación** | La detección corre solo sobre 2026; los otros meses quedan **fuera del universo**, con declaración y no con relleno | `DEC-90` |
| **Un año incompleto sigue contando** | Bajo la definición elegida, un año con 8 meses cuenta para los 8 meses que sí tiene | `DEC-111` |
| **El techo 242 sostiene mientras 2026 siga en régimen vigente** | En 2025 el promedio era **800,3/mes**. Si el régimen cambia, `R2.1` se reabre | `DEC-45`, salvedad (b) |

---

## 9. Trazabilidad: qué obliga a cada paso

| **Paso** | **Requisito principal** | **Decisión que lo fija** |
|:--|:--|:--|
| 1. Ventana | `R9.1`, `R9.2` | `DEC-69`, `DEC-80` |
| 2. Panel | `R9.1` | `DEC-75` `P1` = (a), `DEC-80` |
| 3. Depuración | `R9.1` | `DEC-75` `P4`, `DEC-98`, `DEC-100`, `DEC-101` |
| 4. Segmentación | `R7.1`, `R7.2` | `DEC-103`, `DEC-104`, `DEC-105` |
| 5. Referencia | `R1.2`, `R1.4` | `DEC-90` `P3` = (b) y `P1` = (a), `DEC-96` |
| 6. Desviación | `R1.1`, `R1.3` | `07b` §4.1, `DEC-96` |
| 7. Contingencia A1 | `R8.1`, `R8.2`, `R8.3`, `R4.4` | `DEC-110`, `DEC-111`, `DEC-115`, `DEC-116` |
| 8. Umbrales y cupos | `R2.1`, `R2.2`, `R2.5` | `DEC-114`, `DEC-119`, `DEC-120` |
| 9. Ruta | `R3.1`, `R3.2`, `R3.3`, `R3.4` | `DEC-57`, `DEC-74` |
| 10. Priorización | `R6.1`, `R6.2`, `R6.3` | `DEC-45` `P3` |
| 11. Declaraciones | `R4.1` a `R4.5` | `DEC-103` |
| 12. Registro | `R5.1` a `R5.4` | `DEC-43`, `DEC-13` |

---

**Estado del documento:** escrito el 3 de noviembre de 2026. **Punto 1 del gate de `E7d`.** **Los puntos 2, 3, 4, 5 y 6 siguen pendientes**: exigen el listado de alertas, que todavía no existe (`07d_construccion.md` §6, actualización `DEC-125`).
