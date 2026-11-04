# E8 — Evaluación

> **Estado:** abierta el 30 de octubre de 2026 (`DEC-122`), **en su diseño.** **No puede cerrarse hoy:** esta etapa evalúa al artefacto **construido**, y el artefacto está **diseñado** —`07c` cerró su gate 6 de 6 el 29 oct (`DEC-112`)— pero **no construido**: `E7d` y `E7e` siguen sin abrir.
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
