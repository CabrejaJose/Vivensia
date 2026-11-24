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
      zero: 'Sin tareas pendientes',
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
      zero: 'Sin productos',
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

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get greetingSubtitle => 'Hagamos de hoy un gran día.';

  @override
  String get myHousehold => 'Mi hogar';

  @override
  String get demoHouseholdName => 'Hogar de ejemplo';

  @override
  String get householdSwitcherHint => 'Cambiar de hogar';

  @override
  String get householdSheetTitle => 'Tus hogares';

  @override
  String get householdSheetMessage =>
      'Pronto podrás crear hogares, invitar a tu familia y cambiar entre ellos.';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get todayEyebrow => 'Tu hogar hoy';

  @override
  String get todayAllGood => 'Todo bajo control';

  @override
  String get statTasks => 'Tareas';

  @override
  String get statShopping => 'Compras';

  @override
  String get statEvents => 'Eventos';

  @override
  String statSemantics(String label, int count) {
    return '$label: $count';
  }

  @override
  String get organizeYourHome => 'Organiza tu hogar';

  @override
  String get moduleCleaning => 'Limpieza';

  @override
  String get moduleFinances => 'Finanzas';

  @override
  String get moduleShopping => 'Compras';

  @override
  String get modulePantry => 'Despensa';

  @override
  String get moduleCalendar => 'Calendario';

  @override
  String get moduleRecipes => 'Recetas y menús';

  @override
  String get moduleMaintenance => 'Mantenimiento';

  @override
  String get moduleDocuments => 'Documentos';

  @override
  String get moduleFamily => 'Mi familia';

  @override
  String get moduleAssistant => 'Asistente inteligente';

  @override
  String get moduleSettings => 'Configuración';

  @override
  String get recipesSubtitle => 'Menú semanal';

  @override
  String get documentsSubtitle => 'Tus archivos';

  @override
  String demoUpcomingEvents(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos próximos',
      one: '1 evento próximo',
      zero: 'Sin eventos próximos',
    );
    return '$_temp0';
  }

  @override
  String demoUpcomingMaintenance(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count revisiones próximas',
      one: '1 revisión próxima',
      zero: 'Sin revisiones próximas',
    );
    return '$_temp0';
  }

  @override
  String demoFamilyMembers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count integrantes',
      one: '1 integrante',
    );
    return '$_temp0';
  }

  @override
  String get assistantPrompt => '¿Qué necesitas organizar hoy?';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get comingSoonMessage =>
      'Estamos preparando esta sección para que organizar tu hogar sea aún más fácil.';

  @override
  String get tasksPlaceholderTitle => 'Aquí verás las tareas del hogar';

  @override
  String get shoppingPlaceholderTitle => 'Aquí verás tus listas de compras';

  @override
  String get agendaPlaceholderTitle => 'Aquí verás los eventos del hogar';

  @override
  String get moreFeatures => 'Funciones';

  @override
  String get moreAppearance => 'Apariencia';

  @override
  String get moreDevelopment => 'Desarrollo';

  @override
  String get welcomeTitle => 'Tu hogar, en armonía';

  @override
  String get welcomeSubtitle =>
      'Limpieza, compras, finanzas y agenda familiar en un solo lugar.';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get haveAccount => 'Ya tengo cuenta';

  @override
  String get signInTitle => 'Inicia sesión';

  @override
  String get signInSubtitle => 'Qué bueno verte de nuevo.';

  @override
  String get signInAction => 'Iniciar sesión';

  @override
  String get signingIn => 'Iniciando sesión…';

  @override
  String get forgotPasswordLink => '¿Olvidaste tu contraseña?';

  @override
  String get noAccountPrompt => '¿No tienes cuenta? Crear una';

  @override
  String get signUpTitle => 'Crea tu cuenta';

  @override
  String get signUpSubtitle => 'Empieza a organizar tu hogar en minutos.';

  @override
  String get signUpAction => 'Crear cuenta';

  @override
  String get signingUp => 'Creando cuenta…';

  @override
  String get haveAccountPrompt => '¿Ya tienes cuenta? Inicia sesión';

  @override
  String get displayNameLabel => 'Tu nombre';

  @override
  String get displayNameHelper => 'Así te verá tu familia en Vivensia.';

  @override
  String passwordRulesHelper(int min) {
    return 'Mínimo $min caracteres, con letras y números.';
  }

  @override
  String get confirmEmailTitle => 'Revisa tu correo';

  @override
  String get confirmEmailMessage =>
      'Si la dirección es correcta, te enviamos un enlace para confirmar tu cuenta. Después podrás iniciar sesión.';

  @override
  String get backToSignIn => 'Volver a iniciar sesión';

  @override
  String get forgotPasswordTitle => 'Recupera tu contraseña';

  @override
  String get forgotPasswordSubtitle =>
      'Te enviaremos un enlace para crear una nueva.';

  @override
  String get sendResetLink => 'Enviar enlace';

  @override
  String get sendingResetLink => 'Enviando…';

  @override
  String get resetLinkSentMessage =>
      'Si existe una cuenta con ese correo, recibirás un enlace en unos minutos.';

  @override
  String get errorEmailRequired => 'Introduce tu correo electrónico';

  @override
  String get errorEmailInvalid => 'Introduce un correo válido';

  @override
  String get errorPasswordRequired => 'Introduce tu contraseña';

  @override
  String errorPasswordTooShort(int min) {
    return 'Debe tener al menos $min caracteres';
  }

  @override
  String get errorPasswordNeedsLetter => 'Debe incluir al menos una letra';

  @override
  String get errorPasswordNeedsDigit => 'Debe incluir al menos un número';

  @override
  String get errorNameRequired => 'Introduce tu nombre';

  @override
  String errorNameTooLong(int max) {
    return 'Máximo $max caracteres';
  }

  @override
  String get authErrorInvalidCredentials => 'Correo o contraseña incorrectos.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirma tu correo con el enlace que te enviamos antes de iniciar sesión.';

  @override
  String get authErrorEmailInUse =>
      'Ya existe una cuenta con ese correo. Inicia sesión o recupera tu contraseña.';

  @override
  String get authErrorWeakPassword =>
      'Esa contraseña es demasiado débil. Prueba con una más larga.';

  @override
  String get authErrorInvalidEmail => 'Revisa el correo electrónico.';

  @override
  String get authErrorRateLimited =>
      'Demasiados intentos. Espera unos minutos e inténtalo de nuevo.';

  @override
  String get authErrorSignupDisabled =>
      'El registro no está disponible en este momento.';

  @override
  String get authErrorNetwork =>
      'No hay conexión. Revisa tu internet e inténtalo de nuevo.';

  @override
  String get authErrorUnexpected => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get moreAccount => 'Cuenta';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signOutConfirmTitle => '¿Cerrar sesión?';

  @override
  String get signOutConfirmMessage =>
      'Podrás volver a entrar con tu correo y contraseña.';

  @override
  String get demoModeTitle => 'Modo demostración';

  @override
  String get demoModeMessage =>
      'No hay servidor configurado: la app muestra datos de ejemplo y no requiere cuenta.';
}
