import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:vivensia/design_system/design_system.dart';
import 'package:vivensia/features/dashboard/data/repositories/demo_home_summary_repository.dart';
import 'package:vivensia/features/dashboard/domain/entities/home_summary.dart';
import 'package:vivensia/features/dashboard/domain/greeting_period.dart';
import 'package:vivensia/features/dashboard/domain/repositories/home_summary_repository.dart';
import 'package:vivensia/features/dashboard/presentation/screens/dashboard_screen.dart';

import '../../helpers/pump_app.dart';

class _FakeRepository implements HomeSummaryRepository {
  _FakeRepository(this.result);

  Future<HomeSummary> Function() result;
  int calls = 0;

  @override
  Future<HomeSummary> fetchSummary() {
    calls++;
    return result();
  }
}

const _realSummary = HomeSummary(
  householdName: 'Casa Pérez',
  pendingTasks: 0,
  shoppingItems: 5,
  upcomingEvents: 1,
  pantryItems: 0,
  upcomingMaintenance: 0,
  familyMembers: 2,
  isDemo: false,
);

void main() {
  group('greetingPeriodOf', () {
    test('límites de cada franja', () {
      GreetingPeriod at(int h, [int m = 0]) =>
          greetingPeriodOf(DateTime(2026, 1, 1, h, m));
      expect(at(4, 59), GreetingPeriod.evening);
      expect(at(5), GreetingPeriod.morning);
      expect(at(11, 59), GreetingPeriod.morning);
      expect(at(12), GreetingPeriod.afternoon);
      expect(at(18, 59), GreetingPeriod.afternoon);
      expect(at(19), GreetingPeriod.evening);
      expect(at(0), GreetingPeriod.evening);
    });
  });

  group('Saludo según la hora', () {
    for (final (hour, text) in [
      (8, 'Buenos días'),
      (15, 'Buenas tardes'),
      (22, 'Buenas noches'),
    ]) {
      testWidgets('$hour h → $text', (tester) async {
        await pumpVivensiaApp(tester, now: DateTime(2026, 11, 24, hour));
        expect(find.text(text), findsOneWidget);
      });
    }
  });

  group('Datos de ejemplo', () {
    testWidgets('se identifican claramente', (tester) async {
      await pumpVivensiaApp(tester);
      expect(find.widgetWithText(VivBadge, 'Datos de ejemplo'), findsOneWidget);
      expect(find.text('Hogar de ejemplo'), findsOneWidget);
    });

    testWidgets('muestra los contadores del resumen', (tester) async {
      await pumpVivensiaApp(tester);
      expect(find.bySemanticsLabel('Tareas: 3'), findsOneWidget);
      expect(find.bySemanticsLabel('Compras: 8'), findsOneWidget);
      expect(find.bySemanticsLabel('Eventos: 2'), findsOneWidget);
    });

    testWidgets('el repositorio demo marca isDemo', (tester) async {
      final summary = await const DemoHomeSummaryRepository().fetchSummary();
      expect(summary.isDemo, isTrue);
    });
  });

  group('Datos reales', () {
    testWidgets('sin etiqueta de ejemplo y con el nombre del hogar', (
      tester,
    ) async {
      await pumpVivensiaApp(
        tester,
        overrides: [
          homeSummaryRepositoryProvider.overrideWithValue(
            _FakeRepository(() async => _realSummary),
          ),
        ],
      );
      expect(find.text('Casa Pérez'), findsOneWidget);
      expect(find.text('Datos de ejemplo'), findsNothing);
      expect(find.text('Sin tareas pendientes'), findsOneWidget);
    });
  });

  group('Estados', () {
    testWidgets('carga muestra skeleton', (tester) async {
      final never = Completer<HomeSummary>();
      await pumpVivensiaApp(
        tester,
        overrides: [
          homeSummaryRepositoryProvider.overrideWithValue(
            _FakeRepository(() => never.future),
          ),
        ],
      );
      expect(find.byType(VivSkeleton), findsWidgets);
      expect(find.text('Organiza tu hogar'), findsNothing);
    });

    testWidgets('error permite reintentar', (tester) async {
      var fail = true;
      final repo = _FakeRepository(() async {
        if (fail) throw Exception('sin conexión');
        return _realSummary;
      });
      await pumpVivensiaApp(
        tester,
        overrides: [homeSummaryRepositoryProvider.overrideWithValue(repo)],
      );
      expect(find.text('Algo salió mal'), findsOneWidget);
      expect(repo.calls, 1, reason: 'sin reintentos automáticos');

      fail = false;
      await tester.tap(find.text('Reintentar'));
      await settle(tester);
      expect(find.text('Casa Pérez'), findsOneWidget);
    });
  });

  group('Navegación desde Inicio', () {
    testWidgets('contador de tareas abre la pestaña Tareas', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(find.bySemanticsLabel('Tareas: 3'));
      await settle(tester);
      expect(find.text('Aquí verás las tareas del hogar'), findsOneWidget);
    });

    testWidgets('tarjeta Finanzas abre "Próximamente"', (tester) async {
      await pumpVivensiaApp(tester);
      await tapInScreen<DashboardScreen>(tester, 'Finanzas');
      expect(find.text('Próximamente'), findsOneWidget);
    });

    testWidgets('tarjeta Compras abre la pestaña Compras', (tester) async {
      await pumpVivensiaApp(tester);
      await tapInScreen<DashboardScreen>(tester, '8 productos');
      expect(find.text('Aquí verás tus listas de compras'), findsOneWidget);
    });

    testWidgets('asistente abre "Próximamente"', (tester) async {
      await pumpVivensiaApp(tester);
      await tapInScreen<DashboardScreen>(tester, 'Asistente inteligente');
      expect(find.text('Próximamente'), findsOneWidget);
    });

    testWidgets('notificaciones abre "Próximamente"', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(find.byTooltip('Notificaciones'));
      await settle(tester);
      expect(find.text('Notificaciones'), findsWidgets);
      expect(find.text('Próximamente'), findsOneWidget);
    });

    testWidgets('selector de hogar abre la hoja de hogares', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(find.text('Hogar de ejemplo'));
      await settle(tester);
      expect(find.text('Tus hogares'), findsOneWidget);
    });
  });
}
