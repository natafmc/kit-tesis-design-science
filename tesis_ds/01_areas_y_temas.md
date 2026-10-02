# E1 — Áreas de experiencia y temas

## Área de experiencia mayor

Desarrollo, soporte y administración de sistemas de información para la distribución comercial de energía eléctrica. Diez años de práctica en la materia, con rol de encargada y administradora del sistema: responde por la base de datos, el código y la operación del conjunto.

- **Organización:** ENDE, área de distribución comercial de facturación y venta de energía eléctrica.
- **Pila tecnológica del contexto:** PHP, PostgreSQL, JavaScript.
- **Formación de pregrado:** Ingeniería Industrial y de Sistemas.
- **Formación de posgrado:** Maestría en Ingeniería de Software (en curso; esta tesis es el trabajo de posgrado).

## Contexto real de construcción y evaluación

| Elemento | Estado | Detalle |
|:--|:--|:--|
| Acceso al sistema | Confirmado | Acceso total a base de datos y a código |
| Histórico de datos | Confirmado con vacíos por precisar | Periodo de gestión pasada y actual. *Corregido el 1 oct: la regional estudiada tiene **29 750 cuentas** exactas; la cifra de 20 000 era un estimado de usuarios actuales sin base y se retira del documento* |
| Marcadores de irregularidad | Parcial | Lecturas marcadas con código de la AETN; irregularidades por consumo se corrigen **antes** de facturar; reclamos de clientes en facturas donde no aceptan importe ni consumo |
| Evaluadores disponibles | Confirmado | Usuarios del sistema: lecturadores, facturadores y soporte |
| Tiempo semanal | Confirmado | 36 horas (20 de lunes a viernes, 8 el sábado y 8 el domingo) |

## Temas candidatos evaluados

| Candidato | Tipología | Relevancia práctica | Sustentación teórica | Riesgo principal |
|:--|:--|:--|:--|:--|
| A. Método de detección y verificación de irregularidades | Método + instanciación de apoyo | Alta: los marcadores y los reclamos ya existen en la base | Media-alta: detección de valores atípicos, proceso de auditoría, Design Science | Requiere decisión sobre la técnica de detección |
| B. Modelo de consumo esperado por usuario | Modelo | Alta: se valida contra el propio histórico | Alta: modelado de series y desviación | No hay casos etiquetados limpios; correcciones previas a facturación |
| C. Taxonomía de anomalías con reglas de identificación | Constructo o marco | Alta: nace de su dominio del sistema | Media: taxonomía y validación con expertos | Sin *exemplar* aplicada, la contribución es de grado |
| D. Arquitectura de modernización (Tema 2 del grupo) | Instanciación | Media | Baja | Un consultor podría hacerlo sin producir conocimiento publicable: frontera con la ingeniería pura |

## Decisión de E1

**Tema elegido:** detección de anomalías en lecturación y facturación, en la variante **A**, con tipología de artefacto **método**.

**Justificación.** El método es la tipología que mejor encaja con lo que la tesista sabe hacer y con lo que el contexto permite: no exige entrenar modelos predictivos —competencia que declara no tener—, ordena una secuencia de trabajo que hoy es irregular entre lecturadores, facturadores y auditores, y admite una *exemplar* directa sobre el sistema que ella administra. La técnica concreta de detección (reglas estadísticas frente a algoritmo de detección) queda abierta como **decisión de diseño de E7a**, donde se compararán alternativas con trade-offs explícitos; no se promete en el título.

**Gate E1:** cerrado. El tema está elegido y el contexto de construcción y evaluación es accesible por la tesista.

## Riesgos registrados

1. La tesista declara no haber entrenado modelos predictivos; el enunciado original del tema prometía aprendizaje automático. La promesa se retira del título y la técnica se decide en E7a.
2. Las irregularidades por consumo se corrigen antes de facturar. Si la corrección sobrescribe el valor original, no existe verdad de referencia para evaluar la detección. Debe verificarse antes de fijar indicadores en E6.
3. Calendario de nueve semanas con dos ciclos de evaluación obligatorios.
