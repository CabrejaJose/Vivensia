import 'package:flutter/painting.dart';

/// Sombras suaves y cálidas. Vivensia prefiere superficies planas con
/// bordes sutiles; la elevación se reserva para elementos flotantes.
abstract final class VivElevation {
  static const List<BoxShadow> none = [];

  static const List<BoxShadow> low = [
    BoxShadow(color: Color(0x0F27352E), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(color: Color(0x1427352E), blurRadius: 20, offset: Offset(0, 6)),
  ];

  static const List<BoxShadow> high = [
    BoxShadow(color: Color(0x1F27352E), blurRadius: 32, offset: Offset(0, 12)),
  ];
}
