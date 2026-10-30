# Nota para la predefensa — sábado 31 de octubre de 2026

**Tema de esta nota:** los umbrales de detección del método y la carga de alertas que emite. Existe para contestar de un vistazo la pregunta más probable del panel: *¿cuántas alertas emitiría su método, y quién las revisa?* **Todos los números salieron de consultas corridas el 30 de octubre de 2026** (`sql_a2_extraccion.sql`), y los dos umbrales están volcados en el criterio 2 de `02_delimitacion.md` (`DEC-121`).

## 1. Los dos umbrales

El método tiene dos ramas, porque no todas las cuentas tienen el mismo historial:

| Rama | A qué cuentas aplica | Umbral `θ` — desviación mínima que alerta |
|:--|:--|--:|
| **`A2`** — criterio principal | cuentas con los **cuatro ciclos anuales previos**: enero–septiembre de 2026 comparados contra la **mediana** de ese mismo mes en 2022–2025 | **39,6666666666667** |
| **`A1`** — contingencia | cuentas de **historial corto** —sin cuatro ciclos—, comparadas contra la **media** de los meses previos que existan, hasta seis | **495,362260343088** |

**Los dos umbrales son el MÁXIMO de los nueve cortes mensuales, no el mínimo.** La regla —tomar el máximo, el más estricto— estaba **escrita antes de medir**, en los pasos 5 y 8 de `07b_requisitos.md` §4.2; no se eligió después de ver los números. Se tomó el máximo porque el mínimo habría alertado más y podía superar el techo de 242 alertas por mes en algún mes (`R2.1`).

## 2. Carga mensual medida — rama `A2` (enero–septiembre de 2026)

| Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Total |
|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 119 | 125 | 144 | **218** | 152 | 159 | 180 | 156 | 153 | **1 406** |

## 3. Carga mensual medida — rama `A1` (enero–septiembre de 2026)

| Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Total |
|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| 12 | 10 | **24** | 11 | 8 | 9 | 15 | 7 | 18 | **114** |

**El techo de 242 alertas por mes —`R2.1`, fijado el 19 oct con `DEC-45`— se reparte como 218 para `A2` más 24 para `A1` (`DEC-114`): los dos cupos están reservados de forma fija**, y ningún mes de ninguna rama lo excede.

## 4. Verificación — antes de creer los dos cuadros

Cada umbral se verificó con **seis autocalculeos escritos antes de correrlos**; cerraron los doce, seis en `A2.3.l` y seis en `A2.3.m`. Los dos que más podían fallar:

- **`meses_con_cobertura` = 9 en las dos ramas:** ningún mes quedó sin cobertura —ni siquiera junio de `A1`, cuyo corte propio era 39,57 y cuyo umbral global es 495,36—. El requisito `R8.1` aguanta.
- **`meses_que_superan_el_techo` = 0 en las dos ramas:** `R2.1` aguanta, **verificado y no solo razonado**.

## 5. La carga del método COMPLETO — medida el 30 de octubre de 2026

**La consulta `A2.3.n` cerró el pendiente de la versión anterior de esta nota:** hasta hoy la carga total existía solo como aritmética de dos corridas separadas, y una cifra sin su propia consulta no se publica (`DEC-13`). Ahora sí está medida.

| Rama | Ene | Feb | Mar | Abr | May | Jun | Jul | Ago | Sep | Total |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| `A2` | 119 | 125 | 144 | **218** | 152 | 159 | 180 | 156 | 153 | **1 406** |
| `A1` | 12 | 10 | **24** | 11 | 8 | 9 | 15 | 7 | 18 | **114** |
| **Combinadas** | 131 | 135 | 168 | **229** | 160 | 168 | 195 | 163 | 171 | **1 520** |

**Ningún mes supera el techo de 242 (`R2.1`): el más cargado es abril, con 229, y le quedan 13 de margen.** Esto es lo que antes solo se sostenía por aritmética —218 + 24 = 242 por `DEC-114`— y ahora está **medido para el método completo**: `meses_que_superan_el_techo` = **0**.

**Los seis autocalculeos escritos antes de correrla cerraron los seis:** `total_alertas_a2` = **1 406** · `total_alertas_a1` = **114** · `total_alertas_combinadas` = **1 520** · `maximo_alertas_en_un_mes` = **229** en abril · `meses_que_superan_el_techo` = **0** · `meses_medidos` = **9**.

**Y dos comprobaciones que no se pidieron y cerraron contra corridas anteriores:** la suma de las celdas de `A2` a lo largo de los nueve meses da **183 000**, la misma cifra del universo calculable de `A2.3.g` (`DEC-101`); y la suma de las celdas de `A1` da **70 039**, la misma de `a1_celdas_calculables` en `A2.3.m` (`DEC-120`). Además, **las nueve filas cumplen `A2` + `A1` = combinadas**.

## Fuente

`tesis_ds/sql_a2_extraccion.sql` — `A2.3.l` L3080, L3155, L3583, L3661; `A2.3.m` L3333, L3430, L3802, L3904; `A2.3.n` L4009, L4087, L4236. Corridas del 30 de octubre de 2026. Umbrales volcados al criterio 2 de `02_delimitacion.md` (`DEC-121`); reparto de los cupos en `DEC-114`; techo del criterio 3 en `DEC-45`; regla del máximo en `07b_requisitos.md` §4.2.
