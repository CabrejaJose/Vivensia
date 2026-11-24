// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Vivensia';

  @override
  String get tagline => 'Organiza menos. Vive más.';

  @override
  String get routeNotFoundTitle => 'No encontramos esta página';

  @override
  String get goHome => 'Ir al inicio';

  @override
  String get openShowcase => 'Ver sistema de diseño';

  @override
  String get showcaseTitle => 'Sistema de diseño';

  @override
  String get showcaseDemoData => 'Datos de ejemplo';

  @override
  String get themeLabel => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get sectionColors => 'Colores';

  @override
  String get sectionTypography => 'Tipografía';

  @override
  String get sectionButtons => 'Botones';

  @override
  String get sectionInputs => 'Campos de texto';

  @override
  String get sectionCards => 'Tarjetas';

  @override
  String get sectionBadges => 'Etiquetas';

  @override
  String get sectionSelectors => 'Selectores';

  @override
  String get sectionProgress => 'Progreso';

  @override
  String get sectionLists => 'Listas';

  @override
  String get sectionOverlays => 'Diálogos y hojas';

  @override
  String get sectionStates => 'Estados';

  @override
  String get sectionSkeleton => 'Marcadores de carga';

  @override
  String get colorPrimary => 'Primario';

  @override
  String get colorSecondary => 'Secundario';

  @override
  String get colorTertiary => 'Terciario';

  @override
  String get colorGold => 'Dorado';

  @override
  String get colorSuccess => 'Éxito';

  @override
  String get colorWarning => 'Aviso';

  @override
  String get colorError => 'Error';

  @override
  String get colorInfo => 'Información';

  @override
  String get buttonPrimary => 'Acción principal';

  @override
  String get buttonSecondary => 'Secundaria';

  @override
  String get buttonTertiary => 'Terciaria';

  @override
  String get buttonLoading => 'Guardando…';

  @override
  String get buttonDisabled => 'No disponible';

  @override
  String get fieldEmailLabel => 'Correo electrónico';

  @override
  String get fieldEmailHint => 'nombre@ejemplo.com';

  @override
  String get fieldEmailHelper => 'Lo usaremos para iniciar sesión';

  @override
  String get fieldEmailError => 'Introduce un correo válido';

  @override
  String get fieldPasswordLabel => 'Contraseña';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get demoCleaningTitle => 'Limpieza';

  @override
  String demoPendingTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tareas pendientes',
      one: '1 tarea pendiente',
    );
    return '$_temp0';
  }

  @override
  String get demoBudgetTitle => 'Presupuesto mensual';

  @override
  String demoPercentUsed(int percent) {
    return '$percent % usado';
  }

  @override
  String get demoShoppingTitle => 'Compras';

  @override
  String demoProducts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count productos',
      one: '1 producto',
    );
    return '$_temp0';
  }

  @override
  String get badgeDone => 'Hecho';

  @override
  String get badgeDueSoon => 'Pronto';

  @override
  String get badgeOverdue => 'Atrasada';

  @override
  String get badgeNew => 'Nuevo';

  @override
  String get badgeAchievement => 'Logro';

  @override
  String get badgeShared => 'Compartido';

  @override
  String get badgeInfo => 'Novedad';

  @override
  String get roomKitchen => 'Cocina';

  @override
  String get roomBathroom => 'Baño';

  @override
  String get roomLivingRoom => 'Sala';

  @override
  String get roomBedroom => 'Dormitorio';

  @override
  String get periodDay => 'Día';

  @override
  String get periodWeek => 'Semana';

  @override
  String get periodMonth => 'Mes';

  @override
  String get openDialog => 'Abrir diálogo';

  @override
  String get openSheet => 'Abrir hoja inferior';

  @override
  String get dialogDeleteTaskTitle => '¿Eliminar tarea?';

  @override
  String get dialogDeleteTaskMessage => 'Esta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get save => 'Guardar';

  @override
  String get sheetNewTaskTitle => 'Nueva tarea';

  @override
  String get sheetTaskNameLabel => 'Nombre de la tarea';

  @override
  String get emptyTasksTitle => 'Aún no hay tareas';

  @override
  String get emptyTasksMessage =>
      'Crea tu primera tarea para empezar a organizar tu hogar.';

  @override
  String get emptyTasksAction => 'Crear tarea';

  @override
  String get errorGenericTitle => 'Algo salió mal';

  @override
  String get errorGenericMessage =>
      'No pudimos cargar la información. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get retry => 'Reintentar';

  @override
  String get loading => 'Cargando…';

  @override
  String get navHome => 'Inicio';

  @override
  String get navTasks => 'Tareas';

  @override
  String get navShopping => 'Compras';

  @override
  String get navAgenda => 'Agenda';

  @override
  String get navMore => 'Más';
}
