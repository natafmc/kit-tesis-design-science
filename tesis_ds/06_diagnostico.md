# E6 — Diagnóstico con indicadores y línea base

> **Evidencia consolidada.** Fuente: extracción real de FACTUR, `DATOS.xlsx`, gestionada por la tesista el 1 de octubre de 2026. Ámbito de la extracción: regional de **29 750 cuentas** (dato exacto), gestiones 2025 y 2026 (21 meses, hasta septiembre de 2026). **Histórico de lecturas disponible desde 2022** (declarado el 2 oct 2026), aún sin extraer.
> Todos los valores fueron verificados aritméticamente contra el archivo antes de registrarse.
> **Disciplina de trazabilidad:** esta evidencia y los criterios se fijan antes de construir el artefacto.

## Población y alcance de la extracción

| Concepto | Valor | Fuente |
|:--|:--|:--|
| Cuentas de la regional | **29 750** (dato exacto comunicado por la tesista el 1 oct 2026; la cifra de 29 000 era un redondeo). Los registros de lectura por mes crecen de 28 355 (ene 2025) a 29 750 (sep 2026): **el universo no es fijo y los denominadores deben calcularse mes a mes**, no contra una población única | `DATOS.xlsx`, Tablas 2 y 3 |
| Lecturas facturables en 21 meses | 532 258 | Tabla 3 |
| Lecturas Tipo 1 (sin código de irregularidad) | 526 730 → **98,96 %** | Tabla 3 |
| Lecturas Tipo 2 y 3 (con código) | 5 528 → **1,04 %** | Tabla 3 |
| Lectura Tipo 0 | No genera factura; excluida del universo facturable | Nota del archivo |
| **Histórico disponible en `tfv_historico_lecturador`** | **desde 2022** (declarado por la tesista el 2 oct 2026). La extracción actual `DATOS.xlsx` solo cubre **ene 2025 – sep 2026 (21 meses)** | Declaración de la tesista; alcance del archivo |

**Tipos de lectura:** 0 = sin factura; 1 = sin código de irregularidad; 2 y 3 = con código de irregularidad. El archivo lo declara explícitamente.

### Consecuencia de que el histórico llegue hasta 2022

La restricción de estacionalidad queda **resuelta en el origen**: de 2022 a septiembre de 2026 hay **57 meses y cuatro ciclos anuales completos** (2022, 2023, 2024 y 2025), de modo que una línea base de "mismo mes del año anterior" es viable y la regla actual de 6 meses puede contrastarse contra varios años.

Pero **la extracción hay que ampliarla.** Mientras `DATOS.xlsx` cubra 21 meses, la evidencia del documento sigue teniendo un solo ciclo anual por mes del calendario. Ampliarla a enero de 2022 es condición para:

- modelar estacionalidad con más de dos ciclos;
- conocer el volumen real de reclamos disponible como verdad de referencia en E8;
- ver si las correcciones manuales ya se registraban antes de la capacitación de 2025;
- comparar el universo de cuentas de 2022 con el actual (29 750), porque los denominadores cambiarán.

**Decisión de la tesista (2 oct 2026):** `tfv_reclamo` y la serie de correcciones **sí llegan hasta 2022**, con **mismo esquema**, y la extracción ampliada **es viable**. Ver especificación A2.1–A2.4 en `consultas_base_datos.md`.

## Indicador 1 — Reclamos ODECO por tipo de lectura y procedencia

Período 2025-01 a 2026-09. `sw_procedente`: 1 = procedente, 2 = improcedente, 4 = improcedente administrativo.

| Grupo | Total | Tipo 1 (sin código) | Tipo 2–3 (con código) | % Tipo 1 |
|:--|--:|--:|--:|--:|
| **Procedentes** | **62** | **46** | **16** | **74,19 %** |
| Improcedentes | 252 | 249 | 3 | 98,81 % |
| **Total tramitado** | **314** | **295** | **19** | **93,95 %** |

*Verificación:* 62 + 252 = 314 ✓; 46 + 16 = 62 ✓; 249 + 3 = 252 ✓; 46 + 249 = 295 ✓; 295/314 = 93,95 % ✓; 46/62 = 74,19 % ✓; 249/252 = 98,81 % ✓.

### Las tres cifras que deben publicarse juntas

El 74,19 % aislado es engañoso, porque el 98,96 % de las lecturas facturables son Tipo 1. La lectura correcta exige los tres números:

1. **Cobertura:** el 74,19 % de los reclamos procedentes provino de lecturas **sin** código. Auditar solo las lecturas con código habría alcanzado como máximo **16 de 62** procedentes (25,81 %) y se habría quedado sin detectar **46** (74,19 %). *Este es el argumento que sostiene la Opción 2.*
2. **Rendimiento por lectura:** las lecturas **con** código son el 1,04 % del universo, pero originan el 25,81 % de los procedentes.

| Tasa (procedentes por 100 000 lecturas) | Tipo 1 | Tipo 2–3 | Razón |
|:--|--:|--:|--:|
| Procedentes | 8,73 | 289,44 | **33,1 ×** |
| Improcedentes | 47,27 | 54,27 | 1,15 × |

3. **Conclusión válida:** las lecturas con código son **33 veces más propensas** a generar un reclamo procedente que las que no lo tienen, pese a ser el 1 % del volumen. Tener código es una **señal de riesgo de alta potencia**, no un ámbito suficiente de trabajo.

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
- **Restricción de datos — resuelta en el origen, pendiente en la extracción:** el histórico llega **desde 2022** (declarado el 2 oct 2026), es decir 57 meses y cuatro ciclos anuales completos: la estacionalidad es modelable. Lo que falta es que `DATOS.xlsx` cubra esos años; hoy solo cubre 21 meses, y con ellos cada mes del calendario se repite una sola vez. **Ampliar la extracción es condición para poder diseñar E7c.**

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
| Reclamos tramitados en 21 meses | 314 (≈ 15/mes) |
| Procedentes en 21 meses | 62 (≈ 3/mes) |
| Improcedentes | 252 (**80,25 %** del total) |
| Carga de inspección de los improcedentes | Los mismos 3 a 15 días hábiles reglamentarios |

**Hallazgo:** cuatro de cada cinco reclamos se resuelven en contra del usuario, pero consumen la misma inspección técnica que los procedentes. Eso abre un segundo frente de utilidad para el método: además de encontrar lo que no se marcó, puede dar al verificador evidencia para resolver improcedentes sin desplazamiento.

## Indicadores previstos y estado

| # | Indicador | Línea base | Estado |
|:--|:--|:--|:--|
| 1 | Reclamos procedentes sin código | 46 de 62 (74,19 %); razón de tasas 33,1× | **Medido** |
| 2 | Reclamos totales y procedencia | 314 totales, 62 procedentes (19,75 %) | **Medido** |
| 3 | Proporción de lecturas con código | 1,04 % del facturable | **Medido** |
| 4 | Correcciones manuales mensuales | 242,2 (2026); 295 (jun–dic 2025, post-capacitación); naturaleza: **lectura mal tomada** | **Medido y explicado** (capacitación may–jun 2025 a personal terciarizado) |
| 5 | Tiempo de verificación por caso | Rama 1: revisión del consumo en pantalla. Rama 2: visita al domicilio + fotografía. Estimado hoy: 3 a 4 horas; 2 días con visita | **Promedio en consulta** (pendiente, 2 oct 2026) |
| 6 | Tiempo de respuesta ODECO | Plazo reglamentario 3 a 15 días hábiles | Consulta 2.3 pendiente |
| 7 | Evidencia fotográfica de la corrección | Se obtiene en visita; **almacenada en la computadora del encargado de facturación**, fuera del sistema y sin enlace al registro corregido | **Silo de evidencia** confirmado el 2 oct 2026 |
| 8 | Regla de detección actual | Desviación frente a 6 meses, en las dos direcciones; **sin umbral numérico ni registro** | **Descrita** por la tesista el 2 oct 2026 |
| 9 | Visitas que no terminan en corrección | No se conoce — es la tasa de falsos positivos de la detección manual actual | Pendiente: es la línea base del criterio 2 |

## Dato invalidado — retirado definitivamente

**La cifra del 30 de septiembre —207 reclamos procedentes en el ciclo de agosto, 200 sin código, 96,6 %— se retira por decisión de la tesista del 1 oct 2026.** No se reproduce ni se investiga más: queda suprimida de todos los documentos.

Sustituto verificado: el archivo consolidado registra para agosto de 2026 un total de **5 reclamos** (1 procedente, 4 improcedentes) en la regional de 29 750 cuentas. En 21 meses completos hubo 314 reclamos y 62 procedentes, de modo que 207 procedentes en un solo mes era imposible dentro de este ámbito: la cifra no pertenecía a esta regional o contaba filas duplicadas.

**Lección de trazabilidad:** ningún número vuelve a entrar en un documento sin su consulta y su fuente declaradas. La evidencia vigente es `DATOS.xlsx` y nada más.

## Vacíos que restan para cerrar E6

1. **Ejecutar la extracción ampliada a enero de 2022** (57 meses, cuatro ciclos anuales completos). *Confirmado el 2 oct 2026:* reclamos y correcciones llegan a 2022, mismo esquema, extracción viable. Especificación A2.1–A2.4 en `consultas_base_datos.md`, con verificación de reproducibilidad obligatoria. Condiciona la estacionalidad de E7c y la verdad de referencia de E8.
2. **Tiempo promedio por corrección manual**, en consulta con el personal. Debe venir **desglosado por rama** —revisión en pantalla y visita con fotografía—, porque consumen tiempos distintos. Condiciona el criterio de éxito n.º 3. *(Pendiente de respuesta, 2 oct 2026.)*
3. **Visitás que no terminan en corrección:** ¿cuántas solicitudes de visita al domicilio terminan sin cambiar la lectura? Es la tasa de falsos positivos de la detección manual actual y la línea base del criterio 2.
4. **Conciliación de los totales:** para 2025-01, la Tabla 2 suma 27 370 lecturas y la Tabla 3 suma 28 355. Diferencia de ~1 000 por mes; hay que declarar el filtro de cada tabla antes de publicar ambas.
5. **Consulta 2.3:** tiempos de respuesta reales en la ODECO.
6. **Destino completo de la fotografía:** se confirma que vive en la computadora del encargado; queda saber si además se imprime o se copia, y si existe algún respaldo si ese equipo falla.

### Cerrados

- ~~Naturaleza de las correcciones~~ → **lectura mal tomada**, por personal terciarizado (1 oct 2026).
- ~~Causa de la ruptura de junio de 2025~~ → **capacitaciones en mayo y junio de 2025** al mismo personal terciarizado (1 oct 2026).
- ~~Regla de detección actual~~ → **desviación frente a 6 meses, en las dos direcciones**, sin umbral numérico (2 oct 2026).
- ~~Cadena de corrección~~ → **cinco pasos y cinco roles** descritos el 2 oct 2026.
- ~~Destino de la fotografía~~ → **computadora del encargado de facturación**, fuera del sistema (2 oct 2026).
- ~~Procedencia de la cifra de 207~~ → **retirada definitivamente** por decisión de la tesista (1 oct 2026); no se reproduce.
- ~~Población~~ → **29 750 cuentas** exactas (1 oct 2026).
