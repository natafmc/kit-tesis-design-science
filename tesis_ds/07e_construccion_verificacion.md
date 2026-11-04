# E7e — Construcción y verificación interna

**Apertura:** 4 de noviembre de 2026, por decisión de la tesista (respuesta a pregunta 1, opción a).

**Qué es esta etapa:** la verificación interna del método construido, antes de que `E8` lo evalúe en campo. Verifica que el método escrito en `07d_metodo_escrito.md` cumple los requisitos `R1` a `R10` y que puede ser seguido por un verificador ajeno sin asistencia de la autora (`R10.1`, `R1.4`).

**Estado del gate de `E7d` (puntos 2 a 6), que `E7e` debe cerrar:**

| # | Punto del gate de `E7d` | Estado | Qué se necesita para cerrarlo |
|--:|:--|:--|:--|
| 2 | El procedimiento ejecutable produce el listado de los nueve meses dentro de los cupos 218 (`A2`) y 24 (`A1`) | PENDIENTE | El procedimiento ejecutable (consultas SQL) y el listado de alertas |
| 3 | Cada alerta lleva sus declaraciones (referencia, ventana, dirección y magnitud, código, contingencia, segmentación) | PENDIENTE | El listado de alertas |
| 4 | Las alertas salen agrupadas por ruta, con número de cuentas y estimación de tiempo; la prioridad opera dentro de la ruta | PENDIENTE | El listado de alertas |
| 5 | El registro está construido: tres estados (confirmada / descartada / pendiente), con criterio y evidencia | PENDIENTE | El registro |
| 6 | El exemplar está escrito: tres alertas que un verificador puede recalcular a mano | PENDIENTE | El listado de alertas |

**Qué se verifica en `E7e` hoy, sin el listado:** la consistencia interna del método escrito:

- Las fórmulas del `07d_metodo_escrito.md` §4 están completas (referencia, desviación, alerta, desviación de A1, cupos).
- Los cupos `A2 ≤ 218`, `A1 ≤ 24`, `A2 + A1 ≤ 242` se respetan por diseño (`DEC-114`, `R2.1`, `R2.5`).
- Cada requisito `R1` a `R10` tiene su paso trazado en `07d_metodo_escrito.md` §9.
- Los autocalculeos del `07d_metodo_escrito.md` §7 están escritos: 1 a 9 cerrados por corridas anteriores; A a D pendientes de la ejecución del procedimiento ejecutable.

**Qué queda bloqueado:** cualquier cosa que exija el listado de alertas, porque ese listado **no existe** (`A2.1.d` mide la muestra de `E8` y no produce alertas). No se ejecuta ningún procedimiento ejecutable hoy.

**Autocalculeos escritos antes de correr:** los autocalculeos A a D del `07d_metodo_escrito.md` §7 ya están escritos. La corrida del procedimiento ejecutable, con sus predicciones escritas antes de correr, queda para cuando el listado de alertas exista.

**Estado actual de la etapa:** abierto, sin puntos cerrados. El punto 1 del gate de `E7d` ya está cerrado (punto 1 de `E7d`, `DEC-137`); los puntos 2 a 6 son de `E7d` y se cierran con `E7e` cuando el listado de alertas exista.
