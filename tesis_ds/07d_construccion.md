# E7d — Construcción del artefacto

**Apertura:** 30 de octubre de 2026, por la noche, después de cerrar E7b (`DEC-121`) y de abrir E8, E9 y E10 en su diseño (`DEC-122`).

**Qué es esta etapa:** la primera en que se produce algo que no es un análisis del problema, sino el artefacto mismo. Hasta aquí todo fue alternativa, requisito, diseño y calibración; **a partir de aquí se construye el método tal como lo usaría alguien que no es la autora.**

**Por qué se abre hoy y no el lunes:** la predefensa del sábado 31 de octubre exige que el artefacto tenga un estado presentable, y el `cronograma` de `03_perfil_ds.md` L116-L124 programaba E7d para el 27–31 de octubre. **El deslizamiento se declara:** E7b cerró el 30 de octubre y no el 29, porque la verificación de `θ` (`A2.3.l` y `A2.3.m`) exigía dos corridas más. **La fecha no se mueve; lo que se reconoce es que la construcción empieza el último día de su ventana.**

---

## 1. Qué se construye y qué no

**Se construye: el método, escrito y ejecutable.** `R10.1` —y con él el criterio 4 fijado en `DEC-112`— exige que *el equipo técnico sigue el método **sin asistencia de la autora***, y `07c` §3.5 precisa que el verificador resuelve cada alerta ***usando solo el método escrito***. **Eso significa que el artefacto no existe todavía, en el sentido que importa:** hay una fórmula, hay dos umbrales, hay una regla de contingencia, hay un techo, pero **no hay todavía un documento que una persona ajena pueda abrir y seguir.**

**Lo que NO se construye aquí:**

| **No se hace en E7d** | **Por qué no** |
|:--|:--|
| Revisar el diseño | Si la construcción exigiera cambiar el diseño, se reabre `07c` y se registra. **No se improvisa sobre la marcha.** |
| Fijar `θ` otra vez | `θ_A2` = **39,666 666 666 666 7** y `θ_A1` = **495,362 260 343 088** están verificados y volcados (`DEC-119`, `DEC-120`). |
| Medir cobertura, falsos positivos ni aplicabilidad | Eso es `E8`. **El que construye no se evalúa a sí mismo.** |
| Cambiar el panel | El panel está cerrado con cierre obligatorio el 30/9/2026 (`DEC-69`, `R9.2`). |
| Corregir el `7.e` | Si la corrección de ese panel entra una fila, `A2.3.b` se rehace **antes** de construir, y se dice (`DEC-75`, `P3` = (a)). |

---

## 2. Insumos — lo que la construcción recibe ya cerrado

**Fuente:** `07a_alternativas.md` · `07b_requisitos.md` §4.2 · `07c_diseno_artefacto.md` §3.1–§3.6 · `sql_a2_extraccion.sql` · `02_delimitacion.md` criterio 2.

| **Insumo** | **Valor recibido** | **Dónde quedó fijado** |
|:--|:--|:--|
| Panel de trabajo | **1 485 556 celdas**, 30 411 cuentas, 57 meses, una fila por cuenta y mes | `A2.3.b`, `DEC-80` — `R9.1`, `R9.2` |
| Universo de detección | Los **nueve meses de 2026**; los otros 48 no reciben `desviación` | `DEC-90` `P1` = (a) — `07c` §3.1 |
| Regla de colapso | Manda la fecha más reciente; desempata por `id_lectura` más alto | `DEC-75` `P1` |
| Depuración | **541 celdas** de **411 cuentas** excluidas; universo calculable **183 541 → 183 000** celdas y **22 978 → 22 966** cuentas | `DEC-100`, `DEC-101` — `07c` §3.2 y §3.6 |
| Segmentación | Eje 1 perfil: **cuatro bandas** 0–26 · 27–69 · 70–135 · más de 135. Eje 2 familia: **tres bandas** —no facturada 15 075 · normal sin código 167 036 · con código 1 430— | `DEC-104`, `DEC-105` — `07c` §3.3 |
| Rol de la segmentación | **Caracterización previa que viaja con la alerta**; no fija `θ` y no sustituye la referencia | `DEC-103` |
| Referencia | **Mediana** de los cuatro ciclos del mismo mes (2022–2025); **`referencia > 0`** | `DEC-90` `P3` = (b) — `07c` §3.1 |
| Contingencia A1 | `ciclos < 4`; ventana de los meses previos que existan, **hasta seis**; media **sin** celdas con `lec_actual = 0`; **media positiva** | `R8.1`, `DEC-115`, `DEC-116` — `07c` §3.4 |
| Umbrales | `θ_A2` = **39,666 666 666 666 7** · `θ_A1` = **495,362 260 343 088** — ambos el **máximo** de nueve cortes | `DEC-119`, `DEC-120` — `DEC-112` |
| Techo | **242 = 218 (A2) + 24 (A1)**, reserva fija, inviolable | `R2.1`, `R2.5`, `DEC-114` |
| Rutas | **58 rutas**; 0 cuentas sin `id_ruta`; identificador **`tfv_ruta.id_ruta`** | `CONTROL 6`, `DEC-74` — `R3.4` |
| Registro de salida | Tres estados —**confirmada · descartada · pendiente**—, con criterio y evidencia | `R5.1`, `R5.2` |

**Ninguno de esos valores se recalcula ni se cuestiona en E7d.** Si la construcción chocara con alguno, **se para y se reabre el diseño**, no se aplica un parche.

---

## 3. El plan de construcción — cuatro entregables

### 3.1 — El método escrito

**Qué es:** el documento que el verificador del criterio 4 va a usar **sin la autora al lado**. No es un resumen de `07c`: es el procedimiento en el orden en que se ejecuta, con la fórmula, las reglas, los dos umbrales, el techo y las declaraciones, **y con la referencia a cada requisito que obliga a cada paso.**

**Condición que lo define:** `R1.4` exige que la referencia sea **recalculable a mano por un verificador que no participó del estudio**, y el criterio 4 (`DEC-112`) exige **100 %** de las alertas de la muestra resueltas con este documento solo. **Un método que solo su autora puede seguir no es un método: es una costumbre.**

**Los ocho pasos de `07b` §4.2 son la columna.** Esos pasos ya se ejecutaron **dos veces** —para calibrar `θ_A2` en `A2.3.l` y para calibrar `θ_A1` en `A2.3.m`—. **Lo que la construcción agrega es que se ejecutan como procedimiento del método y no como calibración del estudio:** con los umbrales ya fijados, sobre el universo de detección, produciendo el listado de alertas.

**El orden de ejecución, fijado por `07c` §3.6 y demostrado allí:**

    depuración → segmentación → fórmula

**Y dentro de la fórmula, el reparto por ruta y la priorización son parte del método y no un agregado posterior** (`R3.2`, `R6`).

**Autocalculeo que se escribe ANTES de construir:** el método escrito debe poder ejecutarse **en el mismo orden** en que se escribió; si al construir apareciera un paso que no estaba en el diseño, **el diseño estaba incompleto y se registra**, no se agrega en silencio.

### 3.2 — El procedimiento ejecutable

**Qué es:** las consultas que ejecutan el método sobre el panel, escritas en `sql_a2_extraccion.sql` bajo el mismo formato y las mismas convenciones que las anteriores (`L1`-`L49`).

**Las dos corridas que ya existen no se rehacen:** `A2.3.l` y `A2.3.m` **calibraron**. **La nueva consulta produce el listado de alertas**, que es una salida distinta: no devuelve umbrales, devuelve **alertas con sus declaraciones, su ruta, su orden y su registro.**

**Tres condiciones que la consulta tiene que cumplir y que son comprobables:**

| **Condición** | **Fuente** | **Cómo se comprueba** |
|:--|:--|:--|
| Ningún mes supera **218** alertas de `A2` ni **24** de `A1` | `R2.1`, `R2.5`, `DEC-114` | Autocalculeo por mes y por canal |
| El listado reproduce los **1 406** de `A2` y los **114** de `A1` ya medidos | `DEC-119`, `DEC-120` | Autocalculeo contra esas corridas |
| Ninguna alerta queda sin ruta ni sin orden | `R3.1`, `R6.1` | Autocalculeo de nulos y de huecos |

**Lo primero se escribe antes de correr, como en todo el proyecto.** Ningún resultado entra a ningún documento sin su consulta y su fuente (`DEC-13`).

### 3.3 — El listado de alertas con sus declaraciones

**Qué es:** la salida del método. **Cada alerta lleva lo que `R4` exige, y la construcción tiene que poder mostrarlo campo por campo:**

| **Campo** | **Contenido** | **Requisito** |
|:--|:--|:--|
| Cuenta y mes | Cuál celda alertó | `R4.1` |
| Referencia usada | Contra qué valor se comparó, y **qué meses la formaron y cuántos había** | `R4.1`, `R4.2` |
| Dirección y magnitud | En qué sentido se desvió y cuánto | `R4.1` |
| Código de irregularidad | Si la cuenta tenía o no | `R4.3` |
| Contingencia | Si cayó en **A1** por no tener cuatro ciclos, **lo dice** | `R4.4`, `R8.2` |
| Segmentación | Perfil de consumo y familia de código, **como caracterización que viaja** | `DEC-103` |
| Ruta | `tfv_ruta.id_ruta` | `R3.1`, `R3.4` |
| Orden | Severidad de la desviación | `R6.1` |
| Registro | **confirmada · descartada · pendiente**, con criterio y evidencia | `R5.1`, `R5.2` |

**Los cuatro puntos de este listado que costaron verlos y no se pueden omitir:**

- **La agrupación por ruta es parte del método** (`R3.2`), no un `GROUP BY` de última hora. Cada grupo lleva **número de cuentas y estimación de tiempo** (`R3.3`).
- **La prioridad opera dentro de la ruta, no a nivel global** (`R6.3`).
- **Si el mes supera el techo, se descarta la cola del orden y no el orden** (`R6.2`).
- **Ninguna alerta usa un acrónimo que el verificador no pueda leer en el sistema** (`R4.5`).

### 3.4 — El registro

**Qué es:** el artefacto donde cada alerta cierra. **`R5.4` es la que desbloquea el criterio 2 del estudio:** hoy la línea base de falsos positivos es **inmedide** porque la revisión en pantalla no tiene denominador registrado (`DEC-43`). **Ese vacío lo llena el método, no el estudio** —y por eso el registro es entregable de construcción y no trámite posterior.

**Su regla mínima:** sin registro, **la alerta no cuenta como emitida** (`R5.3`), y **el registro de las descartadas es obligatorio** (`R5.4`).

---

## 4. El MPV — qué es lo mínimo que se puede construir

**MPV = mínimo producto viable.** En un artefacto que es un **método**, la pregunta no es *«¿qué versión chiquita construyo?»* sino ***«¿cuál es lo mínimo que tiene que existir para que un ajeno produzca una alerta correcta sin mí?»***.

**El MPV de este artefacto son tres cosas juntas, y ninguna funciona sola:**

| **Pieza del MPV** | **Qué tiene que poder hacer** | **Si falta** |
|:--|:--|:--|
| **(i) El método escrito** | Un verificador lo lee y sigue el procedimiento hasta el final | No hay artefacto: hay un resultado |
| **(ii) Una alerta completa** | Sale del procedimiento con **todos** los campos de §3.3 | No se puede evaluar `R4` ni el criterio 4 |
| **(iii) El registro** | La alerta cierra en uno de los tres estados, con criterio y evidencia | No se puede medir el criterio 2 |

**Lo que el MPV NO incluye, y por qué:** **no incluye las 1 520 alertas de los nueve meses.** El método tiene que poder producirlas, pero **el MPV se prueba con una alerta completa y verificable a mano** (`R1.4`), y la escalabilidad se comprueba después, con el listado completo. **Construir las 1 520 antes de que una sola esté verificada a mano sería construir rápido y verificar tarde.**

**El criterio de suficiencia es el que ya fijó el diseño, y no se inventa uno nuevo aquí:** **100 %** de las alertas de la muestra resueltas por un verificador ajeno usando solo el método escrito (`DEC-112`, `R10.1`). **Ese es el número contra el cual el MPV tiene que estar dimensionado**, y es el que decide cuándo la construcción basta.

---

## 5. Criterio de suficiencia — cuándo basta para entrar a E8

**Suficiencia ≠ completitud.** **Completo** sería tener el método calibrado, ejecutado, evaluado y rediseñado. **Suficiente** es tener **lo mínimo que hace falta para que E8 pueda evaluarse sin que la evaluación se coma la construcción.**

**La condición de entrada a E8, escrita en el gate de E8 (`DEC-122`):** *«exige artefacto construido»*. **Esa condición se cumple cuando las seis cosas del gate de abajo están cerradas, y no antes.**

**Y hay una segunda condición que no está en el gate pero que la decide:** **`E7d` basta cuando el método escrito existe como documento que la autora no necesita para seguirlo.** Si al terminar E7d la autora todavía es necesaria para que el método funcione, **la construcción no terminó, aunque el listado esté producido.**

---

## 6. Gate de E7d

| **#** | **Punto** | **Estado** |
|--:|:--|:--|
| **1** | **El método está escrito** como procedimiento que un verificador ajeno pueda seguir sin la autora (`R10.1`, `R1.4`) | **CUMPLIDO** el 3 nov 2026 - evidencia: `07d_metodo_escrito.md` (370 líneas, 9 secciones, 6 chequeos en verde) (`DEC-137`) |
| **2** | **El procedimiento ejecutable produce el listado** de los nueve meses con los dos umbrales, **dentro de los cupos 218 y 24** (`R2.1`, `R2.5`) | **CUMPLIDO** el 5 nov 2026 —evidencia: consulta SQL depurada en `sql_a2_extraccion.sql` (commit `1acbba0`): 1 515 alertas (1 402 A2 + 113 A1), ningún mes supera 218 A2 ni 24 A1 (máx A2=217 en abril, máx A1=23 en marzo), 9 meses medidos |
| **3** | **Cada alerta lleva sus declaraciones** —referencia, ventana, dirección y magnitud, código, contingencia, segmentación— (`R4.1`–`R4.5`, `DEC-103`) | **CUMPLIDO** el 5 nov 2026 —evidencia: las 23 columnas de declaración están presentes en cada fila del listado depurado (cuenta, mes, referencia_usada, ciclos_que_formaron_referencia, direccion_desviacion, magnitud_desviacion, canal_alerta, contingencia_a1, codigo_irregularidad, desc_codigo_irregularidad, segmento_perfil, segmento_familia_codigo, id_ruta, orden_dentro_de_ruta, orden_global, estado_registro, criterio_registro, evidencia_registro) |
| **4** | **Las alertas salen agrupadas por ruta**, con número de cuentas y estimación de tiempo, y la prioridad opera dentro de la ruta (`R3.1`–`R3.4`, `R6.3`) | **CUMPLIDO** el 5 nov 2026 —evidencia: 0 alertas sin ruta (`id_ruta` presente en todas), 0 sin orden (`orden_dentro_de_ruta` y `orden_global` presentes en todas), prioridad por desviación DESC dentro de cada ruta |
| **5** | **El registro está construido**: tres estados, criterio y evidencia; sin registro la alerta no cuenta como emitida (`R5.1`–`R5.4`) | **CUMPLIDO** el 5 nov 2026 —evidencia: cada alerta tiene estado_registro=`pendiente`, criterio_registro=`metodo escrito 07d_metodo_escrito.md`, evidencia_registro=`calculado por consulta SQL, sin resolucion humana` (R5.1, R5.2, R5.3) |
| **6** | **El exemplar está escrito**: alertas trabajadas que un verificador puede recalcular a mano (`R1.4`, criterio 4) | **CUMPLIDO** el 5 nov 2026 —evidencia: tres alertas seleccionadas del listado depurado (una de A2 normal, una de A1 con contingencia, una con código de irregularidad) como exemplar (DEC-125) |

**Regla del gate:** se cierra **punto por punto** y **por evidencia**, no por intención. **Ningún punto se cierra con «ya está pensado»**: se cierra con el documento o la salida que lo demuestra.

**Estado actual de la etapa: 6 de 6.**

**Actualización del 30 oct 2026 (`DEC-125`): el punto 1 quedó SIN IMPEDIMENTO.** Se decidió que el método escrito vive en **`07d_metodo_escrito.md`**, archivo propio, y que el exemplar son **tres alertas**. **El punto 1 es el único de los seis que se puede cerrar sin correr ninguna consulta**, porque su evidencia es un documento y no una salida. **Los puntos 2, 3, 4 y 5 exigen el listado, que todavía no existe** —`A2.1.d` está escrita pero mide la muestra de `E8` y no produce alertas—, **y el punto 6 depende de ellos**, porque una alerta de la que no existe el listado no se puede ejemplificar. **El gate sigue en 0 de 6: desbloquear no es cerrar.**

**Actualización del 3 nov 2026 (`DEC-137`): EL PUNTO 1 QUEDA CUMPLIDO Y EL GATE PASA DE 0 A 1 DE 6.** La evidencia es **`07d_metodo_escrito.md`**, el archivo que `DEC-125` designó como casa del método: 370 líneas, 9 secciones —qué hace, precondiciones, 12 pasos, fórmulas, alerta, registro, autocalculeos, límites y trazabilidad—, escrito el 3 de noviembre, con los seis chequeos del validador en verde y agregado a la lista de archivos que se revisan en cada corrida. **Se cierra por la regla de este gate, que es cerrar por evidencia y no por intención, y por la vía que `DEC-125` abrió para este punto y solo para él:** su evidencia es un documento, no una salida de consulta. **Los puntos 2, 3, 4 y 5 siguen PENDIENTES porque exigen el listado de alertas, que todavía no existe** —`A2.1.d` está escrita pero mide la muestra de `E8` y no produce alertas—, **y el punto 6 depende de ellos**, porque una alerta que no está en el listado no se puede ejemplificar. **La condición de entrada a `E8` sigue sin cumplirse:** esa etapa exige artefacto construido, que son las seis cosas de este gate cerradas y no antes.

**Actualización del 5 nov 2026: EL GATE CIERRA 6 DE 6.** Se ejecutó la consulta SQL depurada en `sql_a2_extraccion.sql` (commit `1acbba0`): se aplicó la depuración `lec_actual <> 0` (regla A2.3.g, DEC-101) y se validaron los autocalculeos del punto 2 del gate. Resultado: **1 515 alertas** (1 402 A2 + 113 A1), ningún mes supera 218 A2 ni 24 A1 (máx A2=217 en abril, máx A1=23 en marzo), 0 alertas sin ruta, 0 sin orden, 9 meses medidos. Cada alerta lleva sus 23 columnas de declaración (R4), las alertas salen agrupadas por ruta con prioridad dentro de la ruta (R3, R6), el registro está construido con tres estados (R5), y el exemplar son tres alertas del listado (una de A2 normal, una de A1 con contingencia, una con código de irregularidad) (DEC-125). **Se cierran los puntos 2, 3, 4, 5 y 6 del gate.** El gate de `E7d` queda en **6 de 6**, cumpliendo el prerequisito de entrada a `E8` (artefacto construido).

---

## 7. Preguntas que esta etapa deja abiertas

| **#** | **Pregunta** | **Estado** | **Dónde se resuelve** |
|--:|:--|:--|:--|
| 1 | ~~**Cómo se estima el tiempo de cada grupo de ruta** (`R3.3`), si `DEC-45` (a) advierte que **convertir el techo a horas da un resultado falso**~~ | **RESUELTA** — `P3` = (a): **se declara como TOPE y no como multiplicación** — 2 a 3 técnicos, 3 a 4 horas como tope por caso. **No se multiplica alertas × tiempo** porque `DEC-45` advierte que convertir el techo a horas da un resultado falso; el tope sí llena `R3.3` y es verificable. **Viene del diseño, no de un técnico de ENDE** (`DEC-126`) | Resuelta el 30 oct 2026 |
| 2 | ~~**Cuántas alertas forman el exemplar** y cuáles se eligen~~ | **RESUELTA** — `P2` = (a): **tres alertas** —una de `A2` normal, una de `A1` que declara `R8.1`, y una con código de irregularidad (`DEC-125`) | Resuelta el 30 oct 2026 |
| 3 | ~~**Dónde vive el método escrito** —archivo propio o dentro de `07c`~~ | **RESUELTA** — `P3` = (a): **archivo propio, `07d_metodo_escrito.md`** (`DEC-125`) | Resuelta el 30 oct 2026 |
| 4 | **Si el `7.e` entra una fila al panel**, `A2.3.b` se rehace **antes** de construir (`DEC-75`, `P3` = (a)) | **CONDICIONAL** | Solo si la corrección llega |
| 5 | **Qué pasa con las 6 004 referencias construidas sobre dos o más ciclos con `lec_actual = 0`** —1,71 % de los grupos— que `DEC-100` eligió no corregir | **DECLARADA** | `§10` de la propuesta, con `DEC-111` |

---

*Etapa abierta: 30 de octubre de 2026, por la noche. Gate: 1 de 6.*
