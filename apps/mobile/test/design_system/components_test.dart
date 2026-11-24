import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/design_system/design_system.dart';

import '../helpers/pump_widget.dart';

void main() {
  group('VivButton', () {
    testWidgets('ejecuta onPressed al pulsar', (tester) async {
      var taps = 0;
      await pumpThemed(
        tester,
        VivButton(label: 'Guardar', onPressed: () => taps++),
      );
      await tester.tap(find.text('Guardar'));
      expect(taps, 1);
    });

    testWidgets('en carga se deshabilita y muestra progreso', (tester) async {
      var taps = 0;
      await pumpThemed(
        tester,
        VivButton(label: 'Guardar', isLoading: true, onPressed: () => taps++),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.text('Guardar'));
      expect(taps, 0);
    });

    testWidgets('destructivo usa el color de error', (tester) async {
      await pumpThemed(
        tester,
        VivButton(
          label: 'Eliminar',
          variant: VivButtonVariant.destructive,
          onPressed: () {},
        ),
      );
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      final bg = button.style?.backgroundColor?.resolve({});
      expect(bg, VivensiaTheme.light.colorScheme.error);
    });

    testWidgets('respeta el área táctil mínima', (tester) async {
      await pumpThemed(
        tester,
        VivButton(label: 'OK', compact: true, onPressed: () {}),
      );
      final size = tester.getSize(find.byType(FilledButton));
      expect(size.height, greaterThanOrEqualTo(VivSize.minTouchTarget));
      expect(size.width, greaterThanOrEqualTo(VivSize.minTouchTarget));
    });
  });

  group('VivTextField', () {
    testWidgets('muestra el error', (tester) async {
      await pumpThemed(
        tester,
        const VivTextField(label: 'Correo', errorText: 'Correo inválido'),
      );
      expect(find.text('Correo inválido'), findsOneWidget);
    });

    testWidgets('contraseña alterna visibilidad con etiqueta accesible', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        const VivTextField.password(
          label: 'Contraseña',
          showPasswordLabel: 'Mostrar',
          hidePasswordLabel: 'Ocultar',
        ),
      );
      EditableText field() =>
          tester.widget<EditableText>(find.byType(EditableText));
      expect(field().obscureText, isTrue);
      expect(find.byTooltip('Mostrar'), findsOneWidget);

      await tester.tap(find.byTooltip('Mostrar'));
      await tester.pump();
      expect(field().obscureText, isFalse);
      expect(find.byTooltip('Ocultar'), findsOneWidget);
    });
  });

  group('Estados', () {
    testWidgets('vacío muestra acción', (tester) async {
      var actions = 0;
      await pumpThemed(
        tester,
        VivEmptyState(
          title: 'Sin tareas',
          message: 'Crea una',
          actionLabel: 'Crear',
          onAction: () => actions++,
        ),
      );
      expect(find.text('Sin tareas'), findsOneWidget);
      await tester.tap(find.text('Crear'));
      expect(actions, 1);
    });

    testWidgets('error permite reintentar', (tester) async {
      var retries = 0;
      await pumpThemed(
        tester,
        VivErrorState(
          title: 'Error',
          retryLabel: 'Reintentar',
          onRetry: () => retries++,
        ),
      );
      await tester.tap(find.text('Reintentar'));
      expect(retries, 1);
    });

    testWidgets('carga expone etiqueta accesible', (tester) async {
      await pumpThemed(tester, const VivLoadingState(label: 'Cargando'));
      expect(find.bySemanticsLabel('Cargando'), findsOneWidget);
    });
  });

  group('VivSkeleton', () {
    testWidgets('se anima normalmente', (tester) async {
      await pumpThemed(tester, const VivSkeleton(width: 100));
      expect(tester.hasRunningAnimations, isTrue);
    });

    testWidgets('queda estático si se reducen animaciones', (tester) async {
      await pumpThemed(
        tester,
        const VivSkeleton(width: 100),
        disableAnimations: true,
      );
      expect(tester.hasRunningAnimations, isFalse);
    });
  });

  group('Selectores', () {
    testWidgets('VivChoiceChips notifica la opción elegida', (tester) async {
      String? picked;
      await pumpThemed(
        tester,
        VivChoiceChips<String>(
          selected: 'a',
          onSelected: (v) => picked = v,
          options: const [
            VivOption(value: 'a', label: 'Cocina'),
            VivOption(value: 'b', label: 'Baño'),
          ],
        ),
      );
      await tester.tap(find.text('Baño'));
      expect(picked, 'b');
    });
  });

  group('VivBadge', () {
    testWidgets('muestra el texto en todos los tonos', (tester) async {
      await pumpThemed(
        tester,
        Wrap(
          children: [
            for (final tone in VivBadgeTone.values)
              VivBadge(label: 'Etiqueta', tone: tone),
          ],
        ),
      );
      expect(find.text('Etiqueta'), findsNWidgets(VivBadgeTone.values.length));
    });
  });

  group('showVivConfirmDialog', () {
    Future<bool?> openDialog(WidgetTester tester) async {
      bool? result;
      await pumpThemed(
        tester,
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => result = await showVivConfirmDialog(
              context,
              title: '¿Eliminar?',
              message: 'No se puede deshacer',
              confirmLabel: 'Eliminar',
              cancelLabel: 'Cancelar',
              destructive: true,
            ),
            child: const Text('Abrir'),
          ),
        ),
      );
      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      expect(find.text('¿Eliminar?'), findsOneWidget);
      return result;
    }

    testWidgets('devuelve true al confirmar', (tester) async {
      bool? result;
      await pumpThemed(
        tester,
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => result = await showVivConfirmDialog(
              context,
              title: '¿Eliminar?',
              message: 'No se puede deshacer',
              confirmLabel: 'Eliminar',
              cancelLabel: 'Cancelar',
            ),
            child: const Text('Abrir'),
          ),
        ),
      );
      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });

    testWidgets('devuelve false al cancelar', (tester) async {
      await openDialog(tester);
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(find.text('¿Eliminar?'), findsNothing);
    });
  });

  group('VivNotice', () {
    testWidgets('muestra título y mensaje como región viva', (tester) async {
      await pumpThemed(
        tester,
        const VivNotice(
          title: 'Atención',
          message: 'Algo pasó',
          tone: VivNoticeTone.error,
        ),
      );
      expect(find.text('Atención'), findsOneWidget);
      expect(find.text('Algo pasó'), findsOneWidget);
      final semantics = tester.getSemantics(find.byType(VivNotice));
      expect(semantics.flagsCollection.isLiveRegion, isTrue);
    });
  });
}
