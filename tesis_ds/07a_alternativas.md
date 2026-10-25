# E7a — Alternativas de solución

> **Borrador abierto el 25 de octubre de 2026.** Etapa pendiente de gate: la **selección** se somete a la tesista antes de darse por cerrada. Número de esta versión: **v1**.
>
> Insumos, todos ya cerrados: `03_perfil_ds.md` (E3), `04_marco_teorico.md` (E4, §3 y §8), `05_estado_del_arte.md` (E5, §5, §7 y §10), `06_diagnostico.md` (E6), `02_delimitacion.md` (criterios 1–4), `DEC-57` (respuesta de ENDE), `DEC-64` y `DEC-65` (sello de fecha de las cifras).

---

## 1. Qué decide esta etapa y qué no

La decide es el **objetivo específico 2** —*determinar los requisitos del método y comparar alternativas de técnica de detección con trade-offs explícitos, eligiendo una y descartando las demás con justificación*— y la tabla de decisiones abiertas de `04_marco_teorico.md` §8:

| Decisión | Etapa | Condición que le impone el marco |
|:--|:--|:--|
| **Técnica de detección** | **E7a** | Comparar alternativas con trade-offs explícitos y ponderar la escasez de etiquetas (§3.2) |
| **Comparación con la capacitación de 2025** | **E7a** | Es la alternativa existente, **no la inacción** |
| Valor numérico del umbral | E7b | Escrito y reproducible (§3.1); el criterio 3 lo limita por volumen (§3.4) |
| Tratamiento de estacionalidad | E7c | Exige ≥ 4 ciclos anuales (§4.2) |
| Valores de los criterios de éxito | E6 y E7b | Se fijan **antes** de construir |

**Lo que esta etapa NO hace:** no fija el umbral numérico —eso es E7b, y el umbral del criterio 2 quedó expresamente en E7b por **DEC-62**—, ni diseña los pasos del método —E7c—, ni calcula volúmenes de alerta sobre el dato —A2.3 sigue sin correr.

**Y una declaración de tipología que le corresponde a esta etapa** (`03_perfil_ds.md` §6): *si en E7a se eligiera una técnica estadística de modelado, el artefacto pasaría a ser una composición (método + modelo).* Se resuelve en la §6.

---

## 2. Los tres filtros que constriñen el espacio de opciones

No son preferencias: son condiciones **medidas** que `05_estado_del_arte.md` §10 exige aplicar a toda alternativa, más una cuarta que entró por respuesta de ENDE.

| # | Filtro | Origen | Qué descarta de entrada |
|:--|:--|:--|:--|
| **F1** | **Dato mensual tabular** — `lec_actual`, `consumo`, `fecha_lec` en `tfv_historico_lecturador`; no hay submedición ni curvas por intervalo | Esquema confirmado 2 oct 2026; E5 §5.1 | Todo lo que exija medidor inteligente de alta frecuencia (AMI): Saeed et al. (2020); Yadav y Kumar (2022); perfilado de carga de Piscitelli et al. (2026) a nivel de medidor |
| **F2** | **Etiquetas escasas y retardadas** — 174 reclamos procedentes en 57 meses, y **son una queja posterior a la facturación, no una detección** | E4 §3.2; E5 §5.2 | Todo lo que exija un corpus amplio de casos etiquetados |
| **F3** | **La priorización bajo capacidad es obligatoria, no opcional** — ≤ 242 alertas/mes ≈ 11/día; cada alerta acatada es un desplazamiento que no se recupera | E4 §3.4, citando a Axelsson (2000); `06_diagnostico.md` | Toda alternativa cuya salida sea un puntaje sin techo |
| **F4** | **La alerta se emite agrupada por ruta** — la revisión es por ruta y se hace en equipo, 1 a 3 técnicos, con **3 a 4 h como tope** y no como promedio | **DEC-57**, respuesta de ENDE del 22 oct 2026 | Toda salida que entregue casos sueltos sin agrupación previa |

A ellos se añaden dos requisitos **ya fijados por el marco teórico**, que toda alternativa debe cumplir y que por tanto tampoco son objeto de elección aquí:

- **Explicabilidad obligatoria** (E4 §3.5): cada alerta va con la comparación concreta que la originó —contra qué ventana, en qué dirección, cuánto se desvió—. *Nwafor et al. (2023); Noorchenarboo y Grolinger (2025).*
- **La segmentación por perfil y familia de código precede a la detección** (E4 §4.1, sobre Piscitelli et al. (2026)), y ya está declarada en la propuesta §7. **Es un paso del método, no una alternativa posible.**

---

## 3. La línea base: qué existe hoy (A0)

`04_marco_teorico.md` §8 obliga a comparar contra la **capacitación de 2025** porque es *la alternativa existente, no la inacción*. Se documenta en tres componentes.

### A0.1 — La regla vigente, sin formalizar

Comparación del consumo del mes contra **los últimos seis meses**, en **ambas direcciones**, aplicada por el encargado de facturación a su juicio.

| Aspecto | Estado |
|:--|:--|
| Umbral numérico | **No existe.** «Mientras no haya umbral escrito, no hay detección: hay juicio» (E4 §3.1) |
| Registro de la decisión | **No existe** — no queda constancia del criterio aplicado |
| Dependencia | **Una sola persona** |
| Ventana | 6 meses — **no incluye el mismo mes del año anterior** (E4 §4.2) |
| Residual | **242,2 correcciones/mes** sin reporte accesible |

### A0.2 — La capacitación de mayo–junio de 2025

**Es la mejor alternativa que el problema tiene hoy y ya está demostrada.** Su efecto medido sobre `lecturas_diferentes`:

| Periodo | Correcciones/mes |
|:--|--:|
| ene–may 2025 (antes) | **1 507,4** |
| jun–dic 2025 (después) | **295,3** → **−80 %** |
| 2026 (septiembre, acumulado) | **242,2** |

**Lo que esto impone a cualquier alternativa:** la barra no es la inacción, es **una intervención que ya redujo el volumen un 80 %**. Una alternativa que no mejore sobre 242,2 no justifica su costo de adopción.

### A0.3 — La detección reactiva por ODECO

Sobre las lecturas **con** código (0,88 % del facturable), la tasa de procedencia es **31,3 veces** la de las lecturas sin código; pero **de los 174 reclamos procedentes, 136 —78,16 %— vinieron de lecturas SIN código**, es decir de las que ningún proceso barre. La ODECO es el único detector que encontró esos 136, y lo hizo **después de facturar**.

**Por eso el método debe barrer el histórico completo y no solo las lecturas marcadas** — decisión de la tesista del 26 sep 2026.

---

## 4. Alternativas candidatas

Se presentan cuatro, todas ellas **no supervisadas salvo la A4**, y todas ellas compatibles con F1. Se comparan en la §5.

### A1 — Ventana móvil de 6 meses con umbral escrito

Formalizar la regla vigente: alertar cuando `consumo` se desvíe de la **media de los seis meses anteriores**, en ambas direcciones, con un umbral `θ` escrito.

- **A favor:** continuidad con lo que el equipo ya conoce; explicación inmediata (*«500 kWh contra los 480 de sus últimos seis meses»*); costo de implementación mínimo; no necesita etiquetas; el umbral se calibra directamente contra el techo de 242.
- **En contra:** la ventana **no incluye el mismo mes del año anterior** —consecuencia lógica de su definición, no afirmación bibliográfica (E4 §4.2)—, de modo que un ciclo anual completo queda fuera de la comparación; y al comparar cada cuenta solo consigo misma, una cuenta con histórico corto se compara contra poco.

### A2 — Ciclo anual por cuenta: el mismo mes de los años anteriores

Para cada cuenta y cada mes del año, comparar el consumo registrado **contra los mismos meses de los años previos** del histórico, con umbral `θ` sobre la desviación estandarizada.

- **A favor:** resuelve la estacionalidad **con dato propio** —`tfv_historico_lecturador` llega a enero de 2022: **57 meses y cuatro ciclos anuales completos**—, sin modelo externo ni fuente adicional; sigue siendo no supervisada, por lo que F2 no la toca; la explicación se escribe en las mismas palabras del gremio (*«su julio frente a sus julios de 2023, 2024, 2025 y 2026»*); y desvía la comparación de una ventana móvil —cuya composición cambia cada mes— a un patrón fijo.
- **En contra:** exige **≥ 4 ciclos**, que es justo lo que el histórico tiene, de modo que **no admite perder meses**: cualquier hueco en la serie empeora la referencia; para cuentas con menos de cuatro años de historial hace falta una regla de contingencia; y el umbral sigue sin estar, que es E7b.

### A3 — Normalidad definida por el segmento de perfil

Comparar la lectura **no contra su propia historia, sino contra el patrón de consumo del segmento** al que pertenece la cuenta —perfil de consumo × familia de código—.

- **A favor:** respeta que el perfil precede a la detección (E4 §4.1, sobre Piscitelli et al. (2026)); compara contra pares semejantes, lo que da referencia a cuentas con histórico corto; y detecta anomalías **colectivas**, que la A2 por sí sola no ve.
- **En contra:** es **menos explicable a nivel de caso** — al verificador hay que explicarle por qué ese segmento, y esa comparación no es la que él haría espontáneamente—; exige definir los segmentos, lo que introduce una decisión previa no consensuada; y **no sustituye a la comparación individual**: una cuenta puede estar normal para su segmento y anómala para su propio ciclo, que es exactamente el caso que la ODECO sí captó.

### A4 — Clasificador supervisado sobre los reclamos procedentes

Entrenar un clasificador tomando como positivos los reclamos procedentes —174 en 57 meses— y como negativos el resto.

- **A favor:** es el patrón dominante de la literatura (Saeed et al., 2020; Yadav y Kumar, 2022); aprovecharía la única etiqueta disponible.
- **En contra:** **F2 la mata.** E4 §3.2 lo establece como condición del marco: *«cualquier alternativa que exija un corpus amplio de casos etiquetados parte con una desventaja documentada»*. Además la etiqueta **no es una detección, es una queja** (E5 §5.2): marca lo que ya fracasó, no lo que el método debió encontrar; y ante desequilibrio de esa magnitud la exactitud sería engañosa (Saito y Rehmsmeier, 2015), mientras que lo que hay que optimizar —la exhaustividad contra la capacidad— no es lo que un clasificador maximiza.

---

## 5. Matriz de comparación

**✓** cumple · **△** cumple con salvedad · **✗** no cumple.

| | **A1**<br>ventana 6 m | **A2**<br>ciclo anual | **A3**<br>segmento | **A4**<br>supervisado |
|:--|:--:|:--:|:--:|:--:|
| **F1** — dato mensual tabular | ✓ | ✓ | ✓ | ✓ |
| **F2** — no exige corpus etiquetado | ✓ | ✓ | ✓ | **✗** |
| **F3** — salida con techo de capacidad | ✓ | ✓ | △ | △ |
| **F4** — salida agrupable por ruta | ✓ | ✓ | ✓ | ✓ |
| **Explicabilidad obligatoria** (E4 §3.5) | **✓** | **✓** | △ | **✗** |
| **Estacionalidad anual** (E4 §4.2) | **✗** | **✓** | ✓ | △ |
| **Contra la capacitación de 2025** (E4 §8) | △ mejora poco | **✓** | ✓ | ✗ riesgo alto |
| **Costo de construcción** | mínimo | bajo-medio | medio | alto |
| **Riesgo en calendario exigido** | nulo | bajo | medio | **alto** |

**Dos lecturas de la matriz:**

1. **A4 es la única que cae en F2 y en explicabilidad** —los dos filtros que el marco teórico declaró condicionantes—, y es además la de mayor riesgo en un calendario fijo con tres días de rediseño no negociables.
2. **A1 es la única que cae en estacionalidad**, que es la debilidad que ya estaba diagnosticada **antes** de esta etapa (E4 §4.2). Formalizarla tal cual sería entregar el mismo defecto con umbral escrito.

---

## 6. Selección

> **[POR CONFIRMAR — gate de E7a]**

**Alternativa elegida: A2 — ciclo anual por cuenta.**

**Justificación en cuatro puntos, cada uno trazado:**

1. **Es la única que cumple los cuatro filtros sin salvedad ni cae en ninguna dimensión ya diagnosticada como debilidad.** F1, F2, F3 y F4 se cumplen; estacionalidad —la crítica abierta en E4 §4.2— se resuelve; explicabilidad se mantiene íntegra.
2. **Resuelve la estacionalidad con dato propio y sin fuente externa.** Los 57 meses y cuatro ciclos completos no son un supuesto: son el histórico confirmado de la tesista (2 oct 2026) y verificado por A2.4 con las tres cifras de `DATOS desde 2022.xlsx`. **La A2 es la única alternativa que convierte esa amplitud en ventaja.**
3. **Supera a la barra real, que es la capacitación de 2025.** A0.2 ya dejó 242,2 correcciones/mes como piso de desempeño; la A2 ataca el residuo que la capacitación **no** alcanzó —los 136 reclamos procedentes de lecturas sin código—, mientras que la A1 repetiría sobre el mismo terreno lo que ya se intentó.
4. **Mantiene el artefacto como método.** Al no elegir un modelo entrenado, **la tipología no cambia: sigue siendo `método`**, y la instanciación de apoyo sigue siendo *exemplar* (`03_perfil_ds.md` §6). **No hay composición, y así se declara.**

**Descartadas, con razón:**

| Alternativa | Moto del descarte | Qué pasa con ella |
|:--|:--|:--|
| **A4** — supervisado | **F2**: exige corpus etiquetado y solo hay 174 etiquetas, retardadas y no son de detección (E4 §3.2; E5 §5.2) | **Descartada.** No se ensaya |
| **A3** — segmento | No es competidora: **la segmentación ya es un paso obligatorio previo** (E4 §4.1; propuesta §7). Como criterio *principal* perdería explicabilidad a nivel de caso | **Reclasificada como paso del método**, no como alternativa. Su aporte —comparar contra pares— queda como **variable a probar en E7c** |
| **A1** — ventana 6 meses | **Falla estacionalidad**: la ventana no incluye el mismo mes del año anterior (E4 §4.2) | **Descartada como criterio principal.** **Se conserva como regla de contingencia** para cuentas con menos de cuatro ciclos de historial — caso que existe y que la A2 no cubre. Se declara, no se oculta |

**Declaración sobre A1:** conservarla no es una ambigüedad. Es la respuesta a un caso límite real y su existencia escrita evita que la A2 se quede sin cobertura para las cuentas nuevas. **El criterio principal es A2; A1 opera solo cuando no hay cuatro ciclos.**

---

## 7. Consecuencias para las etapas siguientes

| Etapa | Qué le entrega esta decisión |
|:--|:--|
| **E7b** — requisitos | El **umbral `θ`** de la A2, su valor numérico y su forma de cálculo —escrito y reproducible, limitado por volumen según el criterio 3—; el umbral del criterio 2; el formato de la explicación obligatoria; el registro de resolución; y la agrupación por ruta de **DEC-57** |
| **E7c** — diseño | Cómo se calcula la referencia anual con los 57 meses; qué hacer con los huecos de serie; cómo se prueban los segmentos; el tratamiento de la regla de contingencia A1 |
| **E8** — evaluación | Las métricas ya son **precisión-exhaustividad** y no exactitud (E4 §3.3); la A2 se evalúa contra su **cobertura de los 174** y contra su **volumen de alertas frente a 242** |
| **A2.3** — panel de consumo | **Sigue siendo requisito previo**: la A2 se calcula sobre `tfv_historico_lecturador` por cuenta y mes. **Sin el panel no hay A2.** |

---

## Gate de E7a — cerrado

**Decisión de la tesista, 25 de octubre de 2026 (DEC-70):**

1. **A2 —ciclo anual por cuenta— es el criterio principal de detección.** Queda con **A1** —ventana de 6 meses— como regla de **contingencia declarada** para cuentas con menos de cuatro ciclos anuales completos, y con **A3** —normalidad por segmento— reclasificada como **paso previo obligatorio del método** y no como alternativa competidora. *Respuesta (a).*
2. **La tipología se mantiene en `método`**, con instanciación de apoyo *exemplar*. *Respuesta (a).* Es consecuencia directa de no haber elegido A4.

**Efecto en las demás etapas.** Al confirmarse A2 **no se reabren `R1.2`, `R3.1`, `R6.3`, `R8` ni `R9`**, que era la condición que fijaba la cabecera de `07b_requisitos.md`. **El punto 1 del gate de E7b queda cumplido.**

**Lo que este gate NO resuelve.** **(a)** Que **A3 se pruebe en E7c**: aquí solo se clasificó su papel en el método, no se midió su efecto. **(b)** Que **A2 tenga con qué calcularse**: la elección está cerrada, el dato todavía no — **`A2.3.a` sigue sin correr.** Una alternativa elegida sin panel es una elección, no una medición.
