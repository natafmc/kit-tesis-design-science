# Consultas a la base de datos

> Lista de datos que la base debe entregar, por etapa. Prioridad alta = bloquea una etapa; media = la mejora; baja = informativo.
> **Nota:** los nombres de columnas y tablas son supuestos. El **Bloque 0** existe para reemplazarlos por los reales antes de ejecutar cualquier cosa.

## Estado de ejecución (1 de octubre de 2026)

La extracción consolidada `DATOS.xlsx` respondió los bloques 1 y 2, y **invalidó dos de los estimados** que aquí se listaban:

| Ítem | Estimado anterior | Valor medido |
|:--|:--|:--|
| Reclamos totales | ~50/mes | **314 en 21 meses** (≈ 15/mes) |
| Reclamos procedentes | ~40/mes | **62 en 21 meses** (≈ 3/mes) |
| Lecturas con código | ~5 000 de 20 000 (25 %) | **5 528 de 532 258 (1,04 %)** |
| Cuentas de la regional | 20 000 / 29 000 | **29 750** exactas |

Los bloques 1, 2 y 3 quedan **substituidos por `DATOS.xlsx`**. Siguen en pie: **Bloque 0** (estructura, para reproducir y explicar la cifra invalidada del 30 de sep) y **consulta 2.3** (tiempos de respuesta en la ODECO).

## Esquema confirmado — Bloque 0 cerrado (2 oct 2026)

Nombres y campos entregados por la tesista. **Sustituyen a todos los supuestos** anteriores. El nombre `tfv_histo_lec` que aparece en los documentos es **incorrecto**: la tabla real del histórico del lecturador es `tfv_historico_lecturador`.

| Tabla | Campos |
|:--|:--|
| `tfv_historico_lecturador` | `id_histo_lecturador`, `nro_cuenta`, `lec_actual`, `consumo`, `id_lectura`, `fecha_lec` |
| `tfv_reclamo` | `id_reclamo`, `nro_reclamo`, `nro_cuenta`, `tipo_reclamo`, `fecha_hora_reg` |
| `tfv_reclamo_lectura` | `id_reclamo_lectura`, `id_reclamo`, `id_lectura`, `sw_proceso`, `importe`, `lectura_actual` *(solo cuando es procedente, para la respuesta)*, `fecha_odeco` |

**Llaves de enlace resueltas:**

- `nro_cuenta` comunica `tfv_reclamo` ↔ `tfv_historico_lecturador`: un reclamo se puede llevar a la cuenta y a su serie de consumo.
- `id_lectura` comunica `tfv_historico_lecturador` ↔ `tfv_reclamo_lectura`: un reclamo se puede llevar a la lectura concreta.

### Tres huecos que el esquema revela — **los tres cerrados el 5 de octubre de 2026**

| # | Faltaba | Estado | Cómo se cerró |
|:--|:--|:--|:--|
| **B1** | **La tabla del tipo de lectura (0/1/2/3) y del código de irregularidad** | **CERRADO** | El archivo `DATOS desde 2022.xlsx`, hoja `tipo_lectura`, trae el dominio declarado por la tesista: **0 = LC lectura de corte (no facturada) · 1 = LN lectura normal (objeto de investigación) · 2 = LE lectura estimada · 3 = NE normal estimada.** El indicador 1 de E6 se regenera: lo reproduce la Prueba 1 de más abajo |
| **B2** | **La tabla de la lectura facturada**, para derivar las ~242,2 correcciones/mes | **CERRADO** | **No hacía falta tabla nueva: la serie ya estaba en la hoja `historico`.** El 242,2 y el 800,3 salen de `lecturas_diferentes` — Prueba 2. El origen de las dos cifras queda trazado, que era lo que faltaba |
| **B3** | Confirmar que `sw_proceso` equivale al `sw_procedente` (1 / 2 / 4) | **CERRADO en lo que afecta a la evidencia** | La tesista declara el dominio de `sw_procendente` en `reclamos`: **1 = Procedente · 2 = Improcedente · 4 = Improcedente administrativo** — idéntico al de `DATOS.xlsx`. **Queda pendiente solo el nombre de la columna en la base** (`tfv_reclamo_lectura.sw_proceso`), que es asunto de la extracción SQL y no afecta a ninguna cifra de E6 |

**Consultas escritas:** `sql_a2_extraccion.sql`. El Bloque 0 de ese archivo se ejecuta primero; si la prueba de reproducibilidad (314 y 62) no cuadra, no se continúa. *Estado del 5 oct: la prueba 1 ya cuadró **sin** ejecutar el SQL, con el archivo saneado — ver Prueba 1. **La consulta SQL queda pendiente para A2.1, A2.2 y A2.3**, que sí necesitan el nivel de registro.*

## Serie histórica saneada 2022–2026 — recibida y verificada (5 de octubre de 2026)

**Fuente.** `C:\Users\Toshiba\Downloads\DATOS desde 2022.xlsx`, 20 191 bytes, entregado por la tesista el **5 de octubre de 2026 a las 17:40**. Serie multianual saneada, gestiones 2022 a 2026.

**Especificación de lectura (declarada por la tesista antes de abrir el archivo):** las tres hojas inician sus encabezados en la **fila 2** (`header=1`), con datos libres de nulos estructurales. En `reclamos`, `sw_procendente` codifica el estado resolutivo (**1 = Procedente, 2 = Improcedente, 4 = Improcedente administrativo**). En `tipo_lectura`, los dominios son **0 = LC, 1 = LN, 2 = LE, 3 = NE**.

**Consulta ejecutada.** Microsoft Excel 16.0 vía COM desde Windows PowerShell 5.1. Scripts, en `C:\Users\Toshiba\AppData\Local\Temp\opencode\`: `inspect_datos.ps1` (estructura), `dump_datos2022.ps1` (series), `verify_datos2022.ps1` (pruebas de reproducibilidad). **Registro conforme a DEC-13: sin estos tres scripts la ejecución no cuenta.**

**Estructura leída:**

| Hoja | Encabezado | Filas de datos | Columnas |
|:--|:--|--:|:--|
| `reclamos` | fila 2 | 104 | `gestion`, `periodo`, `cantidad_odecos`, `cantidad_tipo_lectura_1`, `cantidad_tipo_lectura_diferente_1`, `sw_procendente` |
| `historico` | fila 2 | 57 | `gestion_lec`, `mes`, `total_lecturas`, `lecturas_iguales`, `lecturas_diferentes` |
| `tipo_lectura` | fila 2 | 228 | `gestion_lec`, `mes`, `tipo_lectura`, `cantidad` |

*57 filas de `historico` = enero 2022 – septiembre 2026, exactamente los 57 meses previstos. `reclamos` tiene 57 meses con datos (12+12+12+12+9).*

### Prueba 1 — reproducir `DATOS.xlsx` (9 de 9 exactas)

**Pregunta:** ¿es este archivo la misma fuente que la extracción corta? **Si las nueve cifras de `DATOS.xlsx` salen de aquí filtrando 2025+2026, la serie saneada es continuación y no sustituto.**

*Cálculo:* sumar las tres hojas restringiendo `gestion ≥ 2025`.

| Cifra de `DATOS.xlsx` | Recalculada desde el archivo nuevo | Coincide |
|:--|--:|:--|
| Reclamos = **314** | 213 (2025) + 101 (2026) = **314** | ✔ |
| Procedentes = **62** | 46 + 16 = **62** | ✔ |
| Procedentes Tipo 1 = **46** | 35 + 11 = **46** | ✔ |
| % procedentes = **19,75** | 62/314 = **19,75 %** | ✔ |
| % Tipo 1 sobre procedentes = **74,19** | 46/62 = **74,19 %** | ✔ |
| Facturable Tipo 1 = **526 730** | 298 472 + 228 258 = **526 730** | ✔ |
| Facturable Tipo 2–3 = **5 528** | (2 015 + 995) + (1 626 + 892) = **5 528** | ✔ |
| Facturable total = **532 258** | **532 258** | ✔ |
| % Tipo 1 del facturable = **98,96** | 526 730/532 258 = **98,96 %** | ✔ |

*Además:* 5 528/532 258 = **1,04 %** ✔ · 295 = 201 (2025) + 94 (2026) Tipo 1 de todos los reclamos ✔ · 19 = 12 + 7 Tipo 2–3 ✔.

### Cotejo de agosto de 2026 — filas crudas, los dos archivos (6 de octubre de 2026)

*Solicitado por la tesista el 6 oct tras impugnar la cifra. Relectura directa de las filas, no de los agregados.*

| Archivo | Fila | gestion | periodo | `cantidad_odecos` | `cantidad_tipo_lectura_1` | `tipo_lectura_diferente_1` | `sw_procendente` |
|:--|:--|--:|--:|--:|--:|--:|--:|
| `DATOS.xlsx` (Hoja2) | f038 | 2026 | 8 | 1 | 0 | 1 | 1 |
| `DATOS.xlsx` (Hoja2) | f039 | 2026 | 8 | 4 | 4 | 0 | 2 |
| **`DATOS desde 2022.xlsx`** | fila 103 | 2026 | 8 | 1 | 0 | 1 | 1 |
| **`DATOS desde 2022.xlsx`** | fila 104 | 2026 | 8 | 4 | 4 | 0 | 2 |

> **Los dos archivos son idénticos. No hay desfase.** Agosto de 2026: **5 reclamos totales** (1 + 4), de los cuales **4 son tipo 1** y **4 improcedentes, 1 procedente**. **La cifra «8» no aparece en ninguno de los dos** para 2026-08; corresponde a **agosto de 2025** (f016 = 1 + f017 = 7 = **8**). Retirada por DEC-25.
>
> **Única cuestión abierta — convención de publicación:** cuando se diga «reclamos de agosto de 2026», ¿se contará el **total (5)**, el **tipo 1 (4)** o los **improcedentes (4)**? Las tres son correctas y dicen cosas distintas; **hay que elegir una y fijarla antes de publicar cualquier serie mensual**.
>
> **Resuelta el 6 oct 2026 — DEC-26: se publica el total (5).** «Reclamos de un mes» = `cantidad_odecos` sumado en ese periodo. Las otras dos lecturas se publican al lado, etiquetadas: tipo 1 = 4, improcedentes = 4, procedentes = 1. **Justificación:** es la única columna con la que cuadraron las nueve cifras de la Prueba 1 y la que ya usa el Indicador 1 de E6; usar otra pondría a la serie una base distinta que la del resto del documento.

> **Conclusión de la Prueba 1.** **Las nueve cifras reproducen exactamente.** `DATOS.xlsx` era la ventana **2025 + 2026** de esta misma serie. **La evidencia de E6 no se contradice: se extiende.** Y la regla de `consultas_base_datos.md` —*«si la extracción ampliada no reproduce esas tres cifras, ninguna de las dos sirve»*— **se cumplió en las tres** (reclamos 314/62 ✔, correcciones 242,2/1 507/295 ✔ —Prueba 2—, tipos 532 258/5 528 ✔).

### Prueba 2 — origen de 242,2 y 800,3

*Cálculo:* promedio mensual de `historico.lecturas_diferentes` por gestión.

| Gestión | Total `lecturas_diferentes` | Meses | Promedio |
|:--|--:|--:|--:|
| 2022 | 8 509 | 12 | **709,1/mes** |
| 2023 | 10 230 | 12 | **852,5/mes** |
| 2024 | 17 459 | 12 | **1 454,9/mes** |
| **2025** | **9 604** | 12 | **800,3/mes** ✔ coincide con el dato publicado |
| **2026** | **2 180** | 9 | **242,2/mes** ✔ coincide con el dato publicado |

*Y los dos segmentos de 2025 que sostienen el ~80 %:* ene–may = 7 537/5 = **1 507,4/mes** ✔ · jun–dic = 2 067/7 = **295,3/mes** ✔ · caída = **−80,4 %** ✔.

> **El linaje de 242,2 y de 800,3 queda establecido:** las dos cifras son **`historico.lecturas_diferentes`**, promedio mensual por gestión. **Había que declararlo**: hasta hoy decíamos «correcciones mensuales» sin decir de qué columna salían.

### Prueba 3 — indicadores de la serie completa (2022–2026, 57 meses)

**3.1 Reclamos por gestión y procedencia** — `reclamos`

| Gestión | Total | Procedentes (sw=1) | Procedentes Tipo 1 | % Tipo 1 |
|:--|--:|--:|--:|--:|
| 2022 | 104 | 14 | 11 | 78,57 % |
| 2023 | 326 | 49 | 40 | 81,63 % |
| 2024 | 309 | 49 | 39 | 79,59 % |
| 2025 | 213 | 46 | 35 | 76,09 % |
| 2026 (9 meses) | 101 | 16 | 11 | 68,75 % |
| **Total 2022–2026** | **1 053** | **174** | **136** | **78,16 %** |

*Por `sw_procendente`:* **1 (Procedente) = 174 · 2 (Improcedente) = 878 · 4 (Improcedente administrativo) = 1**. Suma = 1 053 ✔. *Comprobación interna:* `cantidad_tipo_lectura_1 + cantidad_tipo_lectura_diferente_1 = cantidad_odecos` en **las 104 filas, sin una sola excepción**.

**3.2 Tipos de lectura** — `tipo_lectura`

| Gestión | 0 · LC (no facturada) | 1 · LN | 2 · LE | 3 · NE |
|:--|--:|--:|--:|--:|
| 2022 | 22 542 | 277 917 | 1 475 | 812 |
| 2023 | 34 723 | 282 597 | 859 | 999 |
| 2024 | 41 294 | 290 397 | 1 318 | 1 309 |
| 2025 | 44 443 | 298 472 | 2 015 | 995 |
| 2026 (9 meses) | 34 782 | 228 258 | 1 626 | 892 |
| **Total** | **177 784** | **1 377 641** | **7 293** | **5 007** |

*Derivados:* facturable (1+2+3) = **1 389 941** · LN = **99,12 %** del facturable · LE+NE = **0,88 %** · LC no facturada = **177 784 = 11,34 %** del total (1 567 725).

**3.3 Lecturas diferentes del historial del lecturador** — `historico`

| Gestión | Total lecturas | Iguales | Diferentes | % diferentes | Promedio mensual |
|:--|--:|--:|--:|--:|--:|
| 2022 | 278 550 | 270 041 | 8 509 | 3,05 % | 709,1 |
| 2023 | 295 709 | 285 479 | 10 230 | 3,46 % | 852,5 |
| 2024 | 310 559 | 293 100 | 17 459 | **5,62 %** | 1 454,9 |
| 2025 | 342 149 | 332 543 | 9 604 | 2,81 % | 800,3 |
| 2026 (9 meses) | 264 393 | 262 213 | 2 180 | **0,82 %** | 242,2 |
| **Total** | **1 491 360** | **1 443 376** | **47 982** | **3,22 %** | — |

> **Reverificación de esta tabla, 6 de octubre de 2026** (script `verify_pct_anual.ps1`, mismo día en que las cifras se publicaron en `propuesta_borrador_v1.md`): se volvieron a sumar `total_lecturas`, `lecturas_iguales` y `lecturas_diferentes` por `gestion_lec` desde la fila 3. **Diez de diez coinciden.** Además, `total − iguales` iguala a `diferentes` en **cuatro de cinco años**; la única excepción es 2025 (9 606 frente a 9 604), que **es exactamente el defecto declarado más abajo**, de 2 unidades — lo que demuestra que el defecto es local y no sistemático.

**3.4 Tasas por 100 000, serie completa** — *procedentes ÷ facturable del mismo tipo × 100 000*

| Tasa | Tipo 1 (LN) | Tipo 2–3 (LE+NE) | Razón |
|:--|--:|--:|--:|
| Procedentes (2022–2026) | 136/1 377 641 → **9,87** | 38/12 300 → **308,94** | **31,3 ×** |
| *Ventana 2025–2026, para comparar* | *8,73* | *289,44* | *33,1 ×* |

> **La segmentación de la Opción 2 resiste la ampliación.** Con 57 meses en lugar de 21, el cociente pasa de 33,1× a **31,3×** —misma magnitud, tres veces más evidencia—. **Es el resultado más importante de este archivo:** la conclusión central de la propuesta no dependía de la ventana corta.

**3.5 Uso del código de irregularidad, por periodo — nuevo el 6 de octubre de 2026 (DEC-28)**

| Ventana | Meses | Tipo 2 + 3 (con código) | Facturable (1 + 2 + 3) | % con código |
|:--|--:|--:|--:|--:|
| 2022–2024 | 36 | 6 772 | 857 683 | **0,79 %** |
| 2025–2026 | 21 | 5 528 | 532 258 | **1,04 %** |
| **Total** | **57** | **12 300** | **1 389 941** | **0,88 %** |

*Consulta: hoja `tipo_lectura` de `DATOS desde 2022.xlsx`, suma de `cantidad` agrupada por `gestion_lec` y `tipo_lectura`, con `facturable = tipo 1 + tipo 2 + tipo 3` y `con código = tipo 2 + tipo 3`. Scripts `verify_pct_codigo.ps1` y `verify_tipo_vacio.ps1`, 6 de octubre de 2026.*

**Controles ejecutados — siete de siete:**

| Control | Esperado | Obtenido |
|:--|--:|--:|
| tipo 1 total | 1 377 641 | 1 377 641 ✔ |
| tipo 2 + 3 total | 12 300 | 12 300 ✔ |
| facturable total | 1 389 941 | 1 389 941 ✔ |
| tipo 0 (LC) total | 177 784 | 177 784 ✔ |
| tipo 1, 2025–2026 | 526 730 | 526 730 ✔ |
| tipo 2 + 3, 2025–2026 | 5 528 | 5 528 ✔ |
| facturable, 2025–2026 | 532 258 | 532 258 ✔ |

> **Nota de método — un control falló y la falla estaba en la consulta, no en el archivo.** En la primera corrida de `verify_pct_codigo.ps1`, el control `tipo 0 → 177 784` devolvió **0**. La causa: en PowerShell `0 -eq ""` evalúa **cierto**, porque la cadena vacía se convierte a 0 al compararse contra un entero; de modo que **todas las filas con `tipo_lectura = 0` se leyeron como «sin tipo»** y se saltearon —57 filas, una por mes—. Se descubrió porque un control no cuadró y se fue a leer la fila (`tipo=[0]` en las 57). **La hoja está correcta: el tipo 0 está guardado como 0**, y `verify_tipo_vacio.ps1` confirma que esas 57 filas suman exactamente 177 784. *Misma lección que DEC-25, aplicada esta vez a un script: si un control no cuadró, el error está casi siempre en la consulta.*

---

## Catálogo de códigos de irregularidad — `CODIGOS_IRREGULARES.xlsx` (6 de octubre de 2026, DEC-29)

**Fuente:** `C:\Users\Toshiba\Downloads\CODIGOS_IRREGULARES.xlsx`, 10 169 bytes, modificado el 6 oct 2026 a las 17:31. **Una sola hoja, `codigo_irregular`, encabezados en fila 1** —a diferencia de `DATOS desde 2022.xlsx`, que los trae en la 2—, **48 filas de datos, `id_cod_irre` de 0 a 47**.

**Columnas:** `id_cod_irre` · `desc_cod_irre` · `sw_aviso` · `estado` · `codigo` · `tipo_lectura`.

**Dominios medidos** (scripts `inspect_codigos.ps1` y `tally_codigos.ps1`, 6 oct 2026):

| Campo | Valores |
|:--|:--|
| `tipo_lectura` | **0 = 4 códigos · 1 = 30 · 2 = 6 · 3 = 8** (total 48) |
| `sw_aviso` | **si = 32 · no = 16** |
| `estado` | **1 en las 48** — todos activos |
| `codigo` | reproduce el `id`, **vacío en el 0** |

**Reparto de las 48 descripciones por familia, según `tipo_lectura`:**

| `tipo_lectura` | Códigos |
|:--|:--|
| **0 — LC, no facturada** (4) | 3 CASA DEMOLIDA · 9 USUARIO NO UBICADO · 40 CORTADO POR FALTA DE PAGO · 45 MEDIDOR RETIRADO |
| **1 — LN, lectura normal** (30) | 0 LECTURA NORMAL · 2 CASA CERRADA-DESOCUPADA · 8 MEDIDOR CAMBIADO DE LUGAR · 10 MEDIDOR NO REGISTRADO · 12 No. DE MEDIDOR DIFERENTE · 15 MEDIDOR DE CONTROL-PATRON · 16 MEDIDOR SIN PROTECCION INTERNA · 20 MEDIDOR CON SOBRECARGA · 23 SIN PRECINTO INTERNO · 24 PASE A TERCEROS · 25 PUENTE BAJO · 26 FUERA DE CATEGORIA · 27 CAJA EN MAL ESTADO · 28 FUERA DE RUTA · 29 ACOMETIDA EN MAL ESTADO · 30 DIRECCION NO LOCALIZADA · 31 VERIFICAR MULTIPLICADOR · 32 DUDA EN DIGITOS · 33 MEDIDOR A RELOJ · 34 MEDIDOR 5 AMP · 35 MEDIDOR 3 AMP · 36 MEDIDOR EN MAL ESTADO · 37 USUARIO CLANDESTINO · 38 ACTIVO/REACT NO FUNCIO · 41 CAJA SIN PRECINTO · 42 ACOMETIDA SIN PROTECCION · 43 ACOMETIDA EN MAL ESTADO · 44 SOSPECHA DE ROBO · 46 MEDIDOR SIN TERMICO · 47 MED.RET.POR DIAS P/REV.-ODECO |
| **2 — LE, estimada** (6) | 1 CASA CERRADA · 4 IMPEDIDAxPERRO SUELTO · 5 IMPEDIDA POR USUARIO · 6 MEDIDOR NO ACCESIBLE · 7 MEDIDOR MAL UBICADO · 11 No. MEDIDOR NO VISIBLE |
| **3 — NE, normal estimada** (8) | 13 USUARIO SIN MEDIDOR · 14 CONEXION DIRECTA · 17 MEDIDOR TRANCADO · 18 MEDIDOR QUEMADO · 19 MEDIDOR ROTO · 21 GIRO AL REVES · 22 GIRO EN VACIO · 39 CODIGO 39 |

> **B5 — resuelta el 6 de octubre de 2026 (DEC-30), por declaración de la tesista.** La nota del bloque 2 de `DATOS.xlsx` dice: **«tipo de lectura 1 no tiene cod irregular, tipo de lectura 2 y 3 tiene codigo irregular»**, y el catálogo asocia **29 códigos reales** (44 SOSPECHA DE ROBO, 37 USUARIO CLANDESTINO, 25 MEDIDOR CON PUENTE BAJO, 41 CAJA SIN PRECINTO…) a `tipo_lectura = 1`. **Resolución de la tesista, textual:** *«Los datos de DATOS.xlsx con lecturas tipo_lectura=1 son lecturas SIN codigo irregular. La lista de codigos irregulares es la lista que manda la AETN.»* **Consecuencia: la regla operativa es la de `DATOS.xlsx`** — «con código» = tipos 2 y 3 = **0,88 %**; «sin código» = tipo 1 = **99,12 %** — y **la columna `tipo_lectura` del catálogo no es la regla con que se etiqueta la lectura, sino la clasificación AETN del código**. **Las cifras siguen siendo las mismas y significan lo que dicen.**
>
> **Salvedad declarada, no zanjada:** esa lectura del catálogo es la explicación más probable, **no una comprobación**. Queda mandada a verificar **con dato** en `sql_a2_extraccion.sql` **0.7.b** —cruce de lecturas contra catálogo—: si toda lectura tipo 1 tiene el código en NULL o 0, la declaración queda confirmada empíricamente; si hay tipo 1 con código distinto de 0, hay que volver a ENDE. **Mientras no corra ese cruce, la cifra se sostiene por declaración de la dueña de los datos, y así consta.**

### Defecto de datos detectado — declarado, no corregido

`historico`, **2025-04**: `total_lecturas` = 28 556, pero `lecturas_iguales` (27 474) + `lecturas_diferentes` (1 080) = 28 554. **Faltan 2 lecturas clasificadas.** Es la **única** fila de las 57 que no cuadra; todas las demás suman exacto.

**No se corrige ni se descarta.** Se declara: afecta al total agregado en **2 unidades de 1 491 360** (0,00013 %), que no mueve ningún porcentaje publicado. *Queda como salvedad para quien reproduzca los números.*

### Pendientes que este archivo no resuelve

| # | Qué falta | Qué bloquea |
|:--|:--|:--|
| ~~**B4**~~ | ~~**El desfase de agosto de 2026:** `DATOS.xlsx` daba **8**, este archivo **5**~~ | **FALSA ALARMA, cerrada el 6 oct 2026 (DEC-25).** Se releyeron las filas crudas en los dos archivos y **son idénticas**: `odecos` 1 (sw=1) + 4 (sw=2) = **5**; `cantidad_tipo_lectura_1` = **4**. **La «8» no estaba en ninguno**: es **agosto de 2025** (1 + 7) |
| **A2.1** | Reclamos a nivel de registro (id, cuenta, fecha, código de irregularidad) | **Verdad de referencia de E8.** El archivo saneado viene agregado |
| **A2.2** | Correcciones a nivel de registro | Etiqueta positiva |
| **A2.3** | Panel de consumo por cuenta y mes | **Sin esto no hay detección.** Ninguna de las tres hojas permite calcular desviación por cuenta |
| — | El **código de irregularidad** sigue sin aparecer en ninguna tabla | Segmentación por familia que exige la Opción 2: hoy solo hay el tipo de lectura, no el código |

### Ampliación de alcance (2 de octubre de 2026)

**Confirmaciones de la tesista, 2 oct 2026:** `tfv_reclamo` **llega hasta 2022** · las correcciones **siempre se registraron, también desde 2022** · **mismo esquema** en todo el periodo · **la extracción es viable**.

La extracción actual cubre 21 meses. Se requiere una segunda extracción **de enero de 2022 a septiembre de 2026 (57 meses)**. → **Recibida el 5 oct 2026 (DEC-24): `DATOS desde 2022.xlsx`, 57 meses, serie saneada.**

#### Especificación — cuatro salidas

| # | Salida | Contenido mínimo | Para qué |
|:--|:--|:--|:--|
| **A2.1** | **Reclamos a nivel de registro** | id, cuenta, fecha, procedencia (`sw_procedente`), tipo de lectura asociada, código de irregularidad asociado | **Verdad de referencia de E8.** La prueba retrospectiva exige comparar, cuenta por cuenta y mes por mes, si el método habría alertado antes del reclamo. Un agregado mensual no sirve |
| **A2.2** | **Correcciones a nivel de registro** | cuenta, fecha de corrección o mes de facturación, lectura original, lectura corregida, quién corrigió si consta | **Etiqueta positiva.** Son lecturas mal tomadas confirmadas. *Vía declarada el 2 oct 2026:* comparar la lectura facturada contra la lectura del **histórico del lecturador** (nombre por confirmar: `tfv_historico_lecturador` o `tfv_histo_lec`). El cambio también está en el log del sistema, pero sin reporte accesible |
| **A2.3** | **Panel de consumo: una fila por cuenta y mes** | cuenta, año-mes, consumo, tipo de lectura, código | **Sin esto no hay detección.** Las tres tablas de `DATOS.xlsx` son agregadas y no permiten calcular desviaciones por cuenta. Volumen estimado ≈ 1,7 millones de filas [estimado: ~29 500 cuentas × 57 meses] |
| **A2.4** | **Agregados mensuales** | los tres ya existentes (reclamos, correcciones, tipos), extendidos a 2022 | Continuidad de los indicadores de este documento |

#### Verificación obligatoria antes de publicar

La extracción ampliada debe **reproducir los números de la extracción corta** en el periodo común (ene 2025 – sep 2026):

1. Reclamos: **314** totales, **62** procedentes.
2. Correcciones: **242,2/mes** en 2026; **1 507/mes** ene–may 2025; **295/mes** jun–dic 2025.
3. Tipos: **532 258** facturables, **5 528** con código (1,04 %).

**Si la extracción ampliada no reproduce esas tres cifras, ninguna de las dos extracciones sirve y hay que parar antes de construir.** Esta es la lección del 30 de septiembre: un número sin reproducibilidad no entra en el documento.

#### Además, antes de construir

- Verificar si la corrección **queda registrada en la base** con cuenta y fecha, o si solo se observa el valor ya corregido. De eso depende si A2.2 es posible.
- Confirmar si el catálogo de códigos de 2022–2024 es el mismo que el vigente, pese a compartir esquema.

## Bloque 0 — Estructura (PRIORIDAD ALTA, primero que todo)

> **SUPERADO el 2 oct 2026.** El esquema real ya está confirmado más arriba, en *Esquema confirmado — Bloque 0 cerrado*. El SQL de este bloque usa el nombre incorrecto `tfv_histo_lec` y los campos supuestos. **Se conserva solo como registro**; las consultas vigentes están en `sql_a2_extraccion.sql`.

Sin esto no puedo escribir consultas exactas.

```sql
-- 0.1 Tablas del esquema público
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- 0.2 Columnas de las dos tablas clave
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name IN ('tfv_histo_lec', 'tfv_reclamo')
ORDER BY table_name, ordinal_position;

-- 0.3 Valores reales de los campos de estado (para no adivinar etiquetas)
SELECT DISTINCT procedencia FROM tfv_reclamo;
SELECT DISTINCT estado      FROM tfv_reclamo;
```

**Qué se busca con esto:** cómo se enlaza un reclamo con la lectura que lo originó (clave común: número de cuenta + ciclo), si `tfv_histo_lec` distingue lectura *registrada* de consumo *facturado*, si existe bandera de tipo *lecturada / estimada*, y qué columna identifica la regional y el grupo tarifario.

---

## Bloque 1 — Evidencia de que el problema existe (E6 · PRIORIDAD ALTA)

### 1.1 Reclamos procedentes cuya lectura NO tenía código de irregularidad

Es el número más importante de la tesis: los casos que el proceso actual dejó pasar.

```sql
SELECT
    DATE_TRUNC('month', r.fecha_reclamo) AS mes,
    COUNT(*)                                     AS procedentes,
    COUNT(*) FILTER (WHERE COALESCE(h.cod_irregularidad,'') = '')
                                                 AS sin_codigo,
    ROUND(100.0 * COUNT(*) FILTER (WHERE COALESCE(h.cod_irregularidad,'') = '')
          / NULLIF(COUNT(*),0), 1)               AS pct_sin_codigo
FROM tfv_reclamo r
JOIN tfv_histo_lec h
      ON h.<cuenta>   = r.<cuenta>
     AND h.<ciclo>    = r.<ciclo>          -- el ciclo reclamado, no el actual
WHERE r.procedencia = 'PROCEDENTE'
  AND r.fecha_reclamo >= '2024-01-01'
GROUP BY 1
ORDER BY 1;
```

**Para qué sirve:** línea base del diagnóstico, criterio 1 de éxito (cobertura retrospectiva) y prueba de que el problema existe. Si `pct_sin_codigo` es bajo, la Opción 2 pierde sentido y hay que reevaluarla antes de construir.

### 1.2 Reclamos por periodo y procedencia

```sql
SELECT DATE_TRUNC('year', fecha_reclamo) AS anio,
       COUNT(*)                                             AS total,
       COUNT(*) FILTER (WHERE procedencia = 'PROCEDENTE')   AS procedentes,
       COUNT(*) FILTER (WHERE procedencia = 'IMPROCEDENTE') AS improcedentes
FROM tfv_reclamo
GROUP BY 1
ORDER BY 1;
```

**Para qué sirve:** confirmar o corregir el estimado de ~50 reclamos y ~40 procedentes por mes; tamaño de la muestra de evaluación.

---

## Bloque 2 — Línea base de los criterios de éxito (E6 · PRIORIDAD ALTA)

### 2.1 Lecturas por ciclo: total, con código y sin código

```sql
SELECT <ciclo>                                       AS ciclo,
       COUNT(*)                                      AS total,
       COUNT(*) FILTER (WHERE COALESCE(cod_irregularidad,'') <> '')
                                                     AS con_codigo,
       COUNT(*) FILTER (WHERE COALESCE(cod_irregularidad,'') = '')
                                                     AS sin_codigo
FROM tfv_histo_lec
GROUP BY 1
ORDER BY 1 DESC
LIMIT 12;
```

**Para qué sirve:** obtener el denominador **mes a mes** para la tasa de alertas y de falsos positivos (criterio 3). *Corregido el 1 oct 2026:* ya no se busca confirmar "~5 000 de 20 000 por ciclo" —`DATOS.xlsx` midió **5 528 de 532 258 (1,04 %)** en 21 meses— y la regional tiene **29 750 cuentas**, no 20 000. La consulta sigue siendo necesaria porque el universo crece y los denominadores deben calcularse por mes.

### 2.2 Distribución de códigos por familia

```sql
SELECT COALESCE(NULLIF(cod_irregularidad,''), '(sin código)') AS codigo,
       COUNT(*)                                               AS lecturas
FROM tfv_histo_lec
GROUP BY 1
ORDER BY 2 DESC;
```

**Para qué sirve:** identificar qué códigos corresponden a **estimación por impedimento de acceso**, que deberán excluirse del modelado de consumo esperado porque no registran consumo real.

### 2.3 Tiempos de respuesta en la ODECO

```sql
SELECT DATE_TRUNC('month', fecha_reclamo) AS mes,
       COUNT(*)                           AS reclamos,
       ROUND(AVG(fecha_respuesta - fecha_reclamo), 1) AS dias_promedio,
       MAX(fecha_respuesta - fecha_reclamo)           AS dias_maximo
FROM tfv_reclamo
GROUP BY 1
ORDER BY 1;
```

**Para qué sirve:** segunda línea base operativa, junto a las 3–4 horas de verificación, y referencia para el plazo reglamentario de 3 a 15 días hábiles.

---

## Bloque 3 — Profundidad del histórico y escala (E6 · PRIORIDAD MEDIA)

```sql
-- 3.1 Antigüedad y número de ciclos disponibles
SELECT MIN(<fecha_lectura>) AS desde,
       MAX(<fecha_lectura>) AS hasta,
       COUNT(DISTINCT <ciclo>) AS ciclos
FROM tfv_histo_lec;

-- 3.2 Cuentas por regional (nombre real de la tabla pendiente)
SELECT <regional>, COUNT(*) AS cuentas
FROM <tabla_cuentas>
GROUP BY 1
ORDER BY 2 DESC;

-- 3.3 Grupos tarifarios o categorías de usuario (segmentación)
SELECT <grupo_tarifario>, COUNT(*) AS cuentas
FROM <tabla_cuentas>
GROUP BY 1
ORDER BY 2 DESC;
```

**Para qué sirve:** 3.1 define cuántos ciclos hay para modelar consumo esperado y cuántos para validar; 3.2 y 3.3 dimensionan la clase de contextos y la segmentación del método.

---

## Bloque 4 — Variables disponibles para la detección (E7b · PRIORIDAD MEDIA)

Del Bloque 0 se derivan las respuestas, no consultas nuevas:

- ¿`tfv_histo_lec` guarda la lectura registrada **y** el consumo facturado en columnas separadas?
- ¿Existe bandera de tipo de lectura (lecturada / estimada / reemplazada)?
- ¿La fecha identifica el ciclo de facturación o solo la fecha física de lectura?
- ¿Está el grupo tarifario o categoría de usuario en la misma tabla o hay que unirlo con la de cuentas?
- ¿Se conserva la imagen de respaldo o el campo de observación del validador en sitio?

---

## Datos descartados por falta de fuente

| Dato | Estado |
|:--|:--|
| Facturas observadas | La tesista declara no disponer. No se persigue. |
| Energía no facturada | La tesista declara no disponer. No se persigue. |
| Horas exactas de verificación por caso | No se registran actualmente; se estima y se declara como estimación. |

Si alguno aparece por otra vía, se incorpora; si no, la línea base se apoya en horas de verificación y en reclamos procedentes, como ya está declarado en `02_delimitacion.md`.
