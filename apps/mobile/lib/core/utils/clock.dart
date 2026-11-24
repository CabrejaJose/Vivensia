import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fuente de la hora actual. Se sobrescribe en pruebas para controlar el tiempo.
typedef Clock = DateTime Function();

final clockProvider = Provider<Clock>((ref) => DateTime.now);
