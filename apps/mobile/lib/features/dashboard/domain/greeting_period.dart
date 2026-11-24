/// Franja del día usada para el saludo.
enum GreetingPeriod { morning, afternoon, evening }

/// 05:00–11:59 mañana · 12:00–18:59 tarde · resto noche.
GreetingPeriod greetingPeriodOf(DateTime time) {
  final h = time.hour;
  if (h >= 5 && h < 12) return GreetingPeriod.morning;
  if (h >= 12 && h < 19) return GreetingPeriod.afternoon;
  return GreetingPeriod.evening;
}
