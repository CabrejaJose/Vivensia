import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// Guarda las capturas de las pruebas de integración en
/// build/integration_screenshots/.
Future<void> main() => integrationDriver(
  onScreenshot: (name, image, [args]) async {
    final file = File('build/integration_screenshots/$name.png');
    await file.create(recursive: true);
    await file.writeAsBytes(image);
    return true;
  },
);
