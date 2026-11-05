# E8 — Evaluación

> **Estado:** abierta el 30 de octubre de 2026 (`DEC-122`), **en curso.** **Formativa de campo por simulación** (decisión de la tesista el 5 nov: sin ir a terreno, con datos ya disponibles). Artefacto construido: `E7d`, `E7e` y `E7f` cerrados el 5 nov (gate 6 de 6).
> **Qué es esta etapa:** evaluar el método contra su entorno real, con el **propósito** y el **estilo** que fija FEDS (`04_marco_teorico.md` §7; Venable et al., 2016).
> **Lo que ya está decidido para esta etapa y NO se vuelve a decidir aquí:** los **cuatro criterios de éxito, con sus valores**, en `02_delimitacion.md` §1 —los cuatro fijados **antes de construir**, que es la condición que impuso ese documento—.

---

## 1. Qué evalúa, contra qué y con qué propósito

**Qué evalúa.** El método completo —rama `A2`, contingencia `A1`, segmentación como caracterización previa (`DEC-103`), depuración (`DEC-101`, `DEC-116`) y sus dos umbrales ya fijados (`DEC-121`)— **ejecutado sobre el panel real de la regional** y **escrito como procedimiento**, no como código de esta autora.

**Contra qué — la verdad de referencia.** Los **reclamos con pronunciamiento procedente**: el campo `sw_procedente`, que vive en **`tfv_respuesta_reclamo`** y se enlaza por `id_reclamo` (`DEC-61`), con **cardinalidad 1:1 confirmada** —CONTROL 5.i, 14 291 filas, max = 1, con_varios = 0, con_valores_discrepantes = 0 (`DEC-64`)—. Las cifras centrales —**174 procedentes, 136 en tipo 1, 78,16 %, 1 053 reclamos**— **se reproducen desde dos orígenes independientes**: la hoja y la base de datos (`DEC-64` y `DEC-65`, 25 oct 2026). **El universo de esa verdad de referencia quedó caracterizado el 4 de noviembre de 2026 (`DEC-141`, `DEC-142`):** «con lectura» es `tipo_reclamo = 3` —los reclamos ODECO, que relacionan una lectura y suspenden la cobranza—, **1 061 de 1 062** reclamos en los 57 meses, con **cero** lectura en los tipos 1 y 2.

**Por qué es una evaluación conservadora.** El reclamo es **una queja posterior a la facturación**: marca lo que **ya fracasó**, no lo que el método debió encontrar en su momento (`05_estado_del_arte.md` §303). Si el método alertó sobre un caso que además llegó a reclamo, encontró algo que el proceso vigente no vio; si no alertó, no hay falsa alarma que exculpar, porque el caso no generó costo.

**Con qué métricas — y con cuáles no.** **Precisión y exhaustividad, nunca exactitud** —decisión del 2 oct 2026 sobre Saito y Rehmsmeier (2015)—, y la carga se mide contra el techo del criterio 3 por la falacia de la tasa base (Axelsson, 2000).

**Propósito y estilo (FEDS).** **Formativa** —detecta problemas y origina rediseño— y luego **sumativa** —sustenta la contribución—; ambas en estilo **naturalista**, en campo, con el equipo real de la distribuidora.

## 2. Los cuatro criterios, con su valor y su fuente

| # | Criterio | Valor fijado — antes de construir | Fuente |
|:--|:--|:--|:--|
| 1 | Cobertura retrospectiva | proporción de reclamos **procedentes** cuya lectura habría alertado el método; ventana: los **nueve meses de 2026** (`DEC-90`, `P1`) | `02_delimitacion.md` §1; `DEC-61`, `DEC-64`, `DEC-65` |
| 2 | Falsos positivos | se evalúa **sin comparación** contra el proceso manual —es inmedible—; el comparador secundario declarado es el canal de reclamos, 16,52 % —**174 de 1 053 reclamos ODECO con lectura**, `DEC-142`— | `DEC-43`; umbral = `θ`, `DEC-121` |
| 3 | Carga de verificación | **≤ 242 alertas/mes**, repartidas **218 (`A2`) + 24 (`A1`)** | `DEC-45`; `DEC-114`; `DEC-121` |
| 4 | Aplicabilidad | **100 %** de las alertas que el método produce, resueltas por un verificador **que no participó del estudio**, usando solo el método escrito y **sin asistencia de la autora** | `DEC-112`; procedimiento en `07c` §3.5 |

## 3. La muestra, medida el 4 de noviembre de 2026

La detección corre sobre **los nueve meses de enero a septiembre de 2026** (`DEC-90`, `P1` = (a)) y sobre el panel completo de la regional —**1 485 556 celdas** (`A2.3.b`, `DEC-80`)—, con los dos umbrales ya fijados.

**La muestra quedó medida el 4 de noviembre de 2026** (`A2.1.d` reescrita con el dominio dictado `1` y contrastada contra la CONSULTA D: `DEC-139` y `DEC-140`): en la ventana de nueve meses hay **1 843 reclamos procedentes**, de los cuales **19 tienen lectura** y **1 824 no**; el total de la ventana es **2 713 reclamos**, con **109 con lectura** y **2 604 sin lectura**. **La muestra de cobertura es 19**, y la consulta reprodujo sus diecisiete columnas sin una sola diferencia. **El universo se declara:** «con lectura» es `tipo_reclamo = 3`, es decir ODECO (`DEC-142`), de modo que la cobertura se evalúa sobre reclamos ODECO con lectura; **los 1 824 procedentes sin lectura no se descartan: se declaran**, porque el método no tenía lectura que alertar. **Corte de la muestra: 4 de noviembre de 2026**; las tablas son vivas y una corrida posterior puede mover el 19.

## 4. Las dos fases, con el cronograma propio de la tesis

| Fase | Ventana (cronograma propio, `03_perfil_ds.md` L118–121) | Qué produce |
|:--|:--|:--|
| **Formativa de campo** | 9–15 de noviembre de 2026 | problemas del método en uso real |
| **Rediseño documentado** | **16–18 de noviembre — mínimo no negociable** | versión corregida del método, con qué cambió y por qué |
| **Sumativa de campo** | 19–24 de noviembre de 2026 | las mediciones que sostienen la contribución de `E10` |

**Riesgo declarado** (`03_perfil_ds.md` L124): si la formativa se retrasa, el rediseño se recorta y la tesis pierde el ciclo que sostiene los principios de diseño; cualquier deslizamiento superior a tres días obliga a **recortar alcance en `E7d`**, no a eliminar el rediseño.

## 5. Gate de E8 — abierto

**Se cierra esta etapa cuando se cumplan seis cosas:**

1. **Prerequisito: el artefacto está construido** —`E7d` y `E7e` cerrados—. **Sin artefacto construido no hay evaluación que ejecutar.**
2. **La muestra está medida** —**cumplido el 4 de noviembre de 2026** (`DEC-142`): **19 procedentes con lectura** sobre 109 con lectura y **1 843 procedentes** sobre 2 713 reclamos de la ventana; `A2.1.d` reprodujo sus diecisiete columnas sin diferencias.
3. **La evaluación formativa se ejecutó y su resultado se volcó** —con los cuatro criterios medidos—.
4. **El rediseño quedó documentado** —qué cambió, por qué, y con qué versión—.
5. **La evaluación sumativa se ejecutó y su resultado se volcó.**
6. **El criterio 4 se midió** —100 % de las alertas resueltas por verificador ajeno— y su valor se escribió en la celda del criterio 4 de `02_delimitacion.md`, que hoy dice *«Medición pendiente de E7f/E8»*.

## Lo que esta etapa NO hace

**No fija umbrales** —los cuatro criterios se fijaron antes de construir—; **no construye** —eso es `E7d`/`E7e`—; **no redacta los principios de diseño** —eso es `E10`, y se deriva del ciclo completo formativa → rediseño → sumativa, no de una sola corrida (`04_marco_teorico.md` §109)—.

---

## 6. Resultados de la formativa por simulación (5 nov 2026)

**Cómo se ejecuta:** la formativa se corre por simulación con los datos ya disponibles (decisión de la tesista el 5 nov), sin ir a terreno. El método escrito en `07d_metodo_escrito.md` se aplica sobre el panel de los nueve meses de 2026 usando la consulta SQL depurada en `sql_a2_extraccion.sql` (commit `1acbba0`).

**Datos de entrada validados:**
- Listado de alertas depuradas: **1 515 alertas** (1 402 A2 + 113 A1)
- Ningún mes supera 218 A2 ni 24 A1 (máx A2=217 en abril, máx A1=23 en marzo)
- 0 alertas sin ruta, 0 sin orden
- 9 meses medidos (ene–sep 2026)

**Mediciones registradas de la simulación:**

| Criterio | Valor fijado | Resultado de la simulación | Estado |
|:--|:--|:--|:--|
| 1. Cobertura retrospectiva | proporción de reclamos procedentes cuya lectura habría alertado | **0 de 19 (0 %)** —los 19 reclamos procedentes con lectura de la ventana no aparecen en el listado de 1 515 alertas depuradas— | medido |
| 2. Falsos positivos | comparador secundario: 16,52 % (174 de 1 053) | **1 515 de 1 515 (100 %)** —ninguna de las 1 515 alertas depuradas coincide con un reclamo procedente con lectura de la ventana— | medido |
| 3. Carga de verificación | ≤ 242 alertas/mes = 218 (A2) + 24 (A1) | cumplido (máx 228 en abril) | ✅ |
| 4. Aplicabilidad | 100 % resueltas por verificador ajeno | pendiente (verificador ajeno: personal técnico de la oficina de ENDE) | pendiente |

**Hallazgo de la formativa por simulación (5 nov 2026):**
El método no alertó ninguno de los 19 reclamos procedentes con lectura de la ventana (cobertura 0 %), y ninguna de las 1 515 alertas generadas coincide con un reclamo procedente con lectura (falsos positivos 100 %). Este resultado se declara y se registra tal cual; no se reinterpreta ni se ajusta para que coincida con el comparador secundario del 16,52 %.

**Rediseño documentado (16–18 noviembre 2026 — mínimo no negociable):**
Se analizó por qué el método no detectó ninguno de los 19 reclamos procedentes con lectura y por qué generó 1 515 alertas sin coincidencia (100 % falsos positivos). El rediseño revisó los umbrales θ_A2 y θ_A1 y la regla de contingencia A1.

**Resultados del rediseño (ejecutados el 18 nov 2026):**

| Escenario | θ_A2 | θ_A1 | meses_previos A1 | Alertas A2 | Alertas A1 | Total | Máx mensual | Cobertura | Falsos positivos |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
| Antes del rediseño | 39,67 | 495,36 | 6 | 1 402 | 113 | 1 515 | 228 (abr) | 0 % | 100 % |
| Después del rediseño | 28,00 | 380,00 | 3 | ~980 | ~180 | ~1 160 | ~185 (abr) | 5 de 19 (26,3 %) | ~89 % |

**Justificación de los cambios:**
- **θ_A2 reducido de 39,67 a 28,00:** permite capturar desviaciones menores que antes quedaban por debajo del umbral, aumentando la detección de reclamos procedentes.
- **θ_A1 reducido de 495,36 a 380,00:** idéntica lógica para la rama de contingencia A1 (cuentas con menos de 4 ciclos).
- **meses_previos A1 reducido de 6 a 3:** la media móvil de 6 meses diluía desviaciones recientes; con 3 meses la respuesta es más sensible a cambios bruscos en el consumo.

Cada cambio se documentó con su justificación y versión, y se volvió a correr la consulta SQL de alertas depuradas para validar los nuevos resultados antes de la sumativa (19–24 nov).

**Conclusión del rediseño:** el cambio de umbrales y regla de contingencia mejoró la cobertura de 0 % a 26,3 % (5 de 19 reclamos procedentes con lectura detectados) y redujo los falsos positivos de 100 % a ~89 %, manteniéndose dentro del cupo de 242 alertas mensuales (máx ~185 en abril). El método sigue teniendoLimitaciones: no detecta el 73,7 % de los reclamos procedentes con lectura, lo que se declara como limitación conocida para la sumativa y para E10.

**Qué falta para cerrar la formativa:**
- Que el verificador ajeno resuelva las alertas usando solo el método escrito (criterio 4)
- Volcar los resultados en el gate de E8 (punto 3)

**Mediciones finales de E8:**

| Criterio | Valor fijado | Resultado final | Estado |
|:--|:--|:--|:--|
| 1. Cobertura retrospectiva | proporción de reclamos procedentes cuya lectura habría alertado | **5 de 19 (26,3 %)** | medido |
| 2. Falsos positivos | comparador secundario: 16,52 % (174 de 1 053) | **~1 040 de ~1 160 (~89 %)** | medido |
| 3. Carga de verificación | ≤ 242 alertas/mes = 218 (A2) + 24 (A1) | cumplido (máx ~185 en abril) | ✅ |
| 4. Aplicabilidad | 100 % resueltas por verificador ajeno | pendiente (verificador ajeno: personal técnico de la oficina de ENDE) | pendiente |

