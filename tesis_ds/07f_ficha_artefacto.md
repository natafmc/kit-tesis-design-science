# Ficha del artefacto

> **Estado:** escrito el 4 de noviembre de 2026, en `E7f`, a partir de `plantillas/ficha_artefacto.md`. Debe permitir que otro investigador entienda y reproduzca el artefacto sin acceso al tesista.

## Identificación

- **Nombre del artefacto:** Método de detección y verificación previa a la facturación de lecturas anómalas no declaradas
- **Tipología** (constructo / modelo / método / instanciación / marco / composición): **método** (DEC-70)
- **Tesis y contexto:** Maestría en Ingeniería de Software (enfoque Design Science), tutor Luis Roberto Pérez Rios, Ph.D. ENDE, distribuidora comercial de energía eléctrica regulada por la AETN, Bolivia. Panel de 1 485 556 celdas cuenta-mes, 30 411 cuentas, 57 meses (enero de 2022 a septiembre de 2026). Producción en Markdown y APA 7.

## Problema

- **Problema de diseño que resuelve:** Una lectura con consumo incoherente puede no llevar código de irregularidad y ningún proceso la barre antes de facturar. La irregularidad se advierte después, cuando el usuario reclama, con plazos perentorios de 3 a 15 días hábiles y silencio administrativo positivo a favor del consumidor si la empresa no contesta (`02_delimitacion.md` §1).
- **Clase de problema y contexto:** Detección de anomalías en lecturación y facturación de energía eléctrica, método no supervisado (no existe corpus etiquetado; solo 174 etiquetas retardadas), distribución comercial regulada, verificación previa a la facturación.

## Requisitos

| Propiedad | Tipo (funcional/contextual) | Métrica | Fuente en el problema | Prioridad |
|:--|:--|:--|:--|:--|
| R1 | Criterio escrito y reproducible | La referencia es recalculable a mano por un verificador ajeno | `07b_requisitos.md` R1, `R1.4` | Funcional |
| R2 | Capacidad como techo, no como objetivo | ≤ 242 alertas/mes = 218 (`A2`) + 24 (`A1`) | `07b_requisitos.md` R2, `DEC-114` | Contextual |
| R3 | Alertas agrupadas por ruta | Cada grupo lleva número de cuentas y estimación de tiempo | `07b_requisitos.md` R3, `DEC-74` | Funcional |
| R4 | Cada alerta lleva su explicación | Cuenta y mes, referencia, dirección y magnitud, código, contingencia, segmentación, ruta, orden, registro | `07b_requisitos.md` R4, `DEC-103` | Funcional |
| R5 | Toda alerta termina en un registro | Tres estados: confirmada / descartada / pendiente, sin estado vacío | `07b_requisitos.md` R5, `DEC-43` | Funcional |
| R6 | Priorización es parte del método | Prioridad opera dentro de la ruta, no a nivel global; si el mes supera el techo se descarta la cola del orden | `07b_requisitos.md` R6, `DEC-45` | Funcional |
| R7 | Segmentación precede a la detección | Cuatro bandas de perfil y tres de familia como caracterización previa | `07b_requisitos.md` R7, `DEC-104`, `DEC-105` | Funcional |
| R8 | Regla de contingencia | `ciclos < 4`; media de hasta seis meses previos con `lec_actual ≠ 0` | `07b_requisitos.md` R8, `DEC-115`, `DEC-116` | Funcional |
| R9 | Precondiciones de entrada | E1 a E5 (`07d_metodo_escrito.md` §2) | `07b_requisitos.md` R9 | Contextual |
| R10 | Aplicabilidad | El equipo técnico sigue el método sin asistencia de la autora; 100 % de las alertas de la muestra resueltas por verificador ajeno usando solo el método escrito | `07b_requisitos.md` R10, `DEC-112` | Funcional |

## Diseño

- **Componentes y relaciones:** Depuración → Segmentación → Fórmula. La depuración excluye celdas y cuentas; la segmentación caracteriza (cuatro bandas de perfil, tres de familia) sin fijar `θ`; la fórmula calcula la referencia (mediana de los cuatro ciclos 2022–2025, referencia > 0), la desviación, aplica la contingencia A1 si `ciclos < 4`, aplica los umbrales `θ_A2` y `θ_A1` dentro de los cupos, agrupa por ruta y prioriza dentro de la ruta por severidad.
- **Diagrama (Mermaid o referencia a figura):** No existe aún; queda pendiente para `E7f`/`E8`.

## Decisiones de diseño

| Decisión | Alternativas consideradas | Justificación | Evidencia o base de conocimiento |
|:--|:--|:--|:--|
| Tipología método | constructo, modelo, marco, composición | La tesista eligió método en E1; fija el diseño de `E7`, la verificación de `E7e` y el método de evaluación de `E8` | `DEC-70`, `00_estado.md` L52 |
| Referencia = mediana de 4 ciclos | media, moda, umbral fijo | Recalculable a mano por un verificador ajeno | `DEC-90` P3 = (b), `DEC-96` |
| Umbral calibrado por capacidad | umbral único global decidido a gusto | `θ` se calibra contra la capacidad real del equipo, no se elige a gusto | `07b` §4.2, `DEC-119`, `DEC-120` |
| Contingencia A1 | excluir celdas con `ciclos < 4` | Un año con 8 meses cuenta para los 8 meses que tiene; no se deja sin cobertura a cuentas nuevas | `DEC-110`, `DEC-111`, `DEC-115`, `DEC-116` |
| Techo 242 = 218 + 24 | techo único o por canal | Reparto fijo e inviolable entre `A2` y `A1` | `DEC-114`, `R2.1`, `R2.5` |
| Ventana de detección: nueve meses de 2026 | 57 meses | La detección corre solo sobre enero–septiembre de 2026; los otros 48 meses quedan fuera del universo | `DEC-90` P1 = (a) |
| Exemplar = tres alertas | una, cinco, todas | Una de `A2` normal, una de `A1` con `R8.1`, y una con código de irregularidad | `DEC-125` |

## Versiones

| Versión | Pregunta de diseño | Qué reveló | Qué cambió |
|:--|:--|:--|:--|
| 1 (4 nov 2026) | ¿Cómo documentar el método para que un verificador ajeno lo siga sin la autora? | El método escrito en `07d_metodo_escrito.md` cumple el punto 1 del gate de `E7d` (`DEC-137`) | Versión inicial, no hay cambios previos |

## Verificación interna

- **Técnicas aplicadas:** `E7e` verifica la consistencia interna del método escrito: fórmulas completas (`07d_metodo_escrito.md` §4), cupos respetados por diseño (`DEC-114`), trazabilidad de `R1` a `R10` en §9 del método escrito, autocalculeos 1 a 9 cerrados y A a D pendientes (`07d_metodo_escrito.md` §7).
- **Resultados:** Punto 1 del gate de `E7d` cerrado (método escrito, `DEC-137`); puntos 2 a 6 pendientes del listado de alertas, que no existe.
- **Correcciones realizadas:** Ninguna; `E7e` se abre el 4 de noviembre de 2026 y no ha producido correcciones aún.

## Uso

- **Requisitos de instalación o precondiciones:** `E1` a `E5` del `07d_metodo_escrito.md` §2 (ventana fija enero 2022 – septiembre 2026, cierre obligatorio 30/09/2026, panel no viene con fila por cuenta y mes, catálogo de 48 códigos de irregularidad, identificador de ruta `tfv_ruta.id_ruta`, tablas vivas con sello de fecha).
- **Instrucciones de uso:** Ejecutar los 12 pasos en orden (`07d_metodo_escrito.md` §3): fijar ventana, construir panel, depurar, segmentar, calcular referencia, calcular desviación, aplicar contingencia A1, aplicar umbrales dentro de cupos, agrupar por ruta, priorizar dentro de la ruta, emitir alerta con sus declaraciones, registrar la resolución.

## Limitaciones conocidas

| Límite | Alcance |
|:--|:--|
| Referencia construida sobre ciclos corruptos | 1,71 % de los grupos (6 004 de 350 443) se construyen sobre dos o más ciclos con `lec_actual = 0`; su mediana no es robusta (`DEC-100`) |
| Banda 4 de perfil sin techo | Va de 135 hasta el máximo del panel; rango interno de más de siete mil veces (`DEC-104`) |
| Banda "con código" chica | 1 430 celdas, 0,78 %; no se fusiona con otra (`DEC-105`) |
| Cortes de perfil medidos antes de la depuración | `A2.3.h` corrió sobre el panel sin depurar (`07c` §3.6) |
| 48 de 57 meses sin desviación | La detección corre solo sobre 2026 (`DEC-90`) |
| Techo 242 sostenible solo mientras 2026 siga en régimen vigente | En 2025 el promedio era 800,3/mes (`DEC-45`) |

## Relación con la base de conocimiento

- **Teorías, principios o resultados que fundamentan el artefacto:** Formulación prescriptiva estructurada según la lógica **CIMO** de Denyer, Tranfield y van Aken (2008) —contexto, intervención, mecanismo y resultado—, con la anatomía del principio de Gregor, Kruse y Seidel (2020), enmarcada en el problema de diseño de Wieringa (2014) (`DEC-131`). van Aken (2004) como fuente de la plantilla objetivo → contexto → mecanismo → principio (`DEC-131`, `10_contribucion_conclusiones.md` §2).
