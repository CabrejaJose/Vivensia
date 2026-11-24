import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/navigation/app_module.dart';
import 'package:vivensia/app/navigation/more_screen.dart';
import 'package:vivensia/app/router/app_router.dart';
import 'package:vivensia/app/router/app_routes.dart';
import 'package:vivensia/design_system/design_system.dart';

import '../helpers/pump_app.dart';

Finder navItem(String label) =>
    find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

void main() {
  group('Barra inferior', () {
    testWidgets('tiene los cinco destinos en orden', (tester) async {
      await pumpVivensiaApp(tester);
      final labels = tester
          .widgetList<NavigationDestination>(find.byType(NavigationDestination))
          .map((d) => d.label)
          .toList();
      expect(labels, ['Inicio', 'Tareas', 'Compras', 'Agenda', 'Más']);
    });

    testWidgets('cada pestaña muestra su pantalla', (tester) async {
      await pumpVivensiaApp(tester);

      await tester.tap(navItem('Tareas'));
      await settle(tester);
      expect(find.text('Aquí verás las tareas del hogar'), findsOneWidget);

      await tester.tap(navItem('Compras'));
      await settle(tester);
      expect(find.text('Aquí verás tus listas de compras'), findsOneWidget);

      await tester.tap(navItem('Agenda'));
      await settle(tester);
      expect(find.text('Aquí verás los eventos del hogar'), findsOneWidget);

      await tester.tap(navItem('Más'));
      await settle(tester);
      expect(find.text('Funciones'), findsOneWidget);

      await tester.tap(navItem('Inicio'));
      await settle(tester);
      expect(find.text('Buenos días'), findsOneWidget);
    });

    testWidgets('marca la pestaña seleccionada', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(navItem('Agenda'));
      await settle(tester);
      final bar = tester.widget<NavigationBar>(find.byType(NavigationBar));
      expect(bar.selectedIndex, 3);
    });
  });

  group('Más', () {
    testWidgets('abre una función futura como "Próximamente" y vuelve', (
      tester,
    ) async {
      await pumpVivensiaApp(tester);
      await tester.tap(navItem('Más'));
      await settle(tester);

      await tapInScreen<MoreScreen>(tester, 'Finanzas');
      expect(find.text('Próximamente'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.byType(BackButton));
      await settle(tester);
      expect(find.text('Funciones'), findsOneWidget);
    });

    testWidgets('Limpieza lleva a la pestaña Tareas', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(navItem('Más'));
      await settle(tester);
      await tapInScreen<MoreScreen>(tester, 'Limpieza');
      expect(find.text('Aquí verás las tareas del hogar'), findsOneWidget);
    });

    testWidgets('cambia el tema a oscuro', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(navItem('Más'));
      await settle(tester);
      await tapInScreen<MoreScreen>(tester, 'Oscuro');
      expect(containerOf(tester).read(themeModeProvider), ThemeMode.dark);
      expect(
        Theme.of(tester.element(find.text('Funciones'))).brightness,
        Brightness.dark,
      );
    });

    testWidgets('abre el sistema de diseño en desarrollo', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(navItem('Más'));
      await settle(tester);
      await tapInScreen<MoreScreen>(tester, 'Ver sistema de diseño');
      expect(find.text('Sistema de diseño'), findsWidgets);
    });
  });

  group('Rutas de funciones', () {
    testWidgets('cada función futura tiene pantalla "Próximamente"', (
      tester,
    ) async {
      await pumpVivensiaApp(tester);
      final router = containerOf(tester).read(appRouterProvider);
      for (final m in AppModule.values.where((m) => m.tabRoute == null)) {
        router.go(AppRoutes.module(m.id));
        await settle(tester);
        expect(find.text('Próximamente'), findsOneWidget, reason: m.id);
      }
    });

    testWidgets('enlace directo a una función permite volver a Inicio', (
      tester,
    ) async {
      await pumpVivensiaApp(tester);
      containerOf(tester).read(appRouterProvider).go('/module/pantry');
      await settle(tester);
      await tester.tap(find.byTooltip('Ir al inicio'));
      await settle(tester);
      expect(find.text('Buenos días'), findsOneWidget);
    });

    testWidgets('función inexistente muestra error', (tester) async {
      await pumpVivensiaApp(tester);
      containerOf(tester).read(appRouterProvider).go('/module/no-existe');
      await settle(tester);
      expect(find.text('No encontramos esta página'), findsOneWidget);
    });
  });

  test('AppModule.fromId', () {
    expect(AppModule.fromId('finances'), AppModule.finances);
    expect(AppModule.fromId('x'), isNull);
    expect(AppModule.fromId(null), isNull);
  });
}
