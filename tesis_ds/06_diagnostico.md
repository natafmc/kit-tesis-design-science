# E6 — Diagnóstico con indicadores y línea base

> **Evidencia consolidada, dos fuentes, la segunda confirma a la primera.**
> **(1)** `DATOS.xlsx`, gestionada por la tesista el 1 de octubre de 2026 — regional de **29 750 cuentas**, gestiones 2025 y 2026 (21 meses, hasta septiembre de 2026).
> **(2)** `DATOS desde 2022.xlsx`, recibido el **5 de octubre de 2026** — serie saneada **enero 2022 – septiembre de 2026, 57 meses**, hojas `reclamos` (104 filas), `historico` (57) y `tipo_lectura` (228), encabezados en fila 2.
> **Prueba de continuidad (5 oct 2026):** filtrando la fuente (2) a `gestion ≥ 2025` se reproducen **las nueve cifras de `DATOS.xlsx` exactamente** — 314, 62, 46, 19,75 %, 74,19 %, 526 730, 5 528, 532 258. **Son la misma fuente; la segunda amplía el alcance de la primera y no la contradice.** Registro completo y scripts en `consultas_base_datos.md`, sección *Serie histórica saneada 2022–2026*.
> Todos los valores fueron verificados aritméticamente antes de registrarse.
> **Disciplina de trazabilidad:** esta evidencia y los criterios se fijan antes de construir el artefacto.

## Población y alcance de la extracción

| Concepto | Valor | Fuente |
|:--|:--|:--|
| Cuentas de la regional | **29 750** (dato exacto comunicado por la tesista el 1 oct 2026; la cifra de 29 000 era un redondeo). Los registros de lectura por mes crecen de 28 355 (ene 2025) a 29 750 (sep 2026): **el universo no es fijo y los denominadores deben calcularse mes a mes**, no contra una población única | `DATOS.xlsx`, Tablas 2 y 3 |
| Lecturas facturables en 21 meses (2025-01 – 2026-09) | 532 258 | Tabla 3 |
| Lecturas Tipo 1 (sin código de irregularidad), **ventana de 21 meses** | 526 730 → **98,96 %** · *en 57 meses: 1 377 641 → **99,12 %*** | Tabla 3; `DATOS desde 2022.xlsx`, hoja `tipo_lectura` |
| Lecturas Tipo 2 y 3 (con código), **ventana de 21 meses** | 5 528 → **1,04 %** · *en 57 meses: 12 300 → **0,88 %*** | Tabla 3; `DATOS desde 2022.xlsx`, hoja `tipo_lectura` |
| Lectura Tipo 0 | No genera factura; excluida del universo facturable | Nota del archivo |
| **Histórico disponible en `tfv_historico_lecturador`** | **desde 2022 — YA EXTRAÍDO el 5 oct 2026** en `DATOS desde 2022.xlsx`: **57 meses**, ene 2022 – sep 2026 | Hoja `historico`; declaración de la tesista del 2 oct 2026 |

**Tipos de lectura — dominio confirmado por la tesista el 5 de octubre de 2026 (cierra B1):** **0 = LC, lectura de corte (no facturada) · 1 = LN, lectura normal (objeto de investigación) · 2 = LE, lectura estimada · 3 = NE, normal estimada.**

*Nota de coherencia entre las dos descripciones.* `DATOS.xlsx` describía el mismo dominio **por su consecuencia contable**: «0 = sin factura; 1 = sin código; 2 y 3 = con código». **Las dos lecturas son compatibles**: LC no genera factura, LN no lleva código de irregularidad y LE/NE sí lo llevan porque la lectura estimada es en sí misma una irregularidad registrada. **Se conservan las dos formulaciones** —la del archivo y la del dominio—, porque dicen cosas distintas y complementarias de la misma variable.

### Consecuencia de que el histórico llegue hasta 2022

La restricción de estacionalidad queda **resuelta en el origen**: de 2022 a septiembre de 2026 hay **57 meses y cuatro ciclos anuales completos** (2022, 2023, 2024 y 2025), de modo que una línea base de "mismo mes del año anterior" es viable y la regla actual de 6 meses puede contrastarse contra varios años.

Pero **la extracción había que ampliarla.** Mientras `DATOS.xlsx` cubría 21 meses, la evidencia del documento tenía un solo ciclo anual por mes del calendario. Ampliarla a enero de 2022 era condición para:

- modelar estacionalidad con más de dos ciclos;
- conocer el volumen real de reclamos disponible como verdad de referencia en E8;
- ver si las correcciones manuales ya se registraban antes de la capacitación de 2025;
- comparar el universo de cuentas de 2022 con el actual (29 750), porque los denominadores cambiarán.

**Decisión de la tesista (2 oct 2026):** `tfv_reclamo` y la serie de correcciones **sí llegan hasta 2022**, con **mismo esquema**, y la extracción ampliada **es viable**. Ver especificación A2.1–A2.4 en `consultas_base_datos.md`.

### Estado de la ampliación al 5 de octubre de 2026

**A2.4 (agregados mensuales) — EJECUTADO.** La tesista entregó `DATOS desde 2022.xlsx` con las tres hojas agregadas extendidas a 57 meses, y **las nueve cifras de `DATOS.xlsx` se reproducen exactamente** (ver *Serie histórica saneada 2022–2026* en `consultas_base_datos.md`, Prueba 1). **Los cuatro objetivos listados arriba quedan respondidos** —estacionalidad con cuatro ciclos, volumen de reclamos desde 2022, correcciones antes de la capacitación, y universo de cuentas—, y con ellos se cumple la regla de *«si la extracción ampliada no reproduce esas tres cifras, ninguna sirve»*.

**A2.1, A2.2 y A2.3 — NO ejecutados.** El archivo saneado sigue siendo **agregado**: no trae cuenta, id ni código de irregularidad. **Sigue sin haber panel de consumo por cuenta y mes, y sin eso no hay detección posible** (E7b). Ahí es donde `sql_a2_extraccion.sql` sigue siendo necesario.

## Línea base multianual — 57 meses (enero 2022 – septiembre 2026)

> **Nueva el 5 oct 2026.** Fuente: `DATOS desde 2022.xlsx`, hojas `reclamos`, `tipo_lectura` y `historico`, encabezados en fila 2. Consulta y scripts declarados en `consultas_base_datos.md`. *Todas las filas están verificadas aritméticamente antes de publicarse.*

### Reclamos por gestión y procedencia

| Gestión | Meses con dato | Reclamos | Procedentes (sw=1) | Procedentes Tipo 1 | % Tipo 1 de los procedentes |
|:--|--:|--:|--:|--:|--:|
| 2022 | 12 | 104 | 14 | 11 | 78,57 % |
| 2023 | 12 | 326 | 49 | 40 | 81,63 % |
| 2024 | 12 | 309 | 49 | 39 | 79,59 % |
| 2025 | 12 | 213 | 46 | 35 | 76,09 % |
| 2026 | 9 | 101 | 16 | 11 | 68,75 % |
| **Total** | **57** | **1 053** | **174 (16,52 %)** | **136** | **78,16 %** |

*Por estado resolutivo:* **procedentes 174 · improcedentes 878 · improcedente administrativo 1** = 1 053 ✔. *Verificación interna:* en **las 104 filas** de la hoja, `tipo_lectura_1 + tipo_lectura_diferente_1 = cantidad_odecos`, sin una sola excepción.

> **La ventana corta no sesgaba la conclusión.** Con 21 meses: 74,19 % de procedentes Tipo 1. Con 57: **78,16 %**. La segmentación de la Opción 2 se sostiene y se fortalece.

### Tipos de lectura

| Gestión | 0 · LC (no facturada) | 1 · LN | 2 · LE | 3 · NE | Facturable (1+2+3) |
|:--|--:|--:|--:|--:|--:|
| 2022 | 22 542 | 277 917 | 1 475 | 812 | 280 204 |
| 2023 | 34 723 | 282 597 | 859 | 999 | 284 455 |
| 2024 | 41 294 | 290 397 | 1 318 | 1 309 | 293 024 |
| 2025 | 44 443 | 298 472 | 2 015 | 995 | 301 482 |
| 2026 (9 m) | 34 782 | 228 258 | 1 626 | 892 | 230 776 |
| **Total** | **177 784** | **1 377 641** | **7 293** | **5 007** | **1 389 941** |

*Total de lecturas registradas:* 1 567 725. **LN = 99,12 %** del facturable · **LE+NE = 0,88 %** · **LC = 11,34 %** del total.

### Correcciones — la serie completa, con la ruptura de 2025

`historico.lecturas_diferentes` — la fuente declarada de 800,3 y de 242,2.

| Gestión | Total | Meses | Promedio mensual | % de lecturas |
|:--|--:|--:|--:|--:|
| 2022 | 8 509 | 12 | 709,1 | 3,05 % |
| 2023 | 10 230 | 12 | 852,5 | 3,46 % |
| 2024 | 17 459 | 12 | **1 454,9** | **5,62 %** |
| 2025 | 9 604 | 12 | 800,3 | 2,81 % |
| 2026 (9 m) | 2 180 | 9 | **242,2** | **0,82 %** |
| **Total** | **47 982** | **57** | — | **3,22 %** |

*Del total de 1 491 360 lecturas comparadas, 1 443 376 iguales y 47 982 diferentes.*

> **Tres lecturas que este archivo obliga a hacer:**
> 1. **2024 fue el peor año, no 2025** — 1 454,9/mes y 5,62 % de lecturas diferentes. La narrativa anterior, con solo 21 meses, no lo mostraba.
> 2. **La caída de 2025 no es un efecto de nivel sino de régimen:** ene–may **1 507,4/mes** → jun–dic **295,3/mes** = **−80,4 %**, justo en el corte de la capacitación de mayo–junio. **La atribución sigue siendo declarativa, no causal** (regla vigente).
> 3. **2026 es el mejor año de la serie** — 0,82 %, casi cuatro veces mejor que 2022. **El problema ya no es el nivel: es el residuo.**

### Tasas por 100 000 lecturas — segmentación Opción 2, serie completa

| Tasa (procedentes ÷ facturable del tipo, × 100 000) | Tipo 1 · LN | Tipo 2–3 · LE+NE | Razón |
|:--|--:|--:|--:|
| **2022–2026 (57 meses)** | 136/1 377 641 → **9,87** | 38/12 300 → **308,94** | **31,3 ×** |
| 2025–2026 (21 meses, referencia) | 8,73 | 289,44 | 33,1 × |

> **El resultado central de la propuesta resiste la triplicación del periodo: 31,3× en lugar de 33,1×.** Las lecturas con código siguen siendo ~31 veces más propensas a generar un reclamo procedente, siendo el 0,88 % del facturable. **La Opción 2 queda confirmada con tres veces más evidencia.**

### Salvedades que viajan con estas cifras

1. **Defecto de 2 unidades** en `historico`, fila **2025-04**: 28 556 ≠ 27 474 + 1 080. Única fila rota de 57; afecta el total en 0,00013 %. **Declarado, no corregido.**
2. **Agosto de 2026 — cotejado el 6 oct 2026, sin desfase.** Los **dos archivos dan las mismas dos filas**: `odecos` 1 (procedente) + 4 (improcedente) = **5 reclamos totales**, de los cuales **4 son tipo 1**. *La cifra «8» que circulaba venía de **agosto de 2025** (1 + 7) y fue un error de registro, retirado por DEC-25.* **Pendiente solo la convención de publicación:** si «reclamos del mes» significa el total (5), el tipo 1 (4) o los improcedentes (4). → **Resuelta el 6 oct 2026 (DEC-26): el total (5)** — `cantidad_odecos` sumado en el periodo; las otras dos cifras se publican al lado y etiquetadas.
3. **Denominadores por gestión, no población fija:** 2026 tiene **9 meses** y el universo de cuentas crece; **no se puede promediar 2026 contra años completos sin declararlo.**
4. **El código de irregularidad sigue sin aparecer** en ninguna de las tres hojas: la segmentación por familia que pide la Opción 2 **sigue sin base de datos**.

## Indicador 1 — Reclamos ODECO por tipo de lectura y procedencia

Período 2025-01 a 2026-09. `sw_procedente`: 1 = procedente, 2 = improcedente, 4 = improcedente administrativo.

| Grupo | Total | Tipo 1 (sin código) | Tipo 2–3 (con código) | % Tipo 1 |
|:--|--:|--:|--:|--:|
| **Procedentes** | **62** | **46** | **16** | **74,19 %** |
| Improcedentes | 252 | 249 | 3 | 98,81 % |
| **Total tramitado** | **314** | **295** | **19** | **93,95 %** |

*Verificación:* 62 + 252 = 314 ✓; 46 + 16 = 62 ✓; 249 + 3 = 252 ✓; 46 + 249 = 295 ✓; 295/314 = 93,95 % ✓; 46/62 = 74,19 % ✓; 249/252 = 98,81 % ✓.

### Las tres cifras que deben publicarse juntas

El 74,19 % aislado es engañoso, porque el **98,96 %** de las lecturas facturables son Tipo 1 **en esta ventana de 21 meses** —**99,12 % en los 57 meses de la línea base multianual**—. La lectura correcta exige los tres números:

1. **Cobertura:** el 74,19 % de los reclamos procedentes provino de lecturas **sin** código. Auditar solo las lecturas con código habría alcanzado como máximo **16 de 62** procedentes (25,81 %) y se habría quedado sin detectar **46** (74,19 %). *Este es el argumento que sostiene la Opción 2.* —**En 57 meses: 136 de 174 = 78,16 %** (tabla de la línea base multianual).
2. **Rendimiento por lectura:** las lecturas **con** código son el **1,04 %** del universo en esta ventana —**0,88 % en 57 meses**—, pero originan el 25,81 % de los procedentes.

| Tasa (procedentes por 100 000 lecturas) | Tipo 1 | Tipo 2–3 | Razón |
|:--|--:|--:|--:|
| Procedentes | 8,73 | 289,44 | **33,1 ×** |
| Improcedentes | 47,27 | 54,27 | 1,15 × |

3. **Conclusión válida:** las lecturas con código son **33,1 veces más propensas** a generar un reclamo procedente que las que no lo tienen, pese a ser el 1 % del volumen —**31,3× en la ventana de 57 meses** (9,87 frente a 308,94 por 100 000)—. Tener código es una **señal de riesgo de alta potencia**, no un ámbito suficiente de trabajo. *La razón se mantiene en la misma magnitud con más que el doble de datos, y por eso la segmentación no cambia de forma.*

**Consecuencia de diseño (para E7a):** las opciones 1 y 2 no son excluyentes. El método debe barrer el conjunto completo **y** usar la familia de código como variable de priorización. Descartar el código sería ignorar la señal más intensa del sistema; limitarse a él sería perder tres de cada cuatro reclamos procedentes válidos.

## Indicador 2 — Correcciones manuales previas a la facturación (TI sombra)

**Qué es:** corrección de una lectura registrada erróneamente, aplicada a mano por el encargado de facturación **antes** de emitir la factura, con el fin de evitar reclamos. No son estimaciones por impedimento de acceso ni correcciones de datos: es **lectura mal tomada** por el personal terciarizado.

### Cadena de corrección vigente (declarada el 2 oct 2026)

| # | Paso | Actor |
|:--|:--|:--|
| 1 | Toma de lecturas en **equipos móviles de lecturación** | Personal **terciarizado** |
| 2 | Recepción del equipo móvil y **descarga de las lecturas al sistema comercial** | Personal responsable de lecturación |
| 3 | Revisión de los consumos calculados; **si alerta una anomalía, solicita visita al domicilio** | **Encargado de facturación** |
| 4 | Desplazamiento al domicilio, **respaldo fotográfico** del medidor, retorno a oficina | Personal técnico de la empresa (**no** terciarizado) |
| 5 | Revisión y **corrección de la lectura** | Encargado de facturación |

**Hallazgo: el paso 3 ya es una detección de anomalías.** Existe, es manual, no está escrita en ningún documento y depende de una sola persona. El método no introduce detección en un vacío: **formaliza ese paso** y lo libera de la atención individual.

**Tres consecuencias:**

1. **Cinco roles, no tres.** Quien toma el dato (terciarizado) no es quien lo descarga, ni quien lo detecta, ni quien lo verifica en campo, ni quien lo corrige. El método debe asignar los cinco.
2. **La evidencia fotográfica sí existe**, pero está **siloada en la computadora del encargado de facturación**, fuera del sistema y sin enlace con el registro de lectura que corrigió. *Corrección de lo registrado el 1 oct:* no se pierde, pero tampoco se audita desde el sistema. La tesista desconoce si además se imprime o se almacena en otro lugar.
3. **El costo de una falsa alarma es un desplazamiento**, no una revisión de pantalla. Cada alerta que el encargado acepta termina en una visita al domicilio.

| Período | Media mensual de lecturas corregidas |
|:--|--:|
| 2025 (enero–mayo) | 1 507 |
| 2025 (junio–diciembre) | 295 |
| **2026 (enero–septiembre)** | **242,2** ← dato que reporta la tesista |
| 2025 completo (anual) | 800,3 |

*Verificación:* 2026: (234+317+238+347+150+202+221+232+239)/9 = 2 180/9 = **242,22** ✓.

**Por qué este indicador es el más fuerte de todos:** no mide un síntoma, mide el trabajo que ya se hace a mano para evitar el problema. Existe un proceso informal, no documentado ni auditable, que hace exactamente lo que el método formalizaría. Tres consecuencias:

1. Es la **línea base natural** del criterio de carga: hoy se absorben ~242 ítems por mes.
2. Es la **respuesta a la objeción de que el problema ya está resuelto**: lo que existe es un cambio que queda en el log del sistema pero **sin reporte accesible, sin constancia del criterio, sin aprendizaje entre ciclos y sin auditoría posible**.
3. Es el **límite de capacidad** para fijar el criterio de éxito n.º 3 antes de construir.

### Regla de detección vigente — escrita por primera vez (2 oct 2026)

La regla que hoy aplica el encargado de facturación, declarada por la tesista:

> Se compara el consumo del mes contra el **histórico de los últimos 6 meses**, en **las dos direcciones**. Superior: estufas en invierno, aire acondicionado en épocas de calor, fiestas. Inferior: viajes, vacaciones.

| Elemento | ¿Está? | Observación |
|:--|:--|:--|
| Ventana temporal | **Sí** | 6 meses |
| Dirección | **Sí** | Dos colas: superior e inferior |
| Razonamiento de dominio | **Sí** | Descuenta estacionalidad y eventos de la vida del usuario |
| Umbral numérico | **No** | "Diferente" no es una cantidad. Hoy vive en el criterio de una persona |
| Registro de la decisión | **No** | No consta por qué se marcó o descartó una lectura |

**Consecuencias para las etapas siguientes:**

- **E7b:** fijar el umbral es decisión de diseño y debe fijarse **antes** de construir.
- **E7c:** la regla actual descuenta la estacionalidad por juicio. Un detector estadístico ingenuo marcaría cada invierno y cada verano como anomalía: el tratamiento de estacionalidad es requisito, no detalle.
- **Restricción de datos — resuelta en el origen y desbloqueada a nivel agregado:** el histórico llega **desde 2022** (declarado el 2 oct 2026), es decir 57 meses y cuatro ciclos anuales completos: la estacionalidad es modelable. **A2.4 quedó ejecutado el 5 oct 2026** con `DATOS desde 2022.xlsx`, de modo que **cada mes del calendario ya se repite cuatro veces** y E7c tiene con qué trabajar. **Lo que sigue pendiente no es la ventana sino el nivel:** el archivo saneado es agregado, sin cuenta ni id, así que **no hay aún panel de consumo por cuenta y mes** — eso es A2.1–A2.3 y es lo que abre E7b.

**Capacidad como techo de alertas:** 242 correcciones mensuales ÷ 22 días hábiles ≈ **11 visitas por día**. Esa es la capacidad actual del equipo técnico y el techo que el volumen de alertas de E7b no debe exceder — sin contar las visitas que no terminan en corrección, cifra aún desconocida.

### Ruptura estructural de junio de 2025 — explicada

De 1 507 correcciones mensuales (ene–may 2025) a 295 (jun–dic 2025): una caída de **~80 %**. **Causa declarada el 1 oct 2026:** hubo **capacitaciones al personal en mayo y junio de 2025** para evitar los errores. Las lecturas las registra **personal terciarizado de la empresa**, que es el destinatario de esa capacitación. El corte de la serie cae exactamente en junio, coherente con las fechas declaradas. Consecuencias:

1. **La gestión 2025 no sirve como línea base única.** La serie contiene un cambio de régimen: cualquier promedio anual (800,3) mezcla dos estados distintos. La línea base utilizable es la posterior a la capacitación: **295** (jun–dic 2025) y **242,2** (2026).
2. **La capacitación es una mitigación ya aplicada y con efecto demostrable.** Esto obliga a declarar el problema con precisión: no es que nadie haya actuado, es que **una intervención de capacitación que funcionó dejó un residual de ~242 correcciones manuales por mes**. Ese residual —y no el pico de 1 507— es lo que el método debe atacar.
3. **Entra como alternativa existente en E7a.** La capacitación no es un invento del diseño: es la solución que la organización ya probó. El método debe compararse contra ella, no contra la inacción.
4. **El personal es terciarizado:** la capacitación fue a personal de una empresa contratada. Esto introduce un factor de rotación y de dependencia contractual que el método debe considerar — quien toma las lecturas no es el mismo que quien las corrige ni quien las verifica.

> **Advertencia de interpretación:** la atribución es declarativa, no experimental. La capacitación coincide en el tiempo con la caída; no se ha aislado ninguna otra variable (cambio de proceso, migración, relectura). Conviene decir "se atribuye a las capacitaciones" y no "las capacitaciones causaron la caída". El carácter único o periódico de la capacitación sigue sin precisarse: se sabe que fue en mayo y junio de 2025, no si se repite.

## Indicador 3 — Volumen y carga de los reclamos

| Concepto | Valor |
|:--|--:|
| Reclamos tramitados en 57 meses | **1 053** (≈ 18,5/mes) · *ventana de 21 meses: 314 (≈ 15/mes)* |
| Procedentes en 57 meses | **174 (16,52 %)** (≈ 3/mes) · *ventana de 21 meses: 62 (≈ 3/mes)* |
| Improcedentes en 57 meses | **879** (**83,48 %** del total) · *ventana de 21 meses: 252 (80,25 %)* |
| Carga de inspección de los improcedentes | Los mismos 3 a 15 días hábiles reglamentarios |

**Hallazgo:** cuatro de cada cinco reclamos se resuelven en contra del usuario, pero consumen la misma inspección técnica que los procedentes. Eso abre un segundo frente de utilidad para el método: además de encontrar lo que no se marcó, puede dar al verificador evidencia para resolver improcedentes sin desplazamiento.

## Indicadores previstos y estado

| # | Indicador | Línea base | Estado |
|:--|:--|:--|:--|
| 1 | Reclamos procedentes sin código | **136 de 174 (78,16 %)**; razón de tasas **31,3×** — 57 meses | **Medido** (actualizado a 57 meses, DEC-33) |
| 2 | Reclamos totales y procedencia | **1 053 totales, 174 procedentes (16,52 %)** — 57 meses | **Medido** (actualizado a 57 meses, DEC-33) |
| 3 | Proporción de lecturas con código | **0,88 %** del facturable — 57 meses | **Medido** (actualizado a 57 meses, DEC-33) |
| 4 | Correcciones manuales mensuales | 242,2 (2026); 295 (jun–dic 2025, post-capacitación); naturaleza: **lectura mal tomada** | **Medido y explicado** (capacitación may–jun 2025 a personal terciarizado) |
| 5 | Tiempo de verificación por caso | Rama 1: revisión del consumo en pantalla. Rama 2: visita al domicilio + fotografía. Estimado hoy: 3 a 4 horas; 2 días con visita | **Promedio en consulta** (pendiente, 2 oct 2026) |
| 6 | Tiempo de respuesta ODECO | Plazo reglamentario 3 a 15 días hábiles | Consulta 2.3 pendiente |
| 7 | Evidencia fotográfica de la corrección | Se obtiene en visita; **almacenada en la computadora del encargado de facturación**, fuera del sistema y sin enlace al registro corregido | **Silo de evidencia** confirmado el 2 oct 2026 |
| 8 | Regla de detección actual | Desviación frente a 6 meses, en las dos direcciones; **sin umbral numérico ni registro** | **Descrita** por la tesista el 2 oct 2026 |
| 9 | Visitas que no terminan en corrección | No se conoce — es la tasa de falsos positivos de la detección manual actual | Pendiente: es la línea base del criterio 2 |

> **Nota sobre las líneas base de los indicadores 1, 2 y 3 — actualizadas el 6 de octubre de 2026 (DEC-33).** Instrucción de la tesista: *«actualiza a 57»*. Se fijaron el 1 de octubre de 2026 sobre la ventana de 21 meses de `DATOS.xlsx` —**46 de 62 = 74,19 % con razón 33,1×** · **314 totales y 62 procedentes = 19,75 %** · **1,04 %**— y se reemplazan por las mismas magnitudes medidas en **57 meses**: **78,16 % (136 de 174) con razón 31,3×** · **1 053 totales y 174 procedentes = 16,52 %** · **0,88 %**. **Tres precisiones sobre qué cambió y qué no.** **(a)** Se actualiza la **línea base**, que es la medición del problema; **ningún umbral de éxito se ha fijado todavía** — eso es de E7b y sigue abierto—, así que no hay criterio que se haya movido. **(b)** El cambio se hace **antes de construir**: A2.1–A2.3 ni siquiera están ejecutados, de modo que la disciplina de «fijarlo antes de construir» se cumple más estrictamente con la ventana más larga que con la corta. **(c)** Las cifras de 21 meses **no se borran**: siguen en la cabecera de este documento, en la prueba de continuidad y en la tabla del Indicador 1, **siempre con su ventana declarada**, porque son la referencia que permitió comprobar que las dos extracciones dicen lo mismo. *La razón de tasas pasa de 33,1× a 31,3× y el porcentaje de procedentes sube de 74,19 % a 78,16 %: la conclusión se refuerza, no se altera.*

## Dato invalidado — retirado definitivamente

**La cifra del 30 de septiembre —207 reclamos procedentes en el ciclo de agosto, 200 sin código, 96,6 %— se retira por decisión de la tesista del 1 oct 2026.** No se reproduce ni se investiga más: queda suprimida de todos los documentos.

Sustituto verificado: el archivo consolidado registra para agosto de 2026 un total de **5 reclamos** (1 procedente, 4 improcedentes) en la regional de 29 750 cuentas. En 21 meses completos hubo 314 reclamos y 62 procedentes, de modo que 207 procedentes en un solo mes era imposible dentro de este ámbito: la cifra no pertenecía a esta regional o contaba filas duplicadas.

**Lección de trazabilidad:** ningún número vuelve a entrar en un documento sin su consulta y su fuente declaradas. La evidencia vigente es `DATOS.xlsx` y nada más.

## Vacíos que restan para cerrar E6

1. **Ejecutar la extracción ampliada a enero de 2022** (57 meses, cuatro ciclos anuales completos). *Confirmado el 2 oct 2026:* reclamos y correcciones llegan a 2022, mismo esquema, extracción viable. Especificación A2.1–A2.4 en `consultas_base_datos.md`, con verificación de reproducibilidad obligatoria. Condiciona la estacionalidad de E7c y la verdad de referencia de E8.
2. **Tiempo promedio por corrección manual**, en consulta con el personal. Debe venir **desglosado por rama** —revisión en pantalla y visita con fotografía—, porque consumen tiempos distintos. Condiciona el criterio de éxito n.º 3. *(Pendiente de respuesta, 2 oct 2026.)* **Redactado el seguimiento con la especificación fina el 19 oct 2026 (DEC-41):**

   > **Asunto:** Seguimiento — tiempo por corrección manual de lectura, desglosado por rama
   >
   > Estimado/a docente:
   >
   > El 2 de octubre de 2026 le envié una consulta sobre el tiempo que consume cada corrección manual de lectura. Doy seguimiento porque esa respuesta es la que me permite **fijar, antes de construir, el valor de uno de los criterios de éxito de mi estudio**. Sin ella no puedo cerrar esa sección.
   >
   > Necesito el **tiempo promedio por corrección**, separado en dos ramas, porque consumen tiempos muy distintos:
   >
   > | Rama | Qué incluye |
   > |:--|:--|
   > | **Revisión en pantalla** | Detección y corrección hechas en el sistema, sin desplazamiento |
   > | **Visita con fotografía** | Desplazamiento al domicilio, respaldo fotográfico del medidor y retorno a la oficina |
   >
   > Para **cada rama** necesito tres cosas:
   >
   > 1. **El tiempo promedio por corrección**, en minutos u horas.
   > 2. **Cuántas correcciones corresponden a cada rama**, para poder ponderar el total. *Si no viene desglosado, sirve el total de correcciones y el tiempo promedio general, con la aclaración de que no está separado por rama.*
   > 3. **El periodo exacto** al que corresponde el dato —mes, gestión o rango de fechas— y **de dónde sale**: reporte del sistema, planilla de control o estimación del personal.
   >
   > **Si ese tiempo no está registrado en ningún sistema y es una estimación del personal, dígamelo así.** Lo registraré como estimación declarada y no como medición, y esa distinción queda escrita en el estudio. Lo que no puedo hacer es fijar un valor de criterio sin saber de dónde salió.
   >
   > Le agradecería la respuesta **antes del 22 de octubre de 2026**, fecha en la que cierro esa parte del estudio.
   >
   > Agradezco de antemano. Quedo atenta.
   >
   > Natalia Fabiola Medrano Cambará

   **Cierre de la pregunta, 19 oct 2026 (DEC-42):** la respuesta fue **«el tiempo no está registrado en ningún sistema, no está medido»**. Se registra como **dato no disponible**, que era la respuesta prevista en la propia consulta, y **no como cero ni como estimación**. **Consecuencia REAL: SÍ bloquea. (CORREGIDO EL MISMO DÍA, DEC-44.)** El criterio 3 de `02_delimitacion.md` es **«Carga de verificación: alertas generadas por ciclo dentro de la capacidad real del equipo (base: 3 a 4 h por caso)»**, y **trae su línea base escrita como 3 a 4 horas por caso**. La respuesta de hoy declara **que ese dato no está medido**, de modo que **los 3 a 4 h quedan como estimación declarada y no como medición**, y **E7b no puede fijar el valor del criterio 3 con dato medido**. **Inconsistencia que la medición habría cerrado y que queda abierta:** la capacidad de **≈11 visitas por día** —242 correcciones mensuales ÷ 22 días hábiles— **multiplicada por 3 a 4 h por caso da 33 a 44 horas por día**, que **no cabe en una jornada**. Solo se sostiene si el equipo es **varias personas** o si las 3 a 4 h son **tiempo transcurrido y no horas-hombre**. **Hay que declararlo en E6, y no se puede resolver con dato propio.**

3. **Visitás que no terminan en corrección:** ¿cuántas solicitudes de visita al domicilio terminan sin cambiar la lectura? Es la tasa de falsos positivos de la detección manual actual y la línea base del criterio 2. **Consulta redactada por primera vez el 19 oct 2026 (DEC-41), sin enviar:**

   > **Asunto:** Consulta — visitas al domicilio que no terminan en cambio de lectura
   >
   > Estimado/a docente:
   >
   > Estoy estableciendo la línea base de mi estudio y necesito saber **cuántas de las visitas que se hacen al domicilio terminan sin cambiar la lectura**. Ese dato es la tasa de falsos positivos de la detección manual actual, y sin él no puedo fijar uno de mis criterios de éxito.
   >
   > **Primero necesito saber si el dato se registra:**
   >
   > 1. ¿Existe algún registro de **solicitudes de visita al domicilio** para verificar una lectura? Si existe, ¿en qué sistema o planilla?
   >
   > **Si existe, necesito para el periodo que se pueda —preferentemente enero de 2022 a septiembre de 2026—:**
   >
   > 2. **Total de solicitudes de visita** en ese periodo.
   > 3. **Cuántas terminaron con cambio de lectura** —la lectura registrada se modificó tras la visita—.
   > 4. **Cuántas terminaron sin cambio de lectura** —la lectura quedó igual que antes de la visita—.
   > 5. **El periodo exacto** de cada cifra y **de dónde sale**.
   >
   > **Si el dato no existe o no se puede extraer, dígamelo así y no lo estime.** Registraré «dato no disponible» en el estudio, y esa es una respuesta válida para mí. Lo que no puedo hacer es publicar un número que después nadie pueda reproducir.
   >
   > Para mí sirve también:
   >
   > - un **conteo de un año representativo**, si el total de 57 meses no se puede armar;
   > - o una **hoja de cálculo mes a mes**, que es lo que más me conviene para calcular la tasa.
   >
   > Le agradecería la respuesta **antes del 22 de octubre de 2026**, que es cuando cierro esa sección.
   >
   > Agradezco de antemano. Quedo atenta.
   >
   > Natalia Fabiola Medrano Cambará

   **Advertencia corregida el 19 oct 2026 (DEC-42):** el techo de **≈11 visitas por día** se derivó como *242 correcciones mensuales ÷ 22 días hábiles*. **La advertencia que estaba escrita aquí estaba mal de dirección:** 242 son correcciones **efectivamente realizadas**, no una estimación de visitas, de modo que el techo **no puede estar sobreestimado** —lo que no se sabe es si el equipo despacha **más** visitas que esas 242, porque las visitas no se registran. **La consecuencia correcta:** 242/mes es un **piso** de la capacidad de visitas y no un techo; usarlo como tope de alertas es **conservador**, y por eso se sostiene.

   **Cierre de la pregunta, 19 oct 2026 (DEC-42):** la respuesta fue **«no existe registro de solicitud de visita a domicilio»**. Se registra como **dato no disponible**, que era la respuesta prevista en la propia consulta, y **no como cero**. **Consecuencia REAL: confirma que el criterio 2 NO tiene línea base, y esa ausencia ya estaba declarada. (CORREGIDO EL MISMO DÍA, DEC-44.)** El criterio 2 de `02_delimitacion.md` es **«Falsos positivos: proporción de alertas descartadas por el verificador»** y **trae su línea base escrita como «sin criterio actual»**. La respuesta de hoy **confirma que esa línea base no se puede construir con dato de ENDE**, porque no existe registro de las solicitudes de visita. **De modo que el criterio 2 se fija sin comparación contra el proceso actual, y esa es una limitación que se escribe y no se disimula.** **Comparador único disponible, rotulado con su alcance:** el **canal de reclamos** —174 de 1 053 terminaron en corrección, **16,52 % y 83,48 % de falsa alarma**—, **que no es el proceso completo** sino **solo una de las tres vías de detección**, de modo que sirve como referencia secundaria y declarada. **La pregunta queda cerrada, no pendiente.**
4. **Conciliación de los totales:** para 2025-01, la Tabla 2 suma 27 370 lecturas y la Tabla 3 suma 28 355. Diferencia de ~1 000 por mes; hay que declarar el filtro de cada tabla antes de publicar ambas.
5. **Consulta 2.3:** tiempos de respuesta reales en la ODECO.
6. **Destino completo de la fotografía:** se confirma que vive en la computadora del encargado; queda saber si además se imprime o se copia, y si existe algún respaldo si ese equipo falla.

7. **Personal que atiende la revisión y la corrección** — consulta redactada el 19 oct 2026 (DEC-46), sin enviar. **Motivo:** la capacidad documentada —**242 correcciones mensuales ÷ 22 días hábiles ≈ 11 por día**— y la base declarada del criterio 3 —**3 a 4 h por caso**— **no cuadran**: 11 × 3–4 h = **33 a 44 horas por día**, que **no cabe en la jornada de una persona**. De eso depende el **presupuesto de alertas**. **Si no hay respuesta o el dato no está medido, el criterio 3 se fija sobre la capacidad observada —DEC-45—, que es volumen y no horas.**

   > **Asunto:** Consulta — personal que atiende la revisión y corrección de lecturas
   >
   > Estimado/a docente:
   >
   > Estoy fijando, antes de construir, el valor de uno de mis criterios de éxito: la carga de verificación que mi método puede pedirle al equipo. Para eso necesito saber **cuántas personas atienden esa tarea**.
   >
   > La razón de la pregunta es que tengo **dos cifras que no cuadran entre sí** y necesito saber cuál aplica:
   >
   > - por un lado, **242 correcciones mensuales ÷ 22 días hábiles ≈ 11 correcciones por día**;
   > - por otro, una base declarada de **3 a 4 horas por caso**.
   >
   > **11 casos por día a 3 a 4 horas cada uno dan 33 a 44 horas por día**, que no cabe en la jornada de una sola persona. Necesito saber por qué se sostiene.
   >
   > Por favor, indíqueme:
   >
   > 1. **Cuántas personas** trabajan en la **revisión en pantalla** de lecturas.
   > 2. **Cuántas personas** trabajan en la **corrección y visita** a domicilio.
   > 3. Si las **3 a 4 horas por caso** son **horas-hombre** —tiempo total de todas las personas— o **tiempo transcurrido** —desde que se detecta hasta que se resuelve—.
   > 4. **El periodo al que corresponde** cada dato y **de dónde sale**.
   >
   > **Si alguna de estas cifras no está registrada, dígamelo así y no la estime.** Registraré «dato no disponible» y fijaré mi criterio sobre la capacidad observada —las 242 correcciones mensuales—, que sí es reproducible.
   >
   > Le agradecería la respuesta **antes del 22 de octubre de 2026**, fecha en la que cierro esa parte del estudio.
   >
   > Agradezco de antemano. Quedo atenta.
   >
   > Natalia Fabiola Medrano Cambará

### Cerrados

- ~~Naturaleza de las correcciones~~ → **lectura mal tomada**, por personal terciarizado (1 oct 2026).
- ~~Causa de la ruptura de junio de 2025~~ → **capacitaciones en mayo y junio de 2025** al mismo personal terciarizado (1 oct 2026).
- ~~Regla de detección actual~~ → **desviación frente a 6 meses, en las dos direcciones**, sin umbral numérico (2 oct 2026).
- ~~Cadena de corrección~~ → **cinco pasos y cinco roles** descritos el 2 oct 2026.
- ~~Destino de la fotografía~~ → **computadora del encargado de facturación**, fuera del sistema (2 oct 2026).
- ~~Procedencia de la cifra de 207~~ → **retirada definitivamente** por decisión de la tesista (1 oct 2026); no se reproduce.
- ~~Población~~ → **29 750 cuentas** exactas (1 oct 2026).
