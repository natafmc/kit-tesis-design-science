# E5. Estado del arte

| | |
|:--|:--|
| **Estado** | **cerrada el 2 de octubre de 2026** |
| **Entrega** | **2 de octubre de 2026**, con E4 (DEC-9: entregada el mismo día de cierre, no el 4 como se declaró) |
| **Pregunta guía** | ¿Por qué las soluciones existentes son insuficientes para este problema y qué aporta esta propuesta que ellas no aportan? |
| **Regla de verificación** | Ninguna referencia entra sin autoría, título, publicación, volumen, número, páginas y DOI comprobados. Lo no comprobado queda `[por verificar]`. Registro en la sección 10. |
| **Advertencia de alcance** | Esta es una **búsqueda bibliográfica con protocolo declarado, no una revisión sistemática** —no hubo doble criba independiente ni conteos de flujo (ver §2)—. **La brecha de §8 quedó cerrada el 7 de octubre de 2026 (DEC-35)** sobre la ampliación con cuenta de registros del 5 de octubre. **Sigue vigente como limitación declarada el carácter no sistemático.** |
| **Decisiones del asesor, 2 oct 2026** | (1) Se **amplía a IEEE Xplore y SciELO/LILACS el 3–4 de oct** (DEC-1/DEC-7), con cuenta de registros identificados, eliminados e incluidos. (2) IEEE Xplore **sobre metadatos y resúmenes**, sin acceso institucional (DEC-6). (3) Los **artefactos comerciales y de código abierto** se **difieren a después de la defensa de propuesta** (DEC-2). (4) **Scopus y Web of Science fuera de alcance** (DEC-8, confirmado). |
| **Ejecución fallida, 3–4 oct 2026** | **DEC-1 y DEC-3 se intentaron sin dejar registro del resultado (DEC-13): se repitieron el 5 de octubre con cuenta de registros.** **DEC-14** (E5-1a) y **DEC-16** (E5-4) están **volcadas y cuadradas** en §2.4 → **E5-3 se resolvió el 7 de octubre por *ampliar* (DEC-35): §8 se reescribió y quedó cerrado.** **DEC-15** (E4-5) corrió su parte académica y **no pudo ejecutar la institucional** (DEC-23) → **cerrada el 7 de octubre con la limitación escrita (DEC-34).** El borrador se entregó el 5 oct con la nota de provisionalidad puesta (DEC-11) —**levantada el 7 de octubre**—. |
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
| **Ampliación pendiente** | **Intentada 3–4 oct sin cuenta de registros (DEC-1/DEC-13): se repite en la ventana 6–12 oct** — IEEE Xplore + SciELO + LILACS. Scopus y Web of Science **fuera de alcance** (DEC-8, confirmado) |
| **Limitación de acceso a IEEE Xplore** | **No hay acceso institucional (DEC-6):** se consultará sobre **metadatos y resúmenes públicos**, no sobre texto completo. **Se declara porque condiciona qué se pudo leer de cada registro**: para los trabajos accesibles solo se extraerá lo que el registro público exhibe. Si un registro no permite evaluar los criterios de inclusión, se excluye **y se cuenta como excluido**, no se da por incluido |
| **Tipo de consulta** | (a) búsqueda bibliográfica por cadena de términos con orden por relevancia; (b) resolución directa por DOI |
| **Filtros aplicados** | Artículos de revista; desde 2015 salvo para los trabajos canónicos de referencia; sin filtro de idioma |
| **Cadenas usadas** | `non-technical losses detection electricity distribution review` · `electricity theft detection smart meter machine learning unsupervised` · `smart meter data anomaly detection review energy consumption` · `regulation incentives non-technical losses distribution utility tariff auditing` · `electricity distribution consumer complaints ombudsman regulation service quality` |
| **Criterio de inclusión** | Que trate detección de anomalías o pérdidas no técnicas en distribución eléctrica, **o** los aspectos metodológicos de detección (métrica, desequilibrio, explicabilidad, priorización de inspección), con revisión por pares |
| **Criterio de exclusión** | Publicaciones de editoriales sin revisión por pares; actas de congresos de divulgación; metadatos incompletos; resultados sin relación con el problema |
| **Criterio de calidad** | Revisión sistemática, artículo de revista de difusión indexada, o trabajo de una comunidad técnica reconocida (IEEE/ACM) |
| **Extracción** | Autoría, año, título, publicación, volumen, número, páginas, DOI |
| **Total incorporado** | **15 trabajos**: 6 del eléctrico como fenómeno (eje A) y 9 de detección e inspección (ejes B y C). Más los 7 de Design Science de `04_marco_teorico.md` → **22 entradas en total**. *Materiales internos `referencias/ds_ch*.md`: no se citan (DEC-4)* |

### 2.2 Lo que no se hizo — y lo que se hizo sin registrar

Está declarado porque **condiciona la fuerza de las afirmaciones de este documento**. **Dos cosas se intentaron el 3–4 de octubre** —la ampliación DEC-1 y la búsqueda DEC-3— **pero ninguna dejó registro, así que a los efectos de este documento no ocurrieron** (DEC-13):

- **No se consultaron** IEEE Xplore, Scopus, Web of Science, SciELO ni LILACS *en la búsqueda preliminar del 2 oct*. La ausencia de resultados en Sudamérica y en contextos regulados andinos fue, por tanto, **un vacío de búsqueda, no una constatación**. **La ampliación se intentó el 3–4 de octubre** (DEC-1/DEC-13) — IEEE Xplore **sobre metadatos y resúmenes** por no haber acceso institucional (DEC-6) + SciELO y LILACS abiertos — **pero no dejó cuenta de registros, así que se repite en la ventana 6–12 de octubre** y el vacío **no se levanta todavía**. **Scopus y Web of Science quedan fuera de alcance** (DEC-8, confirmado).
- **No se buscó** artefactos comerciales ni de código abierto para detección de anomalías en lecturación y facturación. Es una búsqueda con método distinto (directorios de producto, documentación de implantes en distribuidoras, repositorios). **Decisión del asesor, 2 oct 2026:** se **difiere a después de la defensa de propuesta**, en la fase de construcción. La sección 9 del borrador debe declararlo como alcance no cubierto en esta versión.
- **No se aplicó** doble criba independiente ni medida de acuerdo entre revisores. Con una sola revisora no es posible. **Se declara como limitación, no se corrige en este ciclo.**
- **No se calcularon** números de prisma (registros identificados, eliminados, incluidos). No hay conteo reproducible porque aún no hay flujo de criba. **La ampliación decidida debe producirlos:** sin ese conteo, el estado del arte no se cierra.

**Consecuencia metodológica.** Las afirmaciones de brecha de este documento se escribieron como **provisionales** y así estuvieron marcadas en el borrador —§2.1 y §9.5—. **La condición se cumplió el 5 de octubre de 2026** con la repetición con cuenta de registros (DEC-14, DEC-15 y DEC-16, volcadas en §2.4), **y la tesista resolvió el 7 de octubre ampliar la brecha (DEC-35)**: §8 dejó de llevar la nota de provisionalidad. **Lo que sí sigue siendo limitación declarada, y no provisionalidad:** que esto **no es una revisión sistemática** —una sola revisora, sin doble criba independiente ni conteos de flujo—, y que SciELO, IEEE Xplore y BVS **no fueron consultables** (DEC-20).

---

### 2.3 Cadenas declaradas antes de repetir — DEC-14, DEC-15 y DEC-16

**Regla de esta sección:** un conteo sin su cadena y su base declaradas no es reproducible. Las cadenas se escriben **antes** de buscar y la tabla de §2.4 se llena **en el momento de buscar**, no después de memorizar un resultado. *(Es precisamente el error que DEC-13 corrigió.)*

**DEC-14 — repetición de DEC-1.** **Vía de conteo: OpenAlex y DOAJ (DEC-20, 5 oct 2026).** Se reutilizan **las cinco cadenas y los tres criterios del protocolo v1 (§2.1) sin ningún cambio**. **Se declara lo que no se pudo consultar:**

| Base | Qué pasó el 5 oct 2026 | Estado |
|:--|:--|:--|
| **IEEE Xplore** | HTTP 200 pero **carcasa sin resultados** —los resultados los pinta JavaScript— y **sin acceso institucional (DEC-6)** | **No consultada directamente** |
| **SciELO** (`search.scielo.org`) | **403** en dos intentos | **No consultada directamente** |
| **SciELO**, interfaz antigua `scielo.php` | Responde, pero **el control `q=energia` también devolvió «sem resultados»**: no parsea la consulta, así que su «0» sería un recuento falso | **Descartada por control** |
| **LILACS / BVS** | **403** en `search.bvsalud.org` y en `pesquisa.bvsalud.org`. Además, **es una base de ciencias de la salud** (DEC-19) | **Fuera del protocolo** |
| **OpenAlex** (`api.openalex.org`) | Devuelve **`meta.count` real** y filtra por texto de título y resumen, revista, año y tipo | **Vía de conteo** |
| **DOAJ** (`doaj.org/api`) | Devuelve **`total` real**; indexa revistas de acceso abierto, **incluidas SciELO** | **Vía de conteo** |

**Regla de recuento (DEC-21):** *identificados* = **los 20 primeros por relevancia** de cada cadena en cada índice, cribados con los criterios de §2.1. **La suma debe cuadrar: identificados = eliminados + incluidos.** El `meta.count` / `total` del índice va en **columna aparte, como diagnóstico**, y **no entra en la suma**.

| Cadenas (idénticas a §2.1) | Índice |
|:--|:--|
| `non-technical losses detection electricity distribution review` · `electricity theft detection smart meter machine learning unsupervised` · `smart meter data anomaly detection review energy consumption` · `regulation incentives non-technical losses distribution utility tariff auditing` · `electricity distribution consumer complaints ombudsman regulation service quality` | OpenAlex (`title_and_abstract.search`) + DOAJ |

---

**DEC-16 — «lectura mal tomada» (E5-4).** La categoría central del estudio se busca **en las mismas tres bases de DEC-14, con las mismas cadenas de años y los mismos criterios**, más estos términos:

| Español | Inglés |
|:--|:--|
| `lectura mal tomada` · `lectura incorrecta` · `lectura errónea` · `error de lectura` · `medida errónea` | `meter reading error` · `incorrect meter reading` · `reading error` · `meter misreading` · `reading acquisition error` |

*Se busca en ambos idiomas porque el protocolo v1 no aplica filtro de idioma (§2.1). Si ni una sola coincidencia pasa los criterios, **el vacío deja de ser vacío de búsqueda y pasa a constatación** —y eso cambiaría la formulación de §8.*

---

**DEC-15 — control interno y auditoría (DEC-3), una sola vez.**

*Fuentes (DEC-17, 5 oct 2026), con la URL comprobada en el sondeo de ese día (DEC-22):* **AETN** — `aetn.gob.bo` *(la que figuraba, `aetn.org.bo`, no resuelve)* · **CNE / SENARECOM** — `www.senarecom.gob.bo` *(el dominio desnudo falla por certificado; CNE no resuelve)* · **OLADE** — `olade.org` / `olacde.org` · **CEPAL** — `cepal.org` · **ALER** — **no localizada**: `aler.org` es la de *educación radiofónica*, `aler-energia.org` es la *luso-fona de renovables*, `aler.org.uy` no resuelve · **Agencia Internacional de la Energía** — `iea.org`.

*Cadena:* `control interno auditoría pérdidas no técnicas distribución eléctrica regulador` · `non-technical losses internal audit electricity distribution regulator` · `incentivos tarifarios auditoría distribuidora pérdidas energía regulación`

*Criterio de calidad (DEC-18, 5 oct 2026):* **se aceptan fuentes no académicas** —informes de entes reguladores y organismos internacionales—, porque los entes reguladores no publican en revistas con revisión por pares y aplicarle el criterio de §2.1 dejaría la búsqueda **vacía por construcción**. **Se escribió antes de buscar y se cuenta aparte de las académicas** en §2.4. Académicas y no académicas van en filas separadas.

*Criterio de inclusión:* que trate control, auditoría o fiscalización de pérdidas no técnicas, incentivos tarifarios o atención de reclamos en distribuidoras reguladas. *Exclusión:* documentos sin relación con el problema; metadatos incompletos.

*Si ni una sola fuente pasa los criterios → **cierre por decisión explícita (DEC-15)** y no se reabre el tema en este ciclo.*

> **Estado al cierre del 5 oct 2026: ejecutado — ver resultado en §2.4.** La parte académica sí corrió; **la institucional no se pudo ejecutar** (DEC-23). El criterio de arriba, tal como está escrito, **no se puede aplicar** a las seis fuentes porque ninguna devolvió lectura posible. **Por eso el cierre no puede ser «no existe», sino «no se pudo buscar en esas fuentes»**, y eso es lo que queda escrito en §2.4.

---

### 2.4 Cuenta de registros — DEC-14, DEC-15 y DEC-16 (llenada en el momento de buscar, 5 oct 2026)

**Resumen de las tres corridas.**

| Corrida | Identificados | Eliminados | Incluidos | Trabajos distintos tras deduplicar |
|:--|--:|--:|--:|--:|
| **DEC-14** — cinco cadenas del protocolo v1 (E5-1a) | 58 | 26 | **32** | **28** |
| **DEC-16** — «lectura mal tomada», español e inglés (E5-4) | 330 | 308 | **22** | **21** |
| **DEC-15** — control interno y auditoría (E4-5) | 60 | 55 | **5** | **5** |
| **Total** | **448** | **389** | **59** | **54** |

*Las tres sumas cuadran por separado: 58 = 26 + 32 · 330 = 308 + 22 · 60 = 55 + 5. El total también: 448 = 389 + 59.* Los trabajos distintos se obtienen quitando los que se repiten entre cadenas —`10.17323/2587-814x.2025.4.68.87` en DEC-14 y `10.23960/jitet.v12i1.3776` en DEC-16— y verificando que las tres corridas no se solapen entre sí, que **no se solapan**.

**Regla de recuento (DEC-21, 5 oct 2026).** *Identificados* = **los 20 primeros por relevancia** de cada cadena en cada índice; si el índice devuelve menos, se toma lo que devuelva. **La suma debe cuadrar: identificados = eliminados + incluidos.** El **recuento del índice** (`meta.count` en OpenAlex, `total` en DOAJ) va en **columna aparte, como diagnóstico, y no entra en la suma.**

**Criba aplicada, declarada antes de leer los resultados.** Se **excluye** por: (a) tipo de publicación **sin revisión por pares** —disertación, tesis, preprint, depósito de repositorio, dataset, editorial, informe de revisión—; (b) **capítulo de libro**; (c) **registro duplicado**; (d) **no trate** detección de anomalías ni pérdidas no técnicas en distribución eléctrica, ni aspectos metodológicos de detección. Se **incluye** artículo de revista o paper de comunidad técnica reconocida que cumpla (d). *La calidad de la revista no se pudo verificar sin Scopus ni Web of Science (DEC-8): **se anota como salvedad, no como exclusión**, porque excluir por un criterio que no se puede comprobar sería peor que no excluir.*

**DEC-14 · OpenAlex** — `filter=title_and_abstract.search`, 5 oct 2026, 05:23–05:24 UTC

| Cadena §2.1 | Recuento del índice | Identificados | Eliminados | Motivo dominante de exclusión | Incluidos |
|:--|--:|--:|--:|:--|--:|
| 1 · `non-technical losses detection electricity distribution review` | 36 | 20 | 5 | 1 disertación · 2 Zenodo · 2 capítulos de libro | 15 |
| 2 · `electricity theft detection smart meter machine learning unsupervised` | 14 | 14 | 4 | 2 Zenodo · 1 duplicado · 1 dataset | 10 |
| 3 · `smart meter data anomaly detection review energy consumption` | 23 | 20 | 16 | 6 fuera de tema · 4 preprint/repositorio · 4 informes de revisión · 1 editorial · 1 sin DOI | 4 |
| 4 · `regulation incentives non-technical losses distribution utility tariff auditing` | **0** | 0 | 0 | — | 0 |
| 5 · `electricity distribution consumer complaints ombudsman regulation service quality` | **0** | 0 | 0 | — | 0 |
| **Total** | **73** | **54** | **25** | | **29** |

**DEC-14 · DOAJ** — `/api/search/articles`, 5 oct 2026, 05:24–05:25 UTC

| Cadena §2.1 | Recuento del índice | Identificados | Eliminados | Motivo dominante de exclusión | Incluidos |
|:--|--:|--:|--:|:--|--:|
| 1 | 3 | 3 | 0 | — | 3 |
| 2 | **0** | 0 | 0 | — | 0 |
| 3 | 1 | 1 | 1 | pronóstico de carga, no detección | 0 |
| 4 | **0** | 0 | 0 | — | 0 |
| 5 | **0** | 0 | 0 | — | 0 |
| **Total** | **4** | **4** | **1** | | **3** |

**DOIs incluidos** (lista reproducible):

- *Cadena 1, OpenAlex (15):* `10.12785/ijcds/120160` · `10.1016/j.rser.2017.05.193` · `10.1016/j.epsr.2018.01.005` · `10.3390/en13184727` · `10.47852/bonviewaia62026686` · `10.1109/tdc.2012.6281652` · `10.3390/app15073517` · `10.1016/j.rser.2017.10.040` · `10.1515/ijeeps-2015-0206` · `10.3390/en19163877` · `10.65525/jrtee.v2i1.18` · `10.63282/3050-9246.ijetcsit-v4i3p120` · `10.11591/ijape.v11.i2.pp109-119` · `10.1007/s11831-024-10137-z` · `10.17323/2587-814x.2025.4.68.87`
- *Cadena 2, OpenAlex (10):* `10.1109/pesgm40551.2019.8973564` · `10.1109/sgc49328.2019.9056579` · `10.1109/aupec66173.2025.11219523` · `10.1109/tps-isa62245.2024.00018` · `10.22214/ijraset.2026.84787` · `10.1109/greentech56823.2023.10173841` · `10.3390/app14209308` · `10.1109/sasg68584.2025.11365375` · `10.1109/isitia66279.2025.11137434` · `10.32604/cmc.2019.06497`
- *Cadena 3, OpenAlex (4):* `10.1016/j.apenergy.2021.116601` · `10.11591/eei.v10i1.2026` · `10.1109/smartgencon56628.2022.10084068` · `10.17323/2587-814x.2025.4.68.87`

**Deduplicación.** `10.17323/2587-814x.2025.4.68.87` aparece en las cadenas 1 y 3 → **−1**. **DOAJ no añade nada nuevo:** sus 3 incluidos —`10.3390/en13184727`, `10.3390/app15073517`, `10.3390/en19163877`— **ya estaban en la cadena 1 de OpenAlex**. *Esto también es un resultado: la cobertura de acceso abierto de DOAJ sobre este tema está entera dentro de OpenAlex.*

> **Total DEC-14 tras deduplicar: 28 trabajos distintos** (29 de OpenAlex − 1 repetido; DOAJ suma 0). *Se cribaron 58 registros; entraron 32 antes de deduplicar.*

**DEC-14 · DEC-16 — repetición**

**DEC-16 · OpenAlex** — `title_and_abstract.search`, 5 oct 2026, 05:30–05:33 UTC. **Los 20 primeros por relevancia de cada cadena.**

| Cadena | Recuento del índice | Identificados | Eliminados | Motivo dominante de exclusión | Incluidos |
|:--|--:|--:|--:|:--|--:|
| *Español* `lectura mal tomada` | 16 | 16 | 16 | 8 literatura/filosofía · 3 disertaciones · 2 veterinaria · 3 otros | 0 |
| *Español* `lectura incorrecta` | 147 | 20 | 20 | 12 lectura/educación · 4 Zenodo · 2 medicina · 2 otros | 0 |
| *Español* `lectura errónea` | 75 | 20 | 20 | 16 literatura/filosofía · 1 libro · 3 otros | 0 |
| *Español* `error de lectura` | 2 227 | 20 | 20 | 13 lingüística/educación · 3 disertaciones · 1 capítulo · 3 otros | 0 |
| *Español* `medida errónea` | 287 | 20 | 20 | 18 temas ajenos · 2 estimación de estado en transmisión *(además, sin DOI)* | 0 |
| **Subtotal español** | **2 752** | **96** | **96** | | **0** |
| *Inglés* `meter reading error` | 2 436 | 20 | 12 | 8 informes de revisión · 3 agua/gas · 1 preprint | 8 |
| *Inglés* `incorrect meter reading` | 175 | 20 | 16 | 3 Zenodo · 7 agua/gas/otros · 4 sin DOI · 2 automática de lectura | 4 |
| *Inglés* `reading error` | 56 504 | 20 | 20 | 16 psicolingüística/dislexia · 2 capítulos · 2 otros | 0 |
| *Inglés* `meter misreading` | 79 | 20 | 12 | 4 otros medidores · 3 automatización de lectura · 5 fuera de tema | 8 |
| *Inglés* `reading acquisition error` | 1 951 | 20 | 20 | 18 adquisición lectora/medicina · 2 capítulos | 0 |
| **Subtotal inglés** | **61 145** | **100** | **80** | | **20** |
| **Total OpenAlex** | **63 897** | **196** | **176** | | **20** |

**DEC-16 · DOAJ** — `/api/search/articles`, 5 oct 2026, 05:34 UTC

| Cadena | Recuento del índice | Identificados | Eliminados | Incluidos |
|:--|--:|--:|--:|--:|
| `lectura mal tomada` | 0 | 0 | 0 | 0 |
| `lectura incorrecta` | 8 | 8 | 8 | 0 |
| `lectura errónea` | 22 | 20 | 20 | 0 |
| `error de lectura` | 72 | 20 | 20 | 0 |
| `medida errónea` | 31 | 20 | 20 | 0 |
| `meter reading error` | 58 | 20 | 19 | 1 |
| `incorrect meter reading` | 4 | 4 | 4 | 0 |
| `reading error` | 1 282 | 20 | 20 | 0 |
| `meter misreading` | 2 | 2 | 2 | 0 |
| `reading acquisition error` | 39 | 20 | 19 | 1 |
| **Total DOAJ** | **1 518** | **134** | **132** | **2** |

**Total DEC-16: 330 identificados = 308 eliminados + 22 incluidos.** Tras deduplicar `10.23960/jitet.v12i1.3776` —que aparece en dos cadenas— **quedan 21 trabajos distintos.**

**DOIs incluidos (21):** `10.1109/iceec.2004.1374588` · `10.1109/emceurope.2019.8872006` · `10.1109/cpem.2018.8501256` · `10.1109/cpem.2018.8501197` · `10.1007/bf00813099` · `10.35534/rwc.0201002c` · `10.52626/joge.v3i2.47` · `10.23960/jitet.v12i1.3776` · `10.1109/inmic48123.2019.9022772` · `10.1049/icp.2021.1987` · `10.1007/s41403-022-00362-y` · `10.23919/emctokyo.2019.8893903` · `10.1109/emceurope.2019.8871469` · `10.1109/apemc49932.2021.9597172` · `10.1109/tpwrd.2022.3149727` · `10.1109/emceurope.2019.8871982` · `10.1109/emceurope.2018.8485024` · `10.1109/emc/si/pi/emceurope52599.2021.9559296` · `10.1109/emc/si/pi/emceurope52599.2021.9559376` · `10.1109/ACCESS.2024.3471669` · `10.3390/s26165122`

*Estos 21 son **candidatos al corpus, no corpus**: entran en §3 solo cuando sus metadatos se verifiquen uno a uno. **E5-3 se resolvió el 7 de octubre de 2026 por *ampliar* (DEC-35)**, y estos trabajos quedaron registrados como base de esa decisión.*

> **Hallazgo de E5-4.** En español, **0 de 164 registros cribados** corresponde a la categoría. El término «lectura mal tomada» **no existe como categoría en la literatura consultada**: en español devuelve exclusivamente literatura, lingüística y pedagogía; en DOAJ ni siquiera devuelve un registro. En inglés hay **21 trabajos**, pero tratan el error de lectura de medidor como problema **metrológico** —EMI, armónicas, mecanismo de conteo, sensibilidad bajo carga no senoidal— y **no como categoría operativa**: una lectura mal tomada por una persona que el proceso no advierte. **Ese es exactamente el hueco que el estudio ocupa**, y ahora está constatado y no solo supuesto.

**DEC-15 — control interno y auditoría**

**DEC-15 · Fuentes institucionales** — sondeo del 5 oct 2026. **Ninguna de las seis arrojó resultado extraíble**, y por razones distintas que se declaran una por una:

| Fuente | URL usada | Qué pasó | Identificados |
|:--|:--|:--|--:|
| **AETN** | `aetn.gob.bo` — *la del protocolo, `aetn.org.bo`, no resuelve (DNS)* | HTTP 200. **La página es idéntica para cualquier consulta:** comparando el conjunto de enlaces con una cadena real y con una nula, **solo cambia la URL del feed RSS**, que devuelve **0 `<item>` en ambos casos** | **0 extraídos** |
| **SENARECOM** | `www.senarecom.gob.bo` — *el dominio desnudo falla por certificado* | Mismo comportamiento: **enlaces idénticos** con cadena real y nula; feed **0 `<item>`** | **0 extraídos** |
| **OLADE** | `olade.org` / `olacde.org` | Misma prueba: **3 enlaces distintos y los tres son el propio feed**; resultados pintados por JavaScript | **0 extraídos** |
| **CEPAL** | `cepal.org/es/search?query=` | Buscador existe (HTTP 200), pero **cero enlaces diferentes** entre cadena real y nula → los resultados se pintan en el cliente | **0 extraídos** |
| **ALER** | **No se localizó** | `aler.org` = *Asociación Latinoamericana de **Educación Radiofónica***; `aler-energia.org` = *Associação Lusófona de Energias Renováveis*; `aler.org.uy` → **DNS no resuelve**. **Las tres son organizaciones distintas de la de entes reguladores** | **No consultada** |
| **Agencia Internacional de la Energía** | `iea.org/search?q=` | HTTP 200, **título genérico**: buscador de cliente, resultados no extraíbles | **0 extraídos** |
| **Intento alternativo: DuckDuckGo `site:`** | — | **Método inválido:** el control nulo devolvió **exactamente lo mismo** que la cadena real en `site:aetn.gob.bo` (10 = 10), es decir **ignora el resto de la consulta**; y las cuatro consultas siguientes devolvieron 0 por límite de uso | **0** |
| **Subtotal no académicas** | | | **0** |

**DEC-15 · Control académico — Crossref** (`type:journal-article`, `sort` por relevancia, 5 oct 2026)

| Cadena §2.3 | Corpus (no coincidencias) | Identificados | Eliminados | Motivo dominante | Incluidos |
|:--|--:|--:|--:|:--|--:|
| `control interno auditoría pérdidas no técnicas distribución eléctrica regulador` | 1 679 661 | 20 | 20 | 20 **contabilidad y auditoría presupuestaria**, ninguno sobre pérdidas ni distribución eléctrica | 0 |
| `non-technical losses internal audit electricity distribution regulator` | 3 056 479 | 20 | 18 | 16 **algoritmos de detección** · 2 mitigación técnica | 2 |
| `incentivos tarifarios auditoría distribuidora pérdidas energía regulación` | 9 688 | 20 | 17 | 12 ajenos · 3 generación renovable · 2 gestión de proyectos | 3 |
| **Total académicas** | — | **60** | **55** | | **5** |

**Total DEC-15: 60 identificados = 55 eliminados + 5 incluidos.**

**DOIs incluidos (5):** `10.1049/icp.2023.0334` *(Electric energy distribution — control of NTL)* · `10.1016/j.jup.2012.05.004` *(prepayment billing to reduce NTL, Utilities Policy)* · `10.12660/rda.v226.2001.47249` *(distribuidora y racionamiento)* · `10.11117/22361766.40.01.06` *(tarifas en distribución de energía eléctrica)* · `10.1080/02646811.2018.1558966` *(Tratado de Regulación de la Energía)*

> **Lectura de DEC-15.** Ninguno de los cinco tratado **auditoría o control interno aplicado a pérdidas no técnicas**: tres son de **tarifas y regulación**, uno de **control de pérdidas**, uno de **facturación prepago**. La cadena `control interno auditoría…` devolvió **0 incluidos en 20**. **Las seis fuentes institucionales, en cambio, no se pudieron buscar** —no que no tengan nada, sino que sus buscadores se ejecutan en el cliente y no devolvieron lectura posible—. **Por eso E4-5 no se cierra con «no existe», sino que se cierra con esta limitación escrita.**

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

En la literatura, la etiqueta positiva es un **caso confirmado de fraude o robo**, o bien no hay etiqueta y se usa aprendizaje no supervisado (Saeed et al., 2020). En este estudio la única candidata a etiqueta es el **reclamo procedente ante la ODECO**: **174 casos en 57 meses** (`DATOS desde 2022.xlsx`, hoja `reclamos`); en la ventana corta de 21 meses eran **62** (`DATOS.xlsx`, Tabla 1).

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
| **Etiqueta** | Casos confirmados de fraude, o ausencia total de etiquetas | 174 reclamos procedentes en 57 meses, posteriores a la facturación | `DATOS desde 2022.xlsx`, hoja `reclamos` |
| **Objetivo** | Detectar robo, fraude o pérdida no técnica | Detectar **lectura anómala no declarada**, incluida la lectura mal tomada, no solo el fraude | Carr y Thomson (2022); definición operativa de E4 |
| **Universo de trabajo** | Cuenta contra red, sin marca previa | **99,12 %** sin código y **0,88 %** con código, coexistiendo en el mismo barrido | `DATOS desde 2022.xlsx`, hoja `tipo_lectura` |
| **Salida** | Puntuación o clasificación binaria | **Lista priorizada con techo de volumen**: ≈11 visitas diarias, cada alerta acatada es un desplazamiento | Axelsson (2000); `06_diagnostico.md` |
| **Explicación de la alerta** | Campo en expansión, no universal | **Obligatoria**: sin la comparación que originó la alerta, el verificador no puede aceptarla ni descartarla | Nwafor et al. (2023); Noorchenarboo y Grolinger (2025) |
| **Integración en el proceso** | Generalmente no descrita: el modelo es el final del artículo | El artefacto **es el proceso**: pasos, roles, criterios de entrada y salida, registro de resolución | March y Smith (1995), vía `04_marco_teorico.md` §2.1 |
| **Evaluación** | Exactitud, F1, AUC sobre conjunto de prueba | Aplicabilidad con verificadores ajenos + efectividad retrospectiva + carga dentro de capacidad | Saito y Rehmsmeier (2015); Venable et al. (2016) |
| **Punto de comparación** | Ausente o conjunto de control artificial | La **capacitación de mayo–junio de 2025**, que ya redujo el volumen un 80 % | Declaración de la tesista, 1 oct 2026 |

---

## 8. Brecha identificada

> **Cerrada el 7 de octubre de 2026 — DEC-35 (E5-3, opción *ampliar*).** La formulación provisional del 2 de octubre se reescribe con las tres corridas ya volcadas y cuadradas en §2.4 — **DEC-14, DEC-15 y DEC-16: 448 identificados = 389 eliminados + 59 incluidos → 54 trabajos distintos**. **Se amplía, no se confirma ni se retira:** la brecha se sostiene, pero hoy se enuncia mejor.

La literatura sobre detección de anomalías y pérdidas no técnicas en distribución eléctrica ha resuelto **cómo puntuar una lectura** y ha reconocido **que inspeccionar exige priorizar**. No se localizó trabajo que documente **cómo convertir esa puntuación en una decisión operativa dentro de un ciclo de lecturación-facturación sujeto a un catálogo regulatorio de irregularidades**, cuando concurren cuatro condiciones que sí están medidas en este caso:

1. **Etiquetas escasas y retardadas**: la única verdad de referencia disponible son reclamos de usuarios llegados después de facturar.
2. **Coste de la alerta asimétrico y no recuperable**: cada alerta acatada consume una visita que no se recupera.
3. **Alternativa vigente ya eficaz**: la capacitación de mayo–junio de 2025 redujo las correcciones un 80 %, de modo que el problema real es el **residual** de 242,2 correcciones mensuales, no la inacción.
4. **Universo segmentado por el regulador**: el 99,12 % del facturable circula sin código de irregularidad y ningún proceso lo barre.

**En qué se amplía — resolución del 7 de octubre de 2026 (DEC-35).** La versión del 2 de octubre se apoyaba en 15 trabajos y en una sola pasada de Crossref, y decía que **no se encontró**. Con las corridas del 5 de octubre la afirmación deja de ser un no-hallazgo y se convierte en una **diferencia de enfoque demostrada**, que es bastante más difícil de rebatir:

1. **El error de lectura existe en la literatura como problema metrológico, no como problema de proceso.** Los **20 trabajos en inglés** que tratan el error de lectura del medidor lo hacen por la vía de la interferencia electromagnética, las armónicas y el mecanismo de conteo —responden a **cómo el medidor mide mal**—; **ninguno lo trata como categoría operativa**, es decir, **qué hace la organización cuando la lectura sale mal**.
2. **«Lectura mal tomada» no es una categoría de la literatura consultada.** DEC-16: **330 identificados = 308 eliminados + 22 incluidos → 21 trabajos distintos**, de los cuales **0 en español sobre 164 registros cribados**. La categoría existe en el lenguaje de la operación y no en el de la investigación.
3. **Tampoco es objeto de auditoría ni de control interno.** DEC-15: **60 identificados = 55 eliminados + 5 incluidos**, ninguno sobre auditoría de pérdidas no técnicas, y la cadena `control interno auditoría…` dio **0 de 20**. Las seis fuentes institucionales **no fueron ejecutables** (DEC-23): **0 extraídos, no 0 existentes**.

**Consecuencia para la tesis.** Lo que falta no es literatura sobre detección —de eso hay—, ni sobre errores de lectura del medidor —también hay—, sino sobre **la conversión de una señal en una decisión dentro de un ciclo regulado**. Ese es el hueco que este método ocupa. Por eso la brecha se enuncia hoy **más estrecha y más defendible** que el 2 de octubre: ya no se afirma que nadie haya estudiado el tema, se afirma que **el tema está en otra disciplina y con otro objeto**.

A esto se añade la observación de Carr y Thomson (2022) de que la pérdida no técnica **incluye irregularidades de facturación** y no solo fraude, que es lo que hace pertinente este problema dentro del campo.

**Lo que esta propuesta aporta, en una frase.** No un detector nuevo, sino la **formalización como método** —pasos, roles, criterio escrito, techo de capacidad y registro de resolución— de una detección que hoy existe informalmente en una sola persona, y los **principios de diseño** que de su aplicación se desprenden para una distribuidora regulada por la AETN.

---

## 9. Qué se buscó y no se encontró

Registrar los vacíos es parte del protocolo. Aquí **no se afirma que algo no exista**: se afirma que **esta búsqueda no lo encontró**.

| Búsqueda sin resultado | Interpretación | Acción |
|:--|:--|:--|
| Auditoría y control interno aplicados a distribuidoras reguladas | **Repetido 5 oct 2026 (DEC-15).** Control académico: 60 identificados → **5 incluidos, ninguno sobre auditoría de pérdidas no técnicas**; la cadena `control interno auditoría…` → **0 de 20**. **Las seis fuentes institucionales no se pudieron buscar** (DEC-23) | **CERRADA el 7 oct 2026 — DEC-34 (E4-5, opción A):** se cierra **con la limitación escrita**. El tema pasa a **condición de contorno documentada** en E2 y E6, y queda constancia en `04_marco_teorico.md` §5.2 y §6. **No se afirma que no exista: se afirma que lo académico no rindió fuente y que lo institucional no fue consultable** |
| Atención de reclamos ante entes reguladores de electricidad | Mismos resultados no pertinentes; **no corrió en esta corrida** | Queda pendiente; **no bloquea E5** |
| Trabajos de distribuidoras bolivianas o del marco AETN | **Repetido 5 oct 2026 (DEC-14), con cuenta de registros.** 58 identificados → 32 incluidos → **28 trabajos distintos**. **No aparece ninguno de distribuidora boliviana** | **Vacío de búsqueda confirmado** con método reproducible |
| Artefactos comerciales y de código abierto de detección en lecturación | **No se buscó**; requiere método distinto | **Diferido a después de la defensa de propuesta** (decisión del asesor, 2 oct 2026) |
| Etiqueta de "lectura mal tomada" como categoría de anomalía | **Buscada 5 oct 2026 (DEC-16), español e inglés, dos índices.** **330 identificados → 21 trabajos distintos incluidos, 0 en español de 164 registros cribados** | **El vacío pasó a constatación → §8 REFORMULADO el 7 oct 2026 (DEC-35)** |

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
| 4 | Las afirmaciones de brecha van acompañadas de su cuenta de registros y no se presentan como inexistencia demostrada | **Cumple**: §8 se cerró el 7 oct 2026 (DEC-35) sobre las tres corridas de §2.4, y hasta ese día el criterio vigente fue marcarlas como **provisionales**, que también se cumplió |
| 5 | Se responde la pregunta guía de forma explícita y en una frase recuperable | **Cumple** (§8, último párrafo) |
| 6 | La respuesta declara qué **no** se aporta, además de qué se aporta | **Cumple**: no se aporta técnica nueva (§4.2, `04_marco_teorico.md` §2.6) |
| 7 | Hay una consecuencia trazable para E7a, E7b, E7c y E8 | **Cumple** (§10) |
| 8 | Las cifras citadas provienen de documentos ya cerrados, con su fuente | **Cumple**: 1 053 reclamos · 57 meses · 174 procedentes · 136 (78,16 %) · 0,88 % con código · 99,12 % sin código · **0,79 % en 2022–2024 (control de periodo)** · 242,2 · 80 % · ≈11 — todas trazadas y verificadas antes de publicarse |

**Gate de E5.** Puntos antes de la propuesta completa:

*Cerrados el 2 de octubre de 2026 (decisiones del asesor):*

- ~~¿Ampliar el protocolo?~~ → **Sí.** Se amplía a **IEEE Xplore y SciELO/LILACS**, con cuenta de registros identificados, eliminados e incluidos. Sin ese conteo el estado del arte **no se cierra**.
- ~~¿Buscar artefactos comerciales y de código abierto?~~ → **Se difiere a después de la defensa de propuesta.** Se declara en el borrador como alcance no cubierto en esta versión, no como pendiente dentro de la sección.

*Hechos el 5 de octubre de 2026:*

1. ~~**Repetir DEC-1 con cuenta de registros (DEC-14)**~~ → **EJECUTADO.** OpenAlex + DOAJ, **58 identificados = 26 eliminados + 32 incluidos**, **28 trabajos distintos** (§2.4). E5-1a queda **cerrable** con esa confirmación.
2. ~~**Buscar «lectura mal tomada» en español e inglés (DEC-16 / E5-4)**~~ → **EJECUTADO.** **330 identificados = 308 eliminados + 22 incluidos**, **21 trabajos distintos** (§2.4). En español, **0 de 164 registros cribados**: **el vacío pasó a constatación.**

*Resueltos el 7 de octubre de 2026 (decisiones de la tesista):*

1. ~~**E5-3 — decidir la suerte de §8: confirmar, ampliar o retirar**~~ → **AMPLIAR (DEC-35).** §8 se reescribe con las tres corridas de §2.4, **deja de ir provisional** y gana la sección *En qué se amplía*: el error de lectura está en la literatura como **problema metrológico** —20 trabajos en inglés sobre EMI, armónicas y mecanismo de conteo— y **no como problema de proceso**; «lectura mal tomada» da 0 en español sobre 164 registros; y no es objeto de auditoría (0 de 20).
2. ~~**E4-5 — decidir cómo cierra DEC-15**~~ → **OPCIÓN A: cerrar con la limitación escrita (DEC-34).** La sección **no vuelve al marco teórico**; queda constancia en `04_marco_teorico.md` §5.2 y §6 de que lo académico no rindió fuente y que lo institucional no fue ejecutable, y el tema pasa a **condición de contorno documentada** en E2 y E6.

*Abiertos:*

1. **Confirmar el volcado de §2.4** para que E5-1a y E5-4 pasen de *ejecutadas* a *cerradas*.
