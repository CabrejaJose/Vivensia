# Visión de producto

**Vivensia — Organiza menos. Vive más.**

## Problema
Los hogares gestionan limpieza, dinero, compras, comida, agenda y papeles
con 5–10 apps desconectadas. La misma información se escribe varias veces
y la carga doméstica se reparte de forma invisible y desigual.

## Propuesta
Una sola app cálida y premium que integra esas herramientas y, sobre todo,
**las conecta**: una receta planificada revisa la despensa, añade lo que
falta a la lista, estima el coste contra el presupuesto, y el recibo
confirmado registra el gasto y actualiza el inventario.

## Público
Personas solas, parejas, familias y compañeros de piso. Uno o varios hogares por usuario.

## Módulos del producto completo
| Módulo | Núcleo |
|---|---|
| Limpieza | Habitaciones, tareas recurrentes, indicador de necesidad, rotación, historial, mascota original |
| Finanzas | Ingresos/gastos, presupuestos, cuentas personales y compartidas, división de gastos, suscripciones, metas |
| Compras | Listas colaborativas en tiempo real, pasillos, frecuentes, código de barras, tarjetas de fidelidad, coste estimado |
| Despensa | Inventario, lotes, caducidad, stock bajo, historial de precios, actualización por recibo confirmado |
| Calendario | Personales y compartidos, recurrencia, recordatorios, comentarios, vistas día/semana/mes |
| Recetas y menús | Recetario, importación por URL, porciones, plan semanal, recetas según despensa, lista de compras |
| Mantenimiento | Electrodomésticos, vehículos, preventivo, garantías, reparaciones, proveedores |
| Documentos | Contratos, pólizas, facturas, Wi-Fi + QR, contactos de emergencia, permisos por documento |
| Familia | Invitaciones, roles, reparto equilibrado, puntos y logros opcionales (nunca punitivos) |
| Asistente | Texto y voz, OCR de recibos, sugerencias, resúmenes; siempre con confirmación |

## Automatizaciones clave
- **A.** Recetas → Despensa → Compras → Finanzas (una estimación nunca es un gasto real).
- **B.** Recibo → revisión → confirmación → Finanzas + Despensa (sin inventar fechas ni cantidades).
- **C.** Mantenimiento ↔ Calendario ↔ Documentos.
- **D.** Tareas → Responsabilidades → Gamificación.

Todas se apoyan en eventos de dominio y operaciones **idempotentes**.

## Principios
1. Una sola app, una sola identidad.
2. Introducir cada dato una sola vez.
3. Privacidad y seguridad desde el diseño.
4. Funciona sin IA; la IA ayuda, no decide.
5. Calidez sobre complejidad: el dashboard no se sobrecarga.

## Pendiente de validar
- Disponibilidad legal de la marca "Vivensia" y del dominio `vivensia.app`/`vivensia.com`
  (afecta al identificador `com.vivensia.app`).
- Precios y límites del plan gratuito.
