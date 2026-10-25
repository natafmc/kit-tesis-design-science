# E7b — Requisitos del artefacto

> **Borrador abierto el 25 de octubre de 2026, versión v1. Gate abierto — punto 1 cumplido.**
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
| R3.4 | El campo con el que se agrupa —la ruta— **debe existir en el dato** y su identificador se fija en E7c | **P — cadena declarada, sin verificar.** Dictamen de la tesista, 25 oct 2026 (DEC-70): **`tfv_ruta (id_ruta)` ← `tfv_cliente (id_cliente, id_ruta, nro_cuenta)` ← `tfv_lectura (nro_cuenta)`**, y sobre el panel **`tfv_historico_lecturador.nro_cuenta` → `tfv_cliente.nro_cuenta` → `tfv_ruta`**. **Se comprueba con el CONTROL 6 —secciones 6.a a 6.e—, escrito y sin correr:** columnas de las dos tablas, unicidad, **cobertura del panel** y reparto por ruta. **Mientras no corra, se sabe que las tablas existen, pero no que toda cuenta del panel tenga fila en `tfv_cliente`, ni que cada cuenta tenga exactamente una ruta, ni cómo se reparte.** |

**Regla de desempate fijada por la tesista el 25 oct 2026 — `DEC-71`.** Si una cuenta aparece con **más de una ruta**, **manda la ruta vigente en `tfv_cliente`**. Sin una sola ruta por cuenta, «agrupar por ruta» no está definido, de modo que esta regla es lo que hace enunciable `R3.1`. **Pendiente confirmar con la `6.a` que `tfv_cliente` tiene un campo que exprese esa vigencia** —estado, baja, fecha fin—: **si no lo tiene, la regla está escrita pero no se puede aplicar** y hay que volver con la tesista a elegir entre las que sí se calculan.

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
| R8.1 | Las cuentas con **menos de cuatro ciclos** no quedan sin cobertura: se evalúan con la ventana de los **últimos 6 meses** | ◆ **F** |
| R8.2 | Una alerta originada por R8.1 **se marca como tal** — véase R4.4 | **F** |
| R8.3 | R8.1 **nunca** puede ser el criterio principal: es fallback | **F** |

### R9 — Precondiciones de entrada ◆ F

Sin esto, el método no arranca.

| ID | Requisito | Estado |
|:--|:--|:--|
| R9.1 | El panel de consumo con **una fila por cuenta y mes** existe y está verificado | **P — bloqueante.** Ver §4.3 |
| R9.2 | El histórico cubre **enero de 2022 a septiembre de 2026**: ventana **fija**, con **cierre obligatorio el 30/09/2026** | **P — `A2.3.a` sin correr.** **Cierre añadido por DEC-69:** la tesis cubre 57 meses y la lecturación de octubre está en curso, de modo que «a la fecha de corrida» era un blanco móvil —un panel sin cierre no es reproducible, y una desviación contra un panel que cambió ayer no es auditable— |
| R9.3 | Las tablas son **vivas**: toda cifra lleva **sello de fecha** | **F** — DEC-55, DEC-64 |
| R9.4 | El catálogo de 48 códigos de irregularidad está disponible | **F** — medido 6 oct 2026 |

### R10 — Aplicabilidad ◆ F

| ID | Requisito | Estado |
|:--|:--|:--|
| R10.1 | El equipo técnico sigue el método **sin asistencia de la autora** | **F** |
| R10.2 | Esto es lo que mide el **criterio 4**, cuyo valor sigue marcado *«fijar antes de construir»* en `02_delimitacion.md` | **P** — se fija en E7c con su procedimiento |

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

**Procedimiento fijado aquí, ejecutable en cuanto exista el panel:**

1. Calcular `desviación` para **cada cuenta y cada mes** del panel.
2. Ordenarlas de mayor a menor.
3. Recorrer el orden **hasta acumular 242 alertas por mes** — el techo de R2.1.
4. **`θ` es el valor en el corte.**
5. Verificar que `θ` es **único y estable**: si diera un resultado distinto entre meses, se fija `θ` como el **peor** —el que produce más alertas— y se declara.

**Por qué este y no otro:** el criterio 3 **es** el criterio de viabilidad (E4 §3.4). Calibrar `θ` contra capacidad y no contra una intuición estadística es la única forma de que R2.1 no dependa de una persona, que es exactamente lo que hoy falla.

### 4.3 Valor — **P — BLOQUEANTE**

> **No se escribe un número aquí.** No hay panel verificado, y **inventar `θ` sería exactamente el pecado que este proyecto se ha pasado dos semanas corrigiendo**: un valor sin consulta y sin fuente.
>
> **Qué falta, en orden:**
>
> 1. **Correr `A2.3.a`** — su salida decide si el panel existe tal como está escrito.
> 2. Si `lecturas_sobrantes > 0`, **corregir `A2.3` con `GROUP BY`** antes de calibrar.
> 3. **Producir el panel** y ejecutar los cinco pasos de §4.2.
> 4. **Registrar `θ` con su sello de fecha** y volcarlo a `02_delimitacion.md`, celda del criterio 2.
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
| 4 | Aplicabilidad | **Fijado como requisito (R10)**; su **valor** se fija en E7c con procedimiento |

---

## 7. Consecuencias para E7c

| De E7b a E7c | Qué debe diseñar |
|:--|:--|
| R1.2 ◆ | El cálculo concreto de la **referencia anual**: qué años entran, qué pasa con los huecos de serie, cómo se trata un año incompleto |
| R3.4 | El **campo de ruta**: cómo se identifica, dónde vive, qué pasa si una cuenta cambia de ruta |
| R7.3 | La **definición de los segmentos** — perfil de consumo × familia de código |
| R8.1 | La **implementación de la contingencia**, sin que contamine al criterio principal |
| §4.2 | El **cálculo automático de `θ`** para que sea recalculable cuando cambie el dato |
| Criterio 4 | El **procedimiento de aplicabilidad** con su valor |

---

## Gate de E7b — abierto: 1 de 4 puntos cumplidos

**Se cierra esta etapa cuando se cumplan cuatro cosas:**

1. **CUMPLIDO — 25 oct 2026, DEC-70.** **E7a cerró su gate y confirmó A2** como criterio principal, con **A1** como contingencia declarada y **A3** como paso previo del método; la tipología se mantiene en **`método`**. **La condición de reapertura —*se reabren R1.2, R3.1, R6.3, R8 y R9*— no se activó**, porque no cambió la alternativa.
2. **PENDIENTE.** **`A2.3.a` corre y su panel se da por verificado.** Sin esto no hay **R9.1** y no hay §4.3. **Se corre con la ventana cerrada 2022-01-01 a 2026-09-30 —DEC-69— y devuelve 11 columnas.**
3. **PENDIENTE.** **`θ` se fija con su valor y su sello de fecha** por los cinco pasos de §4.2, y se vuelca al criterio 2 de `02_delimitacion.md`.
4. **EN CURSO — cadena declarada, sin verificar.** **La tesista declaró el 25 oct 2026 que la ruta existe:** **`tfv_ruta (id_ruta)` ← `tfv_cliente (id_cliente, id_ruta, nro_cuenta)` ← `tfv_lectura (nro_cuenta)`**, y sobre el panel **`tfv_historico_lecturador.nro_cuenta` → `tfv_cliente.nro_cuenta` → `tfv_ruta`**. **Eso cubre la EXISTENCIA, que era la mitad del punto; falta la APTITUD.** **Sin cobertura y sin unicidad, R3.1 y R3.2 no se pueden cumplir**: un método que no sabe a qué ruta pertenece cada cuenta no puede agrupar, y **DEC-57 establece que la agrupación es parte del método y no un agregado posterior.** **Se comprueba con el `CONTROL 6`, secciones 6.a a 6.e, escrito y sin correr.** **Si el panel tiene cuentas sin fila en `tfv_cliente`, o cuentas con más de una ruta, este punto NO se cierra** y hay que decidir con la tesista la regla de desempate —la ruta vigente, la del periodo leído— o el campo alternativo.

**Un punto cumplido, uno en curso y dos sin tocar.** Mientras eso pase, **no se escribe un solo número nuevo en ningún documento**: el procedimiento está fijado, la restricción está fijada, y el valor espera a su consulta —que es la única forma en que un umbral deja de ser una opinión—.
