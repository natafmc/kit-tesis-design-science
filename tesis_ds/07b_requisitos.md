# E7b — Requisitos del artefacto

> **Borrador abierto el 25 de octubre de 2026, versión v1. Gate CERRADO — 4 de 4, el 30 de octubre de 2026: puntos 1 (DEC-70), 2 (DEC-80), 4 (DEC-74) y 3, `θ` (DEC-121).**
>
> **Hipótesis de trabajo autorizada por la tesista el 25 oct 2026:** *«sí, avanza»* — E7b se redacta tomando **A2 (ciclo anual por cuenta)** como criterio de detección. **La selección de E7a se confirmó el 25 oct 2026 (DEC-70): A2 es el criterio principal, con A1 como contingencia y A3 como paso previo, y la tipología se mantiene en `método`.** La condición de reabrirla —*si el gate de E7a cambia la alternativa, se reabre esta etapa y se revisan los requisitos marcados con ◆*— **no se activó: no se reabren `R1.2`, `R3.1`, `R6.3`, `R8` ni `R9`.**
>
> **Insumos:** `07a_alternativas.md` (E7a, v1), `04_marco_teorico.md` §3.1, §3.3, §3.4, §3.5, §3.6 y §8, `02_delimitacion.md` §1 —los cuatro criterios de éxito y la nota de linaje del criterio 3—, `DEC-45`, `DEC-57`, `DEC-62`, `DEC-64` y `DEC-65`.

---

## 1. Qué decide esta etapa y qué no

| Decisión | Etapa | Condición que la constriñe |
|:--|:--|:--|
| **Valor numérico del umbral `θ`** | **E7b** | Debe ser **escrito y reproducible** (E4 §3.1) y el **criterio 3 lo limita por volumen** (E4 §3.4) |
| **Valor del criterio 2 — falsos positivos** | **E7b** | Volcado pendiente en `02_delimitacion.md` línea 49: **[valor numérico: pendiente de E7b]** |
| Formato de la explicación obligatoria | **E7b** | E4 §3.5 la hace requisito, no estilo |
| Registro de resolución | **E7b** | E4 §3.5 y propuesta §7 |
| Agrupación por ruta | **E7b** | **DEC-57**: la revisión es por ruta y en equipo |
| Diseño de los pasos, fórmulas y secuencia | E7c | — |
| Construcción y versiones | E7d | — |

**Lo que esta etapa NO hace:** no diseña los pasos del método —eso es E7c—, no corre ninguna consulta sobre el panel —`A2.3.a` sigue **sin correr**—, y **no inventa ningún número**: donde falta dato, se fija el **procedimiento que lo produce** y se deja marcado el valor, con la restricción que debe cumplir.

---

## 2. Los cuatro momentos que los requisitos deben sostener

Los requisitos no cuelgan del aire: sostienen la solución conceptual ya aprobada en `02_delimitacion.md` §1.

| # | Momento del método | Requisitos que le corresponden |
|:--|:--|:--|
| 1 | **Segmentación** del histórico por perfil de consumo y familia de código | **R7**, **R9** |
| 2 | **Detección** de desviaciones sobre el consumo esperado, con y sin código | **R1**, **R2**, **R6**, **R8** |
| 3 | **Verificación humana** dentro de la cadena vigente | **R3**, **R4** |
| 4 | **Resolución y registro** que alimente el ciclo siguiente | **R5** |

---

## 3. Requisitos

Convención: **F = fijado** — no depende de nada pendiente. ◆ **= depende de que cierre E7a**. **P = valor pendiente**, con procedimiento fijado.

### R1 — El criterio debe ser escrito y reproducible ◆ F

*(E4 §3.1: «Mientras no haya umbral escrito, no hay detección: hay juicio».)*

| ID | Requisito | Estado |
|:--|:--|:--|
| R1.1 | La regla de detección se escribe **antes** de aplicarla. No puede quedar en criterio de una persona | F |
| R1.2 | El método compara el consumo de la cuenta contra **su propio ciclo anual** —el mismo mes de los años anteriores— | ◆ **F (A2)** |
| R1.3 | La comparación se evalúa **en ambas direcciones**: desviación superior e inferior | F — regla vigente ya era en ambas direcciones |
| R1.4 | Un verificador que no participó del estudio debe poder **recalcular** la alerta con los datos que se le entregan y obtener el mismo resultado | F |
| R1.5 | La alerta se emite sobre lecturas **con y sin código de irregularidad** | F — Opción 2, decisión de la tesista 26 sep 2026 |

**Consecuencia de R1.2 sobre E7c:** la referencia se calcula con **cuatro ciclos anuales completos** (E4 §4.2). Si `A2.3.a` muestra que el histórico **no** alcanza cuatro ciclos, **R1.2 no se puede cumplir como está escrita** y E7a se reabre: la contingencia A1 gana terreno.

### R2 — La capacidad es un techo, no un objetivo ◆ F (el techo) / P (el valor)

*(E4 §3.4: el criterio 3 **no es un criterio de comodidad, es el criterio de viabilidad**.)*

| ID | Requisito | Estado |
|:--|:--|:--|
| R2.1 | El método **no puede emitir más de 242 alertas por mes** (≈ 11 por día) | **F** — DEC-45, 19 oct 2026 |
| R2.2 | Si en un mes el criterio produce más de 242, **no se sube el techo**: se sube el umbral `θ` | F |
| R2.3 | El techo se entiende **por ruta**, no por cuenta — véase R3 | ◆ F |
| R2.4 | El valor de `θ` se calibra de modo que la salida mensual promedio **quede en o bajo 242** | **P** — procedimiento en §4 |
| R2.5 | El techo **no se divide: se divide el derecho a emitir dentro de él.** `A2` —núcleo interanual— **90 % = 218 alertas/mes**; `A1` —contingencia por historial corto— **10 % = 24 alertas/mes**; **218 + 24 = 242** | ◆ **F** — DEC-114, 29 oct 2026 |

> **Por qué hay una reserva y no un orden único (`DEC-114`).** Los dos umbrales **no se pueden calibrar por separado** —cada uno podía llenar los 242 solo, o sea 484 combinados—, pero **tampoco se pueden ordenar en un solo ranking**, porque ahí `A1` pierde siempre: su ventana son **los 6 meses previos**, que **se adapta rápido**, mientras `A2` compara contra **4 años del mismo mes**, que no se mueve —razón por la que `A1` fue descartada como criterio principal, `07a` L157—. **Las desviaciones de `A1` salen sistemáticamente más chicas y no ganarían nunca un corte compartido.** **Consecuencia silenciosa que evita la reserva:** `A1` quedaría **formalmente** dentro del techo y **prácticamente** con cero alertas, y `R8.1` —«ningún mes queda sin cobertura»— quedaría vaciado por dentro.

> **Salvedad declarada (a) de DEC-45:** los **3 a 4 h por caso** son **máximo y no promedio**, y el trabajo lo hace **un equipo** (DEC-57). Por eso el techo se expresa en alertas por mes y **no** en horas: convertirlo en horas daría un resultado falso.
>
> **Salvedad declarada (b):** el valor 242 se sostiene **mientras 2026 siga en régimen vigente**. En 2025 el promedio era **800,3/mes**. Si el régimen cambia, **R2.1 se reabre**.

### R3 — Las alertas salen agrupadas por ruta ◆ F

**Origen: DEC-57, respuesta de ENDE del 22 de octubre de 2026.** La revisión es **por ruta** y se hace en equipo — **1 a 3 técnicos por oficina**, 2 a 3 personas en la visita, **3 a 4 h como tope**—, y el equipo agrupa las cuentas de una misma ruta antes de salir.

| ID | Requisito | Estado |
|:--|:--|:--|
| R3.1 | La salida del método es un **listado de alertas agrupadas por ruta**, nunca cuentas sueltas | **F** |
| R3.2 | La agrupación es **parte del método y no un agregado posterior** — así lo exige la nota de linaje del criterio 3 | **F** |
| R3.3 | Cada grupo lleva el **número de cuentas** y la **estimación de tiempo** que implica | **F** |
| R3.4 | El campo con el que se agrupa —la ruta— **debe existir en el dato** y su identificador se fija en E7c | **F — verificado con el `CONTROL 6`, 25 oct 2026 (DEC-74).** **Existencia:** `tfv_ruta.id_ruta` y `tfv_cliente.id_ruta` + `nro_cuenta`, ambas presentes. **Unicidad:** 38 339 filas = 38 339 cuentas —1:1— y **0 cuentas con más de una ruta**, `max_rutas_por_cuenta = 1`. **Cobertura:** del panel salen **30 411 cuentas, 0 sin fila en `tfv_cliente` y 0 sin `id_ruta`**, y los cuatro cubos cierran exactos. **Reparto:** **58 rutas** y la suma de cuentas da **30 411**, exacto. **Identificador fijado: `tfv_ruta.id_ruta`.** `tfv_cliente` es **tabla viva**, así que 38 339 y 30 411 llevan fecha de corrida. |

**Regla de desempate fijada por la tesista el 25 oct 2026 — `DEC-71` — y confirmada como INNECESARIA.** La regla decía: si una cuenta aparece con **más de una ruta**, **manda la ruta vigente en `tfv_cliente`**. **La `6.c` midió 0 cuentas en esa situación y `max_rutas_por_cuenta = 1`**, así que **la regla queda escrita y NO SE ACTIVA** —se conserva porque `tfv_cliente` es tabla viva y mañana puede dejar de serlo—. **Y la `6.a` confirmó además que sí habría sido aplicable: `tfv_cliente` tiene `sw_bajadef` —`'no'` es activo, `'si'` está de baja—, que es exactamente el campo de vigencia que la regla necesitaba.** Había dos formas de fallar —que la ruta no existiera y que no estuviera definida cuál manda—; **ninguna de las dos ocurre.**

### R4 — Cada alerta lleva su explicación ◆ F

*(E4 §3.5, sobre Nwafor et al. (2023) y Noorchenarboo y Grolinger (2025): quien verifica no puede adoptar una alerta que no entiende.)*

| ID | Requisito | Estado |
|:--|:--|:--|
| R4.1 | Toda alerta declara **contra qué referencia se comparó, en qué dirección se desvió y cuánto** | **F** |
| R4.2 | Declara además **la ventana concreta**: qué meses formaron la referencia y cuántos había | **F** |
| R4.3 | Declara si la cuenta tenía **código de irregularidad** o no | **F** |
| R4.4 | Si la cuenta cayó en la **regla de contingencia A1** por no tener cuatro ciclos, la alerta lo dice | ◆ **F** |
| R4.5 | Ninguna alerta usa un acrónimo ni una sigla que el verificador no pueda leer en el sistema | **F** — regla institucional del resumen, aplicada aquí por coherencia |

### R5 — Toda alerta termina en un registro ◆ F

*(E4 §3.5: la resolución se registra **con su criterio y su evidencia**.)*

| ID | Requisito | Estado |
|:--|:--|:--|
| R5.1 | Cada alerta cierra con **confirmada**, **descartada** o **pendiente** — sin estado vacío | **F** |
| R5.2 | El cierre registra **el criterio aplicado y la evidencia** que lo sustenta | **F** |
| R5.3 | El registro alimenta el ciclo siguiente: **sin registro, la alerta no cuenta como emitida** | **F** — regla de trazabilidad del estudio, DEC-13 |
| R5.4 | El registro de las alertas **descartadas** es obligatorio: es de donde sale el criterio 2 | **F** |

**R5.4 es la que desbloquea el criterio 2.** Hoy la línea base de falsos positivos es **inmedible** porque la revisión en pantalla no tiene denominador registrado (DEC-43). **Ese vacío lo llena el método, no el estudio.**

### R6 — La priorización es parte del método ◆ F

*(E4 §3.6: Guerrero et al. (2018); Massaferro et al. (2020); Xia et al. (2020). «La priorización es parte del método, no un refinamiento posterior».)*

| ID | Requisito | Estado |
|:--|:--|:--|
| R6.1 | Las alertas salen **ordenadas por severidad de la desviación** | **F** |
| R6.2 | Cuando el mes supera el techo de R2.1, **se descarta la cola del orden**, no el orden | **F** |
| R6.3 | La prioridad opera **dentro de la ruta** (R3), no a nivel global | ◆ **F** |

### R7 — La segmentación precede a la detección ◆ F

*(E4 §4.1, sobre Piscitelli et al. (2026); ya declarada en la propuesta §7.)*

| ID | Requisito | Estado |
|:--|:--|:--|
| R7.1 | El histórico se segmenta **antes** de detectar | **F** |
| R7.2 | Los ejes de segmentación son **perfil de consumo** y **familia de código** | **F** |
| R7.3 | La definición concreta de los segmentos se fija en **E7c** | **P** |

**R7 no compite con R1.2:** la segmentación es el **paso previo** y la comparación contra el ciclo anual es el **criterio dentro** de cada segmento. Es exactamente la reclasificación que hizo E7a de la alternativa A3.

### R8 — Regla de contingencia ◆ F

Derivada de la alternativa **A1** descartada como criterio principal en E7a.

| ID | Requisito | Estado |
|:--|:--|:--|
| R8.1 | **Se decide mes a mes:** cuando para un mes la cuenta tiene **menos de cuatro ciclos**, ese mes no queda sin cobertura y se evalúa con la ventana de los **últimos 6 meses**. **Ninguna cuenta completa queda fuera: la carencia se resuelve por mes y no por cuenta entera** | ◆ **F** |
| R8.2 | Una alerta originada por R8.1 **se marca como tal** — véase R4.4 | **F** |
| R8.3 | R8.1 **nunca** puede ser el criterio principal: es fallback | **F** |

**Redacción de `R8.1` precisada en su unidad el 29 oct 2026 (`DEC-111`).** **Texto original, conservado:** *«Las cuentas con menos de cuatro ciclos no quedan sin cobertura: se evalúan con la ventana de los últimos 6 meses.»* **Se cambió solo la unidad, no la promesa.** **La fórmula de `07c` §3.1 decide POR CUENTA Y MES, de modo que una misma cuenta puede estar en A1 en unos meses y no en otros** —`07c_diseno_artefacto.md` ya lo normalizaba: *«una cuenta puede caer en más de un grupo… no es una contradicción, es lo normal»*—. **Que el requisito dijera «cuentas» dejaba la regla leíéndose más estricta de lo que es, sin que por eso cambiara a quién protege.** **La promesa NO cambia: ninguna cuenta queda sin cobertura, y la ventana sigue siendo la de los últimos 6 meses.** `R8.2` y `R8.3` **quedan intactos.**

### R9 — Precondiciones de entrada ◆ F

Sin esto, el método no arranca.

| ID | Requisito | Estado |
|:--|:--|:--|
| R9.1 | El método recibe el **histórico crudo** dentro de una **ventana fija** y lo depura él mismo —**la depuración es paso del método**, `DEC-75` `P4` (a)— | **CUMPLIDO — 27 oct 2026, `A2.3.b` corrido y verificado (DEC-80).** **`A2.3.a` midió que el crudo NO da una fila por cuenta y mes: 5 619 filas de más.** **`A2.3.b` aplicó la regla de `P1` —manda la fecha más reciente, desempata `id_lectura` más alto— y sus doce autocalculeos cerraron:** **`filas_de_mas` = 0** ✓, **`cuentas` = 30 411** ✓, `filas_originales` 1 491 175 = `filas_ventana` de `A2.3.a`, `filas_colapsadas` 5 619 = `lecturas_sobrantes` de `A2.3.a`, `filas_finales` 1 485 556 = `cuentas_mes_distintas`. **El contrato «una fila por cuenta y mes» se cumple POR CONSTRUCCIÓN y no por declaración.** Ver §4.3 |
| R9.2 | El histórico cubre **enero de 2022 a septiembre de 2026**: ventana **fija**, con **cierre obligatorio el 30/09/2026** | **CUMPLIDO — 27 oct 2026, `A2.3.b` corrido y verificado (DEC-80).** **Cierre confirmado el 25 oct (DEC-72): 1 491 175 con cierre contra 1 519 833 sin cierre, Δ 28 658 = la lecturación de octubre.** **El autocalculeo que faltaba cerró: `meses` = 57** ✓ —los 57 meses efectivamente cubiertos, no solo el filtro correcto—, **y los dos extremos quedan medidos y no supuestos:** **`fecha_minima` = 14/1/2022** ≥ 1/1/2022 **—la fila de año 0023 no entró, que era el temor del `7.e`—** y **`fecha_maxima` = 22/9/2026** ≤ 30/9/2026 —**el cierre obligatorio de DEC-69**—. **Cierre añadido por DEC-69:** la tesis cubre 57 meses y la lecturación de octubre está en curso, de modo que «a la fecha de corrida» era un blanco móvil —un panel sin cierre no es reproducible, y una desviación contra un panel que cambió ayer no es auditable— |
| R9.3 | Las tablas son **vivas**: toda cifra lleva **sello de fecha** | **F** — DEC-55, DEC-64 |
| R9.4 | El catálogo de 48 códigos de irregularidad está disponible | **F** — medido 6 oct 2026 |

### R10 — Aplicabilidad ◆ F

| ID | Requisito | Estado |
|:--|:--|:--|
| R10.1 | El equipo técnico sigue el método **sin asistencia de la autora** | **F** |
| R10.2 | Esto es lo que mide el **criterio 4**, **fijado el 29 oct 2026 (`DEC-112`)** | **F** — **valor y procedimiento fijados**; medición pendiente de E7f/E8 |

---

## 4. El umbral `θ`: forma, calibración y valor

### 4.1 Forma — **F**

`θ` compara el consumo observado contra la referencia del ciclo anual, **en valor absoluto**, de modo que una sola fórmula cubre las dos direcciones de R1.3:

```
desviación = abs(consumo_observado − referencia) / referencia
alerta     si desviación ≥ θ
```

- **Escribible en una línea** (R1.1).
- **Recalculable a mano** por un verificador con los números en pantalla (R1.4).
- **Simétrica**: un consumo anormalmente alto y uno anormalmente bajo se tratan igual, como ya hacía la regla vigente.

### 4.2 Calibración — **F**

**Procedimiento fijado aquí, ejecutable en cuanto exista el panel — DOS calibraciones sobre UN presupuesto (`R2.5`):**

**A2 — el núcleo interanual, 218 alertas por mes:**

1. Calcular `desviación` para **cada cuenta y cada mes de 2026** —enero a septiembre, los únicos con cuatro ciclos previos completos dentro de la ventana—, tomando `referencia` como la **mediana** de esa cuenta en ese mismo mes de 2022 a 2025. Las dos decisiones que faltaban están en `DEC-90`: `P1` = (a) y `P3` = (b). **Las cuentas que no tengan los cuatro ciclos no entran a este paso: caen en A1 (R8.1).** **Los 48 meses de 2022 a 2025 no reciben `desviación`: la detección no corre sobre ellos.**
2. Ordenarlas de mayor a menor.
3. Recorrer el orden **hasta acumular 218 alertas por mes** — el cupo de `A2` (`R2.5`).
4. **`θ_A2` es el valor en el corte.**
5. Verificar que `θ_A2` es **único y estable**: si diera un resultado distinto entre meses, se fija como el **máximo —el más estricto—** y se declara.

**A1 — la contingencia por historial corto, 24 alertas por mes:**

6. Calcular la desviación de `A1` **para cada celda que entró a ella —`ciclos < 4`—**, contra la **media de los meses previos disponibles —hasta un máximo de seis, sin incluir en esa media las celdas con `lec_actual = 0`, y solo cuando esa media sea positiva—**, en **ambas direcciones**: `abs(consumo − media_6meses) / media_6meses`. *Regla traída de `07a` L85-L87, donde ya estaba escrita y nunca se había llevado al diseño.*
7. Ordenarlas de mayor a menor y recorrer el orden **hasta acumular 24 alertas por mes** — el cupo de `A1` (`R2.5`).
8. **`θ_A1` es el valor en el corte**, y se somete a la misma verificación de unicidad y estabilidad del paso 5.

**Las dos salidas suman 242 y ninguna puede superarlo: `R2.1` sigue inviolable.** **No se dividió el techo —se dividió el derecho a emitir dentro de él— (`DEC-114`).**

> **Dos cambios hechos el 29 oct 2026, con el texto original conservado:**
>
> - **Paso 3, original:** *«Recorrer el orden hasta acumular **242** alertas por mes — el techo de `R2.1`.»* → **queda 218**, porque `R2.5` reserva 24 para `A1`. **`R2.1` no se tocó: sigue en 242 y sigue inviolable.** **Razón: calibrados por separado, los dos umbrales podían llenar los 242 cada uno —484 combinados—.**
> - **Paso 5, original:** *«se fija `θ` como el **peor** —el que produce más alertas— y se declara.»* → **queda el máximo, el más estricto.** **Razón: el mínimo habría podido superar 242 en algún mes y chocaría con `R2.2` —«no se sube el techo: se sube `θ`»—.** *Decisión de la tesista, 29 oct 2026.*

> **Tres cambios hechos el 30 oct 2026 al paso 6, con el texto original conservado junto al nuevo. Los tres cierran el mismo hueco: `A1` recoge cuentas nuevas —`07a` L159— y una cuenta nueva puede no tener seis meses previos, cosa que el paso asumía sin verificar.**
>
> - **Ventana incompleta — `DEC-115`, opción (a).** **Original:** *«contra la **media de los seis meses anteriores**».* → **queda: la media de los meses previos que existan, hasta un máximo de seis.** Una cuenta con dos meses previos se compara contra la media de esos dos y sigue siendo alertable. **Por qué no exigir los seis completos: eso habría dejado sin desviación a las cuentas nuevas, que es exactamente la población a la que `A1` existe para cobrir, y `R8.1`◆F —«ningún mes queda sin cobertura»— habría quedado vaciado por dentro, la misma falla silenciosa que `DEC-114` evitó repartiendo el cupo.**
> - **Celdas depuradas dentro de la ventana — `DEC-116`, opción (a).** **Original:** *«la **media** de los seis meses anteriores».* → **queda: esa media se calcula sin las celdas con `lec_actual = 0`.** **Fundamento medido: el consumo de las celdas con lectura es 86,7 veces mayor**, de modo que dejar dentro las de índice cero arrastraría la media hacia cero y dispararía desviaciones artificiales —el método alertaría por arte del cero y no por anomalía real. **Lo que se declara y no se disimula:** `DEC-101` protegió el histórico de la **depuración**, y aquí se excluye del **cálculo** de una media. No es la misma operación, pero sí es un segundo efecto sobre el mismo dato, y por eso queda escrito en §10 de la propuesta junto a la carencia por año de `DEC-111`.
> - **Media positiva — la regla que hacía falta escribir.** El paso divide por `media_6meses`; si una cuenta tuviera cero consumo en todos los meses previos disponibles, el cociente no existe. **Se aplica la misma regla que ya gobierna a `A2` con `referencia > 0` (`DEC-90`): media positiva para recibir desviación; si no, declaración.** No hay relleno de ningún tipo.
>
> *Las dos primeras, decisión de la tesista el 30 oct 2026. La tercera no es una decisión nueva: es la aplicación al paso 6 de una regla ya fijada para `A2`. Las dos consultas que ejecutan este procedimiento están escritas en `sql_a2_extraccion.sql` —`A2.3.l` para los pasos 1 a 5 y `A2.3.m` para los 6 a 8—, con sus autocalculeos escritos antes de correrlas.*

**Alcance de esta calibración, fijado por `DEC-90`:** los ocho pasos corren sobre los **nueve meses de 2026** —la detección no corre sobre los otros 48—, así que `θ_A2` y `θ_A1` se calibran con esos nueve y el paso 5 resuelve la variación **entre ellos**. **Los datos de segmentación no se acotan: siguen siendo los 57 meses.** Se acota el paso de detección, no el panel.

**Por qué este y no otro:** el criterio 3 **es** el criterio de viabilidad (E4 §3.4). Calibrar `θ` contra capacidad y no contra una intuición estadística es la única forma de que R2.1 no dependa de una persona, que es exactamente lo que hoy falla.

### 4.3 Valor — **P — BLOQUEANTE**

> **No se escribe un número aquí.** No hay panel verificado, y **inventar `θ` sería exactamente el pecado que este proyecto se ha pasado dos semanas corrigiendo**: un valor sin consulta y sin fuente.
>
> **Qué falta, en orden:**
>
> 1. ~~**Correr `A2.3.a`**~~ → **hecho el 25 oct (DEC-72): `lecturas_sobrantes = 5 619`, o sea que sí hacía falta corregir el panel.**
> 2. ~~**Corregir `A2.3` con `GROUP BY`**~~ → **regla fijada por la tesista el 26 oct (DEC-75, `P1` = (a)) — manda la fecha más reciente —, consulta `A2.3.b` escrita y CORRIDA el 27 oct (`DEC-80`): doce autocalculeos cerrando.**
> 3. **Producir el panel** —**cumplido el 27 oct 2026 (`A2.3.b`, `DEC-80`)**
> 4. **E7c — paso añadido el 28 oct 2026 (`DEC-87`).** Fijar **cómo se calcula la referencia anual con los 57 meses** y **qué hacer con los huecos de serie**, que es lo que `07a_alternativas.md` L168 le entrega a E7c. **§4.2 paso 1 no se puede escribir sin eso**, porque la fórmula de §4.1 necesita `referencia`. → **LAS DOS DECISIONES SE TOMARON EL 28 OCT 2026 (`DEC-90`):** `P3` = (b) —**la referencia es la mediana**— y `P1` = (a) —**la desviación solo se calcula en los nueve meses de 2026**—, y **con ellas §4.2 paso 1 ya quedó reescrito**. **Lo que sigue pendiente en este punto es lo otro:** **escribir la fórmula con ambas decisiones puestas** —incluida la restricción de que `referencia` **no puede ser 0 ni negativa**, porque §4.1 divide entre ella y el panel tiene consumos desde **−1 343 050** (`DEC-86`)— **y correr el autocalculeo del gate de E7c, punto 1.**
> 5. **Ejecutar los ocho pasos de §4.2** con esa referencia ya fijada.
> 6. **Registrar `θ` con su sello de fecha** y volcarlo a `02_delimitacion.md`, celda del criterio 2.
>
> **Y un condicionante que no depende de §4.2:** mientras el `7.e` no corra, **el panel es provisional en un aspecto** —si a la cuenta 110589 le falta mayo de 2023, se corrige el año y `A2.3.b` **se rehace**, porque esa fila entra al panel y cambia sus diez cifras (DEC-75, `P3` = (a))—.
>
> **Todo esto ocurre ANTES de construir** (E7d/E7e), que es la condición que impuso `02_delimitacion.md` §1: *los valores se fijan en E6 y E7b, antes de construir*.

---

## 5. La tensión que hay que nombrar antes de que aparezca sola

El criterio **2** —falsos positivos— y el criterio **3** —capacidad— **empujan en direcciones opuestas**:

- Subir `θ` → **menos alertas** → mejor capacidad, **más** falsos positivos descartados en proporción.
- Bajar `θ` → **más alertas** → mejor cobertura, **peor** capacidad.

**No se puede optimizar los dos a la vez.** Y E4 §3.4 ya fijó el desempate: *«el criterio de éxito n.º 3 no es un criterio de comodidad: es el criterio de viabilidad del artefacto. Un método que encontrara todo pero emitiera 500 alertas mensuales sería inútil en este contexto».*

> **Decisión de E7b:** **la capacidad manda.** El techo de 242 es **inviolable**; dentro de ese techo se optimiza la cobertura. Un método que prioriza mal dentro de sus 242 sigue siendo útil; uno que se pasa de 242 **no se adopta**.

**Consecuencia para el criterio 2:** con la capacidad como techo, la proporción de alertas descartadas **no puede esperarse baja**. El criterio 2 se fija como **límite de desperdicio** y no como meta de excelencia, y su valor numérico sale de §4.3 —calibrado `θ` corriendo sobre el panel—, no de una aspiración.

---

## 6. Valores de los criterios de éxito tras E7b

| # | Criterio | Valor tras esta etapa |
|:--|:--|:--|
| 1 | Cobertura retrospectiva | **Fijado** — `174 · 16,52 % · 136 · 78,16 % · 1 053`, dos fuentes independientes (DEC-64, DEC-65), sello 25 oct 2026 |
| 2 | Falsos positivos | **◆ Procedimiento FIJADO (§4.2); valor PENDIENTE del panel (§4.3)** |
| 3 | Carga de verificación | **Fijado** — **≤ 242 alertas/mes (≈ 11/día)**, DEC-45, con las dos salvedades declaradas |
| 4 | Aplicabilidad | **Fijado** — `100 %` de las alertas de la muestra, por un verificador ajeno sin asistencia de la autora; procedimiento y umbral en `07c` §3.5, DEC-112, 29 oct 2026. **Medición pendiente de E7f/E8** |

---

## 7. Consecuencias para E7c

| De E7b a E7c | Qué debe diseñar |
|:--|:--|
| R1.2 ◆ | **Forma ya decidida (`DEC-90`)**: cuatro ciclos previos, **mediana**, y **solo en los nueve meses de 2026**. **Queda de E7c** escribir la fórmula con eso puesto —con `referencia > 0`—, más qué pasa con los huecos de serie |
| R3.4 | El **campo de ruta**: cómo se identifica, dónde vive, qué pasa si una cuenta cambia de ruta |
| R7.3 | La **definición de los segmentos** — perfil de consumo × familia de código |
| R8.1 | La **implementación de la contingencia**, sin que contamine al criterio principal |
| §4.2 | El **cálculo automático de `θ`** para que sea recalculable cuando cambie el dato |
| Criterio 4 | El **procedimiento de aplicabilidad** con su valor |
| `DEC-75` `P4` | El **paso de depuración** —una fila por cuenta y mes, con la regla de colapso de `P1`—: **es parte del método** y E7c lo diseña como paso, con su regla a la vista y no escondida en una consulta |

---

## Gate de E7b — CERRADO: 4 de 4 puntos cumplidos el 30 de octubre de 2026

**Se cierra esta etapa cuando se cumplan cuatro cosas:**

1. **CUMPLIDO — 25 oct 2026, DEC-70.** **E7a cerró su gate y confirmó A2** como criterio principal, con **A1** como contingencia declarada y **A3** como paso previo del método; la tipología se mantiene en **`método`**. **La condición de reapertura —*se reabren R1.2, R3.1, R6.3, R8 y R9*— no se activó**, porque no cambió la alternativa.
2. **CUMPLIDO — 27 oct 2026, `A2.3.b` corrido y los doce autocalculeos verificados (DEC-80).** **Cómo llegó hasta aquí:** `A2.3.a` midió el 25 oct que el panel **no cumplía su contrato** —`cuentas_mes_distintas = 1 485 556` contra `filas_ventana = 1 491 175`, o sea **5 619 filas de más**, AC3 ✗—; el `CONTROL 8` las caracterizó —**3 930 con consumo idéntico y 1 689 con consumo distinto, todas de exactamente dos filas**—; la tesista fijó la regla el 26 oct —`DEC-75` `P1` = (a), **manda la lectura de fecha más reciente**—; `DEC-79` descartó que la fila de año 0023 obligara a rehacer el panel; **y el 27 oct `A2.3.b` corrió y cerró.** **Los dos que el punto exigía:** **`filas_de_mas` = 0** ✓ y **`meses` = 57** ✓. **Los seis restantes, todos contra otra corrida:** `cuentas` **30 411** = `6.d`; `filas_originales` **1 491 175** = `filas_ventana` de `A2.3.a`; `filas_colapsadas` **5 619** = `lecturas_sobrantes` de `A2.3.a` = `filas_sobrantes` del `CONTROL 8`; `filas_finales` **1 485 556** = `cuentas_mes_distintas`; `grupos_duplicados` **5 619**; `grupos_con_consumo_distinto` **1 689** = `8.a`. **Las tres sumas de control cierran:** 579 + 1 110 = 1 689 · 3 913 + 1 706 = 5 619 · 1 491 175 − 1 485 556 = 5 619. **Con esto cierran `R9.1` y `R9.2`, que estaban atados al mismo punto.** **Aclaración sobre `fecha_maxima`, porque los dos números del archivo difieren y ninguno está mal:** la de `A2.3.a` —**22/10/2026**— es `MAX(fecha_lec)` **sin filtro, sobre toda la tabla** —`sql_a2_extraccion.sql` L1065—; la de `A2.3.b` —**22/9/2026**— es el máximo **dentro de la ventana**. **La conclusión del AC4 —CUATRO ciclos anuales completos, 2022 a 2025, y con eso A2 calculable y la contingencia A1 sin activarse— queda confirmada ahora desde adentro de la ventana y no solo desde afuera.** **Dato nuevo que aportó la corrida y que conviene en E7c: la regla BAJA el consumo en 1 110 de los 1 689 grupos con conflicto —65,72 %— y lo sube en 579 —34,28 %—.**
3. **CUMPLIDO — 30 oct 2026, `θ` medido, verificado y volcado (DEC-121).** **`θ` se fija con su valor y su sello de fecha** por los ocho pasos de §4.2, y se vuelca al criterio 2 de `02_delimitacion.md`. **Paso previo obligatorio: el `7.g` —`sql_a2_extraccion.sql` L1346—.** El `7.f` midió **39 064 filas con `lec_actual = 0` dentro de la ventana** —2,62 % de las 1 491 175 de ventana, un caso aislado de más—, y **el umbral se calibra contra desviaciones calculadas sobre el `consumo` del panel: mientras no se sepa cuántas celdas ganan una de esas filas después del colapso y cómo es su consumo, el `θ` se estaría fijando sobre datos que pueden no ser consumos.** **Autocalculeo único y obligatorio del `7.g`: `celdas_total` = 1 485 556** —la misma cifra que `filas_finales` de `A2.3.b`—. *Las opciones sobre qué hacer con esas celdas quedan registradas en DEC-81, punto 5, y no se eligen hasta ver el dato.* → **`7.g` CORRIDO EL 27 OCT 2026 (`DEC-86`): el autocalculeo cerró** —`celdas_total` = 1 485 556— **y el dato salió: 38 969 celdas, 8 728 cuentas —28,70 %—, los 57 meses, y un consumo 86,7 veces mayor que el del resto.** El criterio escrito antes de correr **quedó activado** —se despegaron, luego no se calibra—. **SEGUNDO PASO PREVIO, AÑADIDO EL 28 OCT 2026 (`DEC-87`): E7C.** **§4.2 paso 1 pide calcular `desviación` para cada cuenta y cada mes, y `desviación` necesita `referencia`; quién decide cómo se calcula esa referencia es E7c, según `07a_alternativas.md` L168.** **De modo que este punto se cierra DESPUÉS de E7c, y no se rompe la regla de fijar los valores antes de construir: `07b` §4.3 lo dice literalmente —construir es `E7d`/`E7e`— y E7c no construye.** **Avance del 28 oct 2026 (`DEC-90`): las dos decisiones que la referencia necesitaba YA ESTÁN TOMADAS** —`P3` = (b) **mediana** y `P1` = (a) **solo los nueve meses de 2026**—, **y §4.2 paso 1 quedó reescrito con ambas puestas.** **La entrega 3.1 de E7c se cerró el 28 oct 2026 (`DEC-96`), con la fórmula escrita, la restricción `referencia > 0` puesta y su autocalculeo corriendo.** Y este punto cerró el 30 oct 2026 (`DEC-121`): los ocho pasos de §4.2 se ejecutaron con `A2.3.l` —pasos 1 a 5 sobre el cupo de 218— y `A2.3.m` —pasos 6 a 8 sobre el cupo de 24—, y **los doce autocalculeos de las salidas 3 y 4 cerraron**: `meses_con_cobertura` = 9 en los dos —`R8.1`◆F aguanta—, `meses_que_superan_el_techo` = 0 en los dos —`R2.1` aguanta—. **Los dos valores quedaron volcados al criterio 2 de `02_delimitacion.md`: `θ_A2` = 39,6666666666667 y `θ_A1` = 495,362260343088.**
4. **CUMPLIDO — 25 oct 2026, `CONTROL 6` corrido y verificado (DEC-74).** **La ruta existe, está completa y es única, medido y no declarado.** **`6.a`** —existe: **`tfv_ruta.id_ruta`** y **`tfv_cliente.id_ruta` + `nro_cuenta`**, ambas presentes—. **`6.b`** —**38 339 filas = 38 339 cuentas, o sea 1:1 sin duplicados; 78 rutas; cero `id_ruta` nulo; cero `nro_cuenta` nulo**—. **`6.c`** —**0 cuentas con más de una ruta** y `max_rutas_por_cuenta = 1`, así que **la regla de desempate de `DEC-71` queda escrita y NO SE ACTIVA**—. **`6.d`** —**cobertura total del panel: 30 411 cuentas, 0 sin fila en `tfv_cliente`, 0 sin `id_ruta`**, y los cuatro cubos cierran exactos contra 30 411—. **`6.e`** —**58 rutas con cuentas en el panel y la suma de `cuentas` da 30 411, exacto**—. **El identificador por el que se agrupa queda fijado en `tfv_ruta.id_ruta`.** **Lo único que `tfv_ruta` tiene de particular y conviene declarar en E7c: `tfv_cliente` es tabla viva —así lo avisó la tesista—, así que `30 411` y `38 339` llevan fecha de corrida.**

**Cuatro puntos cumplidos, gate cerrado el 30 de octubre de 2026.** El **punto 1** cerró con el gate de E7a (DEC-70); el **punto 4** con la corrida del `CONTROL 6` (DEC-74); el **punto 2** con `A2.3.b`, cuyos doce autocalculeos cerraron (DEC-80); **y el punto 3, `θ`, con los ocho pasos de §4.2 y su volcado al criterio 2 de `02_delimitacion.md` (DEC-121)**. **El orden se respetó: el punto 3 se cerró DESPUÉS de E7c, porque sin la referencia no hay `desviación` que ordenar (DEC-87); E7c cerró su gate 6 de 6 (DEC-112); después corrieron `A2.3.l` —pasos 1 a 5 sobre 218— y `A2.3.m` —pasos 6 a 8 sobre 24—, y por último se volcaron los valores.** **Los dos umbrales: `θ_A2` = 39,6666666666667 y `θ_A1` = 495,362260343088, ambos el MÁXIMO de los nueve cortes mensuales y no el mínimo.** **Los doce autocalculeos de las salidas 3 y 4 cerraron en los dos: `meses_con_cobertura` = 9 —ningún mes quedó sin cobertura, `R8.1`◆F— y `meses_que_superan_el_techo` = 0 —`R2.1`—.** **La regla que sostenía este punto —«mientras no se cierre, no se escribe un solo número nuevo en ningún documento»— queda levantada: los dos números entraron a su documento por su consulta y con su fecha de corrida.** **CON ESTO LA PROPUESTA QUEDA LISTA PARA LA PREDEFENSA DEL SÁBADO 31 DE OCTUBRE (DEC-88 y DEC-91).**
