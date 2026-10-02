# E5. Estado del arte

| | |
|:--|:--|
| **Estado** | **cerrada el 2 de octubre de 2026** |
| **Entrega** | 4 de octubre de 2026, con E4 |
| **Pregunta guía** | ¿Por qué las soluciones existentes son insuficientes para este problema y qué aporta esta propuesta que ellas no aportan? |
| **Regla de verificación** | Ninguna referencia entra sin autoría, título, publicación, volumen, número, páginas y DOI comprobados. Lo no comprobado queda `[por verificar]`. Registro en la sección 10. |
| **Advertencia de alcance** | Esta es una **búsqueda preliminar, no una revisión sistemática** (ver §2). Las afirmaciones de brecha son **provisionales** hasta completar el protocolo. |
| **Decisiones del asesor, 2 oct 2026** | (1) Se **amplía a IEEE Xplore y SciELO/LILACS el 3–4 de oct** (DEC-1/DEC-7), con cuenta de registros identificados, eliminados e incluidos. (2) IEEE Xplore **sobre metadatos y resúmenes**, sin acceso institucional (DEC-6). (3) Los **artefactos comerciales y de código abierto** se **difieren a después de la defensa de propuesta** (DEC-2). (4) **Scopus y Web of Science fuera de alcance** (DEC-8, confirmado). |
| **Archivo que alimenta** | `propuesta_borrador_v1.md`, secciones 9 y 12 |

---

## 1. Pregunta y estructura de la respuesta

La pregunta guía exige tres respuestas, en este orden:

1. **Qué existe** — qué ha resuelto ya el campo (secciones 4 a 6).
2. **Por qué no basta** — en qué dimensiones concretas lo existente no cubre este problema (sección 7).
3. **Qué se agrega** — el aporte propio, formulado sin sobreextenderlo (sección 8).

Se responde en cuatro ejes: **A**, pérdidas no técnicas como fenómeno; **B**, detección de anomalías en consumo; **C**, del algoritmo a la visita; **D**, explicabilidad.

---

## 2. Protocolo de búsqueda — versión 1

### 2.1 Lo que se hizo

| Elemento | Descripción |
|:--|:--|
| **Fecha** | 2 de octubre de 2026 |
| **Base consultada** | Crossref (API pública, `api.crossref.org`) |
| **Ampliación decidida** | **Antes de la propuesta completa (3–4 oct, DEC-1/DEC-7):** IEEE Xplore + SciELO + LILACS. Scopus y Web of Science **fuera de alcance** (DEC-8, confirmado) |
| **Limitación de acceso a IEEE Xplore** | **No hay acceso institucional (DEC-6):** se consultará sobre **metadatos y resúmenes públicos**, no sobre texto completo. **Se declara porque condiciona qué se pudo leer de cada registro**: para los trabajos accesibles solo se extraerá lo que el registro público exhibe. Si un registro no permite evaluar los criterios de inclusión, se excluye **y se cuenta como excluido**, no se da por incluido |
| **Tipo de consulta** | (a) búsqueda bibliográfica por cadena de términos con orden por relevancia; (b) resolución directa por DOI |
| **Filtros aplicados** | Artículos de revista; desde 2015 salvo para los trabajos canónicos de referencia; sin filtro de idioma |
| **Cadenas usadas** | `non-technical losses detection electricity distribution review` · `electricity theft detection smart meter machine learning unsupervised` · `smart meter data anomaly detection review energy consumption` · `regulation incentives non-technical losses distribution utility tariff auditing` · `electricity distribution consumer complaints ombudsman regulation service quality` |
| **Criterio de inclusión** | Que trate detección de anomalías o pérdidas no técnicas en distribución eléctrica, **o** los aspectos metodológicos de detección (métrica, desequilibrio, explicabilidad, priorización de inspección), con revisión por pares |
| **Criterio de exclusión** | Publicaciones de editoriales sin revisión por pares; actas de congresos de divulgación; metadatos incompletos; resultados sin relación con el problema |
| **Criterio de calidad** | Revisión sistemática, artículo de revista de difusión indexada, o trabajo de una comunidad técnica reconocida (IEEE/ACM) |
| **Extracción** | Autoría, año, título, publicación, volumen, número, páginas, DOI |
| **Total incorporado** | **15 trabajos**: 6 del eléctrico como fenómeno (eje A) y 9 de detección e inspección (ejes B y C). Más los 7 de Design Science de `04_marco_teorico.md` → **22 entradas en total**. *Materiales internos `referencias/ds_ch*.md`: no se citan (DEC-4)* |

### 2.2 Lo que NO se hizo todavía

Está declarado porque **condiciona la fuerza de las afirmaciones de este documento**:

- **No se consultaron** IEEE Xplore, Scopus, Web of Science, SciELO ni LILACS. La ausencia de resultados en Sudamérica y en contextos regulados andinos es, por tanto, **un vacío de búsqueda, no una constatación**. **Decisión del asesor, 2 oct 2026:** se amplía a **IEEE Xplore y a SciELO/LILACS** el 3–4 de octubre (DEC-1/DEC-7), **sobre metadatos y resúmenes** en el caso de IEEE Xplore por no haber acceso institucional (DEC-6). **Scopus y Web of Science quedan fuera de alcance** (DEC-8, confirmado).
- **No se buscó** artefactos comerciales ni de código abierto para detección de anomalías en lecturación y facturación. Es una búsqueda con método distinto (directorios de producto, documentación de implantes en distribuidoras, repositorios). **Decisión del asesor, 2 oct 2026:** se **difiere a después de la defensa de propuesta**, en la fase de construcción. La sección 9 del borrador debe declararlo como alcance no cubierto en esta versión.
- **No se aplicó** doble criba independiente ni medida de acuerdo entre revisores. Con una sola revisora no es posible. **Se declara como limitación, no se corrige en este ciclo.**
- **No se calcularon** números de prisma (registros identificados, eliminados, incluidos). No hay conteo reproducible porque aún no hay flujo de criba. **La ampliación decidida debe producirlos:** sin ese conteo, el estado del arte no se cierra.

**Consecuencia metodológica.** Las afirmaciones de brecha de este documento se escriben como **provisionales** y así están marcadas en el borrador —§2.1 y §9.5—. Pasa a definitiva solo cuando la ampliación a IEEE Xplore y SciELO/LILACS esté ejecutada con su cuenta de registros; mientras tanto, **se sostiene con esa nota explícita**.

---

## 3. Corpus verificado

Grupo **A** — pérdidas no técnicas: concepto, alcance y revisiones.
Grupo **B** — detección de anomalías: métricas, desequilibrio, explicabilidad.
Grupo **C** — del algoritmo a la inspección.

| N.º | Grupo | Referencia | Publicación | DOI |
|:--|:--|:--|:--|:--|
| 1 | A | Carr, D., y Thomson, M. (2022). Non-Technical Electricity Losses | *Energies*, *15*(6), 2218 | 10.3390/en15062218 |
| 2 | A | Saeed, M. S., et al. (2020). Detection of Non-Technical Losses in Power Utilities — A Comprehensive Systematic Review | *Energies*, *13*(18), 4727 | 10.3390/en13184727 |
| 3 | A | Yadav, R., y Kumar, Y. (2022). The detection of non-technical losses and electricity theft by smart meter data and Artificial Intelligence … A comprehensive review | *Int. J. of Computing and Digital Systems*, *12*(1), 731–740 | 10.12785/ijcds/120160 |
| 4 | A | de Oliveira Ventura, L., et al. (2020). A new way for comparing solutions to non-technical electricity losses in South America | *Utilities Policy*, *67*, 101113 | 10.1016/j.jup.2020.101113 |
| 5 | A | Henriques, H. O., et al. (2020). Monitoring technical losses to improve non-technical losses estimation and detection in LV distribution systems | *Measurement*, *161*, 107840 | 10.1016/j.measurement.2020.107840 |
| 6 | A | Zhang, B., Lin, G., Zheng, K., y Du, J. (2026). Anomaly Detection and Data Repair for Smart Meter Data in Smart Cities: A Comprehensive Review and Future Perspectives | *Sensors*, *26*(16), 5122 | 10.3390/s26165122 |
| 7 | B | Chandola, V., Banerjee, A., y Kumar, V. (2009). Anomaly detection: A survey | *ACM Computing Surveys*, *41*(3), 1–58 | 10.1145/1541880.1541882 |
| 8 | B | Axelsson, S. (2000). The base-rate fallacy and the difficulty of intrusion detection | *ACM TISSEC*, *3*(3), 186–205 | 10.1145/357830.357849 |
| 9 | B | Saito, T., y Rehmsmeier, M. (2015). The Precision-Recall Plot Is More Informative than the ROC Plot When Evaluating Binary Classifiers on Imbalanced Datasets | *PLOS ONE*, *10*(3), e0118432 | 10.1371/journal.pone.0118432 |
| 10 | B | Noorchenarboo, M., y Grolinger, K. (2025). Explaining deep learning-based anomaly detection in energy consumption data by focusing on contextually relevant data | *Energy and Buildings*, *328*, 115177 | 10.1016/j.enbuild.2024.115177 |
| 11 | B | Piscitelli, M. S., et al. (2026). A novel data-analytics based process for load profiling and meter-level anomaly detection in building energy consumption time series | *Energy and Buildings*, *368*, 117829 | 10.1016/j.enbuild.2026.117829 |
| 12 | B | Nwafor, O. N., et al. (2023). Explainable Artificial Intelligence for Prediction of Non-Technical Losses in Electricity Distribution Networks | *IEEE Access*, *11*, 73104–73115 | 10.1109/ACCESS.2023.3295688 |
| 13 | C | Guerrero, J. I., et al. (2018). Non-Technical Losses Reduction by Improving the Inspections Accuracy in a Power Utility | *IEEE TPWRS*, *33*(2), 1209–1218 | 10.1109/TPWRS.2017.2721435 |
| 14 | C | Massaferro, P., Di Martino, J. M., y Fernández, A. (2020). Fraud Detection in Electric Power Distribution: An Approach That Maximizes the Economic Return | *IEEE TPWRS*, *35*(1), 703–710 | 10.1109/TPWRS.2019.2928276 |
| 15 | C | Xia, X., Xiao, y Liang, W. (2020). SAI: A Suspicion Assessment-Based Inspection Algorithm to Detect Malicious Users in Smart Grid | *IEEE TIFS*, *15*, 361–374 | 10.1109/TIFS.2019.2921232 |

---

## 4. Eje A — Qué es una pérdida no técnica y qué ha resuelto el campo

### 4.1 El concepto es más ancho que el fraude

Carr y Thomson (2022) definen la pérdida no técnica de electricidad como un conjunto que **comprende robo, fraude, impago e irregularidades de facturación**. La definición es decisiva para este estudio: **la irregularidad de facturación está dentro del campo**, y el problema de diseño —lecturas mal tomadas y no barridas— cae en ese componente, no únicamente en el componente de fraude.

Un segundo hallazgo de Carr y Thomson (2022) matiza la intuición: la percepción pública y los titulares concentran la atención en el usuario residencial con pocos recursos, mientras que la literatura más robusta indica que la mayor proporción de pérdidas no técnicas proviene de **grandes usuarios, empresas estatales y hogares de mejor posición económica**. La consecuencia para el diseño es que **priorizar por perfil y por familia de código —y no por suposición sobre el tipo de usuario— es la decisión correcta**.

### 4.2 El campo ya está revisado

Tres revisiones sistemáticas o comprehensivas confirman madurez:

- **Saeed et al. (2020)** — revisión sistemática exhaustiva de métodos de detección de pérdidas no técnicas; clasifica los métodos por algoritmos, características extraídas y métricas de evaluación, y compara las tres grandes categorías —basados en datos, basados en red e híbridos— por rendimiento, coste y tiempo de respuesta.
- **Yadav y Kumar (2022)** — revisión comprehensiva de la detección de pérdidas no técnicas y robo de energía a partir de datos de medidor inteligente e inteligencia artificial, en el contexto de distribuidoras eléctricas.
- **Zhang et al. (2026)** — revisión comprehensiva de detección de anomalías y reparación de datos en medidores inteligentes, con perspectivas futuras.

**Lectura para este estudio.** Un campo con tres revisiones en seis años es un campo **maduro en su problema y en sus soluciones**. Esto refuerza lo que `04_marco_teorico.md` §2.6 dedujo de Gregor y Hevner (2013): **no se puede reclamar una contribución de técnica nueva**. El espacio de aporte está en otro lado.

### 4.3 El contexto regional ya tiene trabajos

De Oliveira Ventura et al. (2020) proponen una forma de **comparar soluciones a las pérdidas no técnicas de electricidad en Sudamérica**, publicada en *Utilities Policy* —una revista de política y regulación, no de ingeniería—. Henriques et al. (2020) proponen monitorizar las pérdidas **técnicas** para mejorar la estimación y detección de las **no técnicas** en sistemas de baja tensión.

**Lectura.** Existe trabajo regional y existe el vínculo con la regulación. **No se encontró** en esta pasada trabajo sobre distribuidoras reguladas de Bolivia ni sobre el uso del catálogo de códigos de irregularidad como variable de segmentación. Queda como **vacío de búsqueda** (§2.2), no como brecha demostrada.

---

## 5. Eje B — Cómo se detecta y cómo se evalúa

### 5.1 Qué tipo de dato usa la literatura

El patrón dominante es claro: **datos de medidor inteligente de alta frecuencia** —lecturas subhorarias o horarias capturadas por infraestructura de medición avanzada—, sobre los que se entrenan clasificadores supervisados o se construyen modelos de normalidad no supervisados (Saeed et al., 2020; Yadav y Kumar, 2022; Zhang et al., 2026).

**Este estudio no tiene ese dato.** Dispone de una **lectura mensual tabular** en `tfv_historico_lecturador` —`lec_actual`, `consumo`, `fecha_lec`— y de los reclamos registrados en `tfv_reclamo` y `tfv_reclamo_lectura`. No hay submedición, no hay curvas de carga por intervalo, no hay señal de manipulación del medidor.

Esa diferencia de dato **condiciona todo lo demás**: define qué características se pueden construir, qué etiquetas hacen falta y qué se puede prometer. Piscitelli et al. (2026) ilustran el extremo opuesto: un proceso analítico completo de **perfilado de carga y detección a nivel de medidor** sobre series de consumo. Aquí el perfilado se reduce a lo que el dato mensual permite: comparación de un mes contra sus propios ciclos históricos y contra la familia de código.

### 5.2 Qué tipo de etiqueta existe

En la literatura, la etiqueta positiva es un **caso confirmado de fraude o robo**, o bien no hay etiqueta y se usa aprendizaje no supervisado (Saeed et al., 2020). En este estudio la única candidata a etiqueta es el **reclamo procedente ante la ODECO**: 62 casos en 21 meses (`DATOS.xlsx`, Tabla 1).

Dos propiedades la distinguen de la etiqueta de la literatura:

1. **Es escasa** — véase `04_marco_teorico.md` §3.2.
2. **No es una detección: es una queja.** El usuario reclamó *después* de facturar. La etiqueta marca lo que **ya fracasó**, no lo que el método debió encontrar en su momento. Esto convierte a la evaluación retrospectiva de E8 en una prueba **conservadora**: si el método alertó sobre un caso que además llegó a reclamo, encontró algo que el proceso vigente no vio; si no alertó, no hay falsa alarma que exculpar, porque el caso no generó costo.

### 5.3 Cómo se evalúa

La literatura reporta rendimiento de clasificación —exactitud, F1, AUC— calculado sobre un conjunto de prueba (Saeed et al., 2020, que clasifica expresamente los trabajos por sus métricas). Ese estándar **no sirve aquí** por dos motivos demostrados: el desequilibrio hace que la exactitud sea engañosa (Saito y Rehmsmeier, 2015) y la falacia de la tasa base hace que el coste real dependa del volumen de alarmas, no de la exactitud (Axelsson, 2000).

**Consecuencia.** Los criterios de éxito de E8 —cobertura, falsos positivos, carga, aplicabilidad— **se apartan deliberadamente del estándar del campo**. Es una desviación justificada y documentada, no una ignorancia del estándar.

### 5.4 Explicabilidad

Nwafor et al. (2023) aplican inteligencia artificial explicable a la predicción de pérdidas no técnicas en redes de distribución; Noorchenarboo y Grolinger (2025) estudian cómo explicar la detección de anomalías en consumo **centrándose en los datos contextualmente relevantes**. Ambos trabajos confirman que el campo reconoció el problema: **una alerta que no se explica no se adopta**.

---

## 6. Eje C — Del algoritmo a la visita

Este es el eje más cercano al problema, y el que mejor delimita el aporte posible.

| Trabajo | Qué hace | Qué deja fuera |
|:--|:--|:--|
| Guerrero et al. (2018) | Reduce pérdidas no técnicas **mejorando la exactitud de las inspecciones** en una empresa de distribución | No describe el vínculo con un ciclo de lecturación-facturación ni con un catálogo regulatorio de irregularidades |
| Massaferro et al. (2020) | Formula la detección de fraude para **maximizar el retorno económico** de la inspección | Optimiza el retorno, no la integración procesal ni la trazabilidad de la decisión |
| Xia et al. (2020) | Algoritmo de inspección por **evaluación de sospecha** en red inteligente | La salida sigue siendo una priorización para otro agente, no un método completo con roles |

**Lectura.** El campo **ya sabe** que detectar no basta y que hay que decidir a quién inspeccionar bajo restricción. Este estudio no descubre eso. Lo que hace es llevar ese problema a su forma **procesal**: qué pasos, qué roles, qué criterio escrito, qué registro de resolución, dentro de una cadena que ya existe con cinco roles.

---

## 7. Por qué las soluciones existentes son insuficientes para este problema

Comparación por dimensión. La columna derecha cita la fuente que sostiene cada exigencia.

| Dimensión | Lo que hacen las soluciones existentes | Lo que exige este problema | Fuente de la exigencia |
|:--|:--|:--|:--|
| **Origen del dato** | Medidor inteligente de alta frecuencia (AMI) | Lectura **mensual** tabular en `tfv_historico_lecturador` | Saeed et al. (2020); Yadav y Kumar (2022); esquema confirmado 2 oct 2026 |
| **Etiqueta** | Casos confirmados de fraude, o ausencia total de etiquetas | 62 reclamos procedentes en 21 meses, posteriores a la facturación | `DATOS.xlsx`, Tabla 1 |
| **Objetivo** | Detectar robo, fraude o pérdida no técnica | Detectar **lectura anómala no declarada**, incluida la lectura mal tomada, no solo el fraude | Carr y Thomson (2022); definición operativa de E4 |
| **Universo de trabajo** | Cuenta contra red, sin marca previa | **98,96 %** sin código y **1,04 %** con código, coexistiendo en el mismo barrido | `DATOS.xlsx`, Tabla 3 |
| **Salida** | Puntuación o clasificación binaria | **Lista priorizada con techo de volumen**: ≈11 visitas diarias, cada alerta acatada es un desplazamiento | Axelsson (2000); `06_diagnostico.md` |
| **Explicación de la alerta** | Campo en expansión, no universal | **Obligatoria**: sin la comparación que originó la alerta, el verificador no puede aceptarla ni descartarla | Nwafor et al. (2023); Noorchenarboo y Grolinger (2025) |
| **Integración en el proceso** | Generalmente no descrita: el modelo es el final del artículo | El artefacto **es el proceso**: pasos, roles, criterios de entrada y salida, registro de resolución | March y Smith (1995), vía `04_marco_teorico.md` §2.1 |
| **Evaluación** | Exactitud, F1, AUC sobre conjunto de prueba | Aplicabilidad con verificadores ajenos + efectividad retrospectiva + carga dentro de capacidad | Saito y Rehmsmeier (2015); Venable et al. (2016) |
| **Punto de comparación** | Ausente o conjunto de control artificial | La **capacitación de mayo–junio de 2025**, que ya redujo el volumen un 80 % | Declaración de la tesista, 1 oct 2026 |

---

## 8. Brecha identificada — formulación provisional

> **Provisional.** Fundada en una búsqueda preliminar por Crossref con 15 trabajos del dominio (§2). Se sostiene hasta cerrar el protocolo de §2.2; entonces se confirmará, ampliará o retirará.

La literatura sobre detección de anomalías y pérdidas no técnicas en distribución eléctrica ha resuelto **cómo puntuar una lectura** y ha reconocido **que inspeccionar exige priorizar**. No se localizó, en esta pasada, trabajo que documente **cómo convertir esa puntuación en una decisión operativa dentro de un ciclo de lecturación-facturación sujeto a un catálogo regulatorio de irregularidades**, cuando concurren cuatro condiciones que sí están medidas en este caso:

1. **Etiquetas escasas y retardadas**: la única verdad de referencia disponible son reclamos de usuarios llegados después de facturar.
2. **Coste de la alerta asimétrico y no recuperable**: cada alerta acatada consume una visita que no se recupera.
3. **Alternativa vigente ya eficaz**: la capacitación de mayo–junio de 2025 redujo las correcciones un 80 %, de modo que el problema real es el **residual** de 242,2 correcciones mensuales, no la inacción.
4. **Universo segmentado por el regulador**: el 98,96 % del facturable circula sin código de irregularidad y ningún proceso lo barre.

A esto se añade la observación de Carr y Thomson (2022) de que la pérdida no técnica **incluye irregularidades de facturación** y no solo fraude, que es lo que hace pertinente este problema dentro del campo.

**Lo que esta propuesta aporta, en una frase.** No un detector nuevo, sino la **formalización como método** —pasos, roles, criterio escrito, techo de capacidad y registro de resolución— de una detección que hoy existe informalmente en una sola persona, y los **principios de diseño** que de su aplicación se desprenden para una distribuidora regulada por la AETN.

---

## 9. Qué se buscó y no se encontró

Registrar los vacíos es parte del protocolo. Aquí **no se afirma que algo no exista**: se afirma que **esta búsqueda no lo encontró**.

| Búsqueda sin resultado | Interpretación | Acción |
|:--|:--|:--|
| Auditoría y control interno aplicados a distribuidoras reguladas | Cadena de términos sin retorno útil | **Retirado del marco teórico** (`04_marco_teorico.md` §5.2); queda como condición de contorno empírica |
| Atención de reclamos ante entes reguladores de electricidad | Mismos resultados no pertinentes | Pendiente de búsqueda en bases especializadas en regulación |
| Trabajos de distribuidoras bolivianas o del marco AETN | **Vacío de búsqueda**: no se consultaron SciELO ni LILACS | **Ampliación 3–4 oct** (DEC-1/DEC-7): IEEE Xplore sobre metadatos y resúmenes + SciELO/LILACS, con conteo de registros |
| Artefactos comerciales y de código abierto de detección en lecturación | **No se buscó**; requiere método distinto | **Diferido a después de la defensa de propuesta** (decisión del asesor, 2 oct 2026) |
| Etiqueta de "lectura mal tomada" como categoría de anomalía | No localizado en esta pasada | Es la categoría central de este estudio; verificar con búsqueda ampliada |

---

## 10. Consecuencia para las etapas siguientes

| Etapa | Qué le entrega E5 | Qué debe hacer ella con eso |
|:--|:--|:--|
| **E7a** — Alternativas | El espacio de opciones está constreñido por el dato mensual y por la escasez de etiquetas; la priorización bajo capacidad es obligatoria, no opcional | Comparar alternativas con esos tres filtros explícitos y **contra la capacitación de 2025** como alternativa existente |
| **E7b** — Requisitos | Escrito y reproducible; ambas direcciones; techo de volumen; explicación obligatoria; registro de resolución | Convertir cada una de esas cinco exigencias en requisito verificable, con su valor numérico |
| **E7c** — Diseño | Segmentación por perfil previa a la detección; estacionalidad anual sostenida por los 57 meses del histórico | Exige **ejecutar antes** la extracción ampliada A2.1–A2.4 |
| **E8** — Evaluación | Métricas precisión-exhaustividad, no exactitud; evaluación retrospectiva conservadora por la naturaleza de la etiqueta; dos ciclos con rediseño | Fijar valores **antes** de construir; mantener el ciclo formativo-sumativo completo |
| **E9 / E10** | Principios de diseño redactados con objetivo → contexto → mecanismo → principio y con condiciones de contorno explícitas | Cada principio debe poder ser leído por una distribuidora que no es ENDE |

---

## 11. Registro de verificación de fuentes

**Método.** Consulta a la API de Crossref el **2 de octubre de 2026**, primero por cadena de términos y luego por resolución directa de DOI, comprobando en cada caso autoría, título, publicación, volumen, número y páginas.

**Resultado.** **15 de 15** entradas del corpus del dominio verificadas. Ninguna se cita sin comprobar.

**Fuentes descartadas durante la búsqueda** por no superar el criterio de calidad o por no guardarse relación con el problema: revisiones de editoriales sin revisión por pares, artículos de congresos sin índice, y cinco trabajos localizados pero cuyo contenido no correspondía a la cadena usada (recogidos en §9).

**Dudas abiertas de verificación.**

1. Hevner (2007): sin rango de páginas confirmado en fuente abierta — ver `04_marco_teorico.md` §9. *Se cita el número de artículo; no bloquea.*
2. ~~Discrepancia 75–105 / 75–106 en Hevner et al. (2004)~~ → **resuelta el 2 oct 2026 (DEC-5): se conserva 75–105.** La discrepancia queda registrada en `04_marco_teorico.md` §9 y no se reprodujo en el borrador.
3. El corpus del dominio está **sesgado hacia Crossref**: los trabajos de IEEE localizados fueron los que aparecieron en las referencias cruzadas de las revisiones MDPI, no el resultado de una búsqueda en IEEE Xplore. **Se ataca con DEC-1** (IEEE Xplore sobre metadatos, 3–4 oct); **el sesgo se da por superado solo cuando esté el conteo de registros.**
4. **Plantilla objetivo → contexto → mecanismo → principio:** `[por verificar]` el capítulo y la página de Wieringa (2014) — *fuera de este gate, se sigue en `04_marco_teorico.md` §10 como E4-4.*

---

## 12. Gate de E5

| # | Criterio | Estado |
|:--|:--|:--|
| 1 | Está escrita la pregunta de búsqueda, las cadenas, las bases, los criterios de inclusión y exclusión y el criterio de calidad | **Cumple** (§2.1) |
| 2 | Está declarado lo que **no** se buscó y qué fuerza le resta eso a las conclusiones | **Cumple** (§2.2, §9) |
| 3 | Toda referencia fue verificada antes de citarse | **Cumple** (§11): 15 de 15 |
| 4 | Las afirmaciones de brecha están marcadas como provisionales | **Cumple** (§8) |
| 5 | Se responde la pregunta guía de forma explícita y en una frase recuperable | **Cumple** (§8, último párrafo) |
| 6 | La respuesta declara qué **no** se aporta, además de qué se aporta | **Cumple**: no se aporta técnica nueva (§4.2, `04_marco_teorico.md` §2.6) |
| 7 | Hay una consecuencia trazable para E7a, E7b, E7c y E8 | **Cumple** (§10) |
| 8 | Las cifras citadas provienen de documentos ya cerrados, con su fuente | **Cumple**: 62, 21, 242,2, 98,96 %, 1,04 %, 80 %, ≈11, 57 — todas trazadas |

**Gate de E5.** Puntos antes de la propuesta completa:

*Cerrados el 2 de octubre de 2026 (decisiones del asesor):*

- ~~¿Ampliar el protocolo?~~ → **Sí.** Se amplía a **IEEE Xplore y SciELO/LILACS**, con cuenta de registros identificados, eliminados e incluidos. Sin ese conteo el estado del arte **no se cierra**.
- ~~¿Buscar artefactos comerciales y de código abierto?~~ → **Se difiere a después de la defensa de propuesta.** Se declara en el borrador como alcance no cubierto en esta versión, no como pendiente dentro de la sección.

*Abiertos:*

1. **Ejecutar la ampliación el 3–4 de octubre** (DEC-1/DEC-7): **IEEE Xplore sobre metadatos y resúmenes públicos** (DEC-6, sin acceso institucional) + **SciELO y LILACS abiertos**, produciendo la cuenta de registros identificados, eliminados e incluidos. **Sin ese conteo E5 no se cierra.** *Scopus y Web of Science fuera de alcance (DEC-8, confirmado).*
2. **Revisar la brecha de §8** tras esa ampliación: confirmar, ampliar o retirar. **Hasta entonces sigue provisional.**
3. **Verificar si existe literatura que use «lectura mal tomada» como categoría de anomalía** —es la categoría central de este estudio y no se localizó—; forma parte de la ampliación.
