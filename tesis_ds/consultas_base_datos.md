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

### Dos huecos que el esquema revela

| # | Falta | Qué deja sin poder hacer |
|:--|:--|:--|
| **B1** | **La tabla del tipo de lectura (0/1/2/3) y del código de irregularidad.** Ninguna de las tres trae esos campos | **Reproducir el indicador 1 de E6** (46 de 62 = 74,19 %) y la segmentación por familia de código que exige la Opción 2. Sin ella, la evidencia central de la propuesta no se puede regenerar |
| **B2** | **La tabla de la lectura facturada**, para compararla contra `tfv_historico_lecturador.lec_actual` | Derivar las ~242,2 correcciones mensuales: el criterio de carga queda sin línea base reproducible |
| **B3** | Confirmar que `sw_proceso` es el mismo campo que en `DATOS.xlsx` apareció como `sw_procedente` (1 / 2 / 4) | El 62 de procedentes y el 74,19 % dependen de esa equivalencia |

**Consultas escritas:** `sql_a2_extraccion.sql`. El Bloque 0 de ese archivo se ejecuta primero; si la prueba de reproducibilidad (314 y 62) no cuadra, no se continúa.

### Ampliación de alcance (2 de octubre de 2026)

**Confirmaciones de la tesista, 2 oct 2026:** `tfv_reclamo` **llega hasta 2022** · las correcciones **siempre se registraron, también desde 2022** · **mismo esquema** en todo el periodo · **la extracción es viable**.

La extracción actual cubre 21 meses. Se requiere una segunda extracción **de enero de 2022 a septiembre de 2026 (57 meses)**.

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
