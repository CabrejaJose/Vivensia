import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Nombre comercial de la app. No se traduce.
  ///
  /// In es, this message translates to:
  /// **'Vivensia'**
  String get appName;

  /// Eslogan de la marca.
  ///
  /// In es, this message translates to:
  /// **'Organiza menos. Vive más.'**
  String get tagline;

  /// Título cuando una ruta no existe.
  ///
  /// In es, this message translates to:
  /// **'No encontramos esta página'**
  String get routeNotFoundTitle;

  /// Botón para volver a la pantalla de inicio.
  ///
  /// In es, this message translates to:
  /// **'Ir al inicio'**
  String get goHome;

  /// Botón solo visible en builds de desarrollo.
  ///
  /// In es, this message translates to:
  /// **'Ver sistema de diseño'**
  String get openShowcase;

  /// No description provided for @showcaseTitle.
  ///
  /// In es, this message translates to:
  /// **'Sistema de diseño'**
  String get showcaseTitle;

  /// No description provided for @showcaseDemoData.
  ///
  /// In es, this message translates to:
  /// **'Datos de ejemplo'**
  String get showcaseDemoData;

  /// No description provided for @themeLabel.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get themeLabel;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @sectionColors.
  ///
  /// In es, this message translates to:
  /// **'Colores'**
  String get sectionColors;

  /// No description provided for @sectionTypography.
  ///
  /// In es, this message translates to:
  /// **'Tipografía'**
  String get sectionTypography;

  /// No description provided for @sectionButtons.
  ///
  /// In es, this message translates to:
  /// **'Botones'**
  String get sectionButtons;

  /// No description provided for @sectionInputs.
  ///
  /// In es, this message translates to:
  /// **'Campos de texto'**
  String get sectionInputs;

  /// No description provided for @sectionCards.
  ///
  /// In es, this message translates to:
  /// **'Tarjetas'**
  String get sectionCards;

  /// No description provided for @sectionBadges.
  ///
  /// In es, this message translates to:
  /// **'Etiquetas'**
  String get sectionBadges;

  /// No description provided for @sectionSelectors.
  ///
  /// In es, this message translates to:
  /// **'Selectores'**
  String get sectionSelectors;

  /// No description provided for @sectionProgress.
  ///
  /// In es, this message translates to:
  /// **'Progreso'**
  String get sectionProgress;

  /// No description provided for @sectionLists.
  ///
  /// In es, this message translates to:
  /// **'Listas'**
  String get sectionLists;

  /// No description provided for @sectionOverlays.
  ///
  /// In es, this message translates to:
  /// **'Diálogos y hojas'**
  String get sectionOverlays;

  /// No description provided for @sectionStates.
  ///
  /// In es, this message translates to:
  /// **'Estados'**
  String get sectionStates;

  /// No description provided for @sectionSkeleton.
  ///
  /// In es, this message translates to:
  /// **'Marcadores de carga'**
  String get sectionSkeleton;

  /// No description provided for @colorPrimary.
  ///
  /// In es, this message translates to:
  /// **'Primario'**
  String get colorPrimary;

  /// No description provided for @colorSecondary.
  ///
  /// In es, this message translates to:
  /// **'Secundario'**
  String get colorSecondary;

  /// No description provided for @colorTertiary.
  ///
  /// In es, this message translates to:
  /// **'Terciario'**
  String get colorTertiary;

  /// No description provided for @colorGold.
  ///
  /// In es, this message translates to:
  /// **'Dorado'**
  String get colorGold;

  /// No description provided for @colorSuccess.
  ///
  /// In es, this message translates to:
  /// **'Éxito'**
  String get colorSuccess;

  /// No description provided for @colorWarning.
  ///
  /// In es, this message translates to:
  /// **'Aviso'**
  String get colorWarning;

  /// No description provided for @colorError.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get colorError;

  /// No description provided for @colorInfo.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get colorInfo;

  /// No description provided for @buttonPrimary.
  ///
  /// In es, this message translates to:
  /// **'Acción principal'**
  String get buttonPrimary;

  /// No description provided for @buttonSecondary.
  ///
  /// In es, this message translates to:
  /// **'Secundaria'**
  String get buttonSecondary;

  /// No description provided for @buttonTertiary.
  ///
  /// In es, this message translates to:
  /// **'Terciaria'**
  String get buttonTertiary;

  /// No description provided for @buttonLoading.
  ///
  /// In es, this message translates to:
  /// **'Guardando…'**
  String get buttonLoading;

  /// No description provided for @buttonDisabled.
  ///
  /// In es, this message translates to:
  /// **'No disponible'**
  String get buttonDisabled;

  /// No description provided for @fieldEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get fieldEmailLabel;

  /// No description provided for @fieldEmailHint.
  ///
  /// In es, this message translates to:
  /// **'nombre@ejemplo.com'**
  String get fieldEmailHint;

  /// No description provided for @fieldEmailHelper.
  ///
  /// In es, this message translates to:
  /// **'Lo usaremos para iniciar sesión'**
  String get fieldEmailHelper;

  /// No description provided for @fieldEmailError.
  ///
  /// In es, this message translates to:
  /// **'Introduce un correo válido'**
  String get fieldEmailError;

  /// No description provided for @fieldPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get fieldPasswordLabel;

  /// No description provided for @showPassword.
  ///
  /// In es, this message translates to:
  /// **'Mostrar contraseña'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In es, this message translates to:
  /// **'Ocultar contraseña'**
  String get hidePassword;

  /// No description provided for @demoCleaningTitle.
  ///
  /// In es, this message translates to:
  /// **'Limpieza'**
  String get demoCleaningTitle;

  /// No description provided for @demoPendingTasks.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin tareas pendientes} =1{1 tarea pendiente} other{{count} tareas pendientes}}'**
  String demoPendingTasks(int count);

  /// No description provided for @demoBudgetTitle.
  ///
  /// In es, this message translates to:
  /// **'Presupuesto mensual'**
  String get demoBudgetTitle;

  /// No description provided for @demoPercentUsed.
  ///
  /// In es, this message translates to:
  /// **'{percent} % usado'**
  String demoPercentUsed(int percent);

  /// No description provided for @demoShoppingTitle.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get demoShoppingTitle;

  /// No description provided for @demoProducts.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin productos} =1{1 producto} other{{count} productos}}'**
  String demoProducts(int count);

  /// No description provided for @badgeDone.
  ///
  /// In es, this message translates to:
  /// **'Hecho'**
  String get badgeDone;

  /// No description provided for @badgeDueSoon.
  ///
  /// In es, this message translates to:
  /// **'Pronto'**
  String get badgeDueSoon;

  /// No description provided for @badgeOverdue.
  ///
  /// In es, this message translates to:
  /// **'Atrasada'**
  String get badgeOverdue;

  /// No description provided for @badgeNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevo'**
  String get badgeNew;

  /// No description provided for @badgeAchievement.
  ///
  /// In es, this message translates to:
  /// **'Logro'**
  String get badgeAchievement;

  /// No description provided for @badgeShared.
  ///
  /// In es, this message translates to:
  /// **'Compartido'**
  String get badgeShared;

  /// No description provided for @badgeInfo.
  ///
  /// In es, this message translates to:
  /// **'Novedad'**
  String get badgeInfo;

  /// No description provided for @roomKitchen.
  ///
  /// In es, this message translates to:
  /// **'Cocina'**
  String get roomKitchen;

  /// No description provided for @roomBathroom.
  ///
  /// In es, this message translates to:
  /// **'Baño'**
  String get roomBathroom;

  /// No description provided for @roomLivingRoom.
  ///
  /// In es, this message translates to:
  /// **'Sala'**
  String get roomLivingRoom;

  /// No description provided for @roomBedroom.
  ///
  /// In es, this message translates to:
  /// **'Dormitorio'**
  String get roomBedroom;

  /// No description provided for @periodDay.
  ///
  /// In es, this message translates to:
  /// **'Día'**
  String get periodDay;

  /// No description provided for @periodWeek.
  ///
  /// In es, this message translates to:
  /// **'Semana'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In es, this message translates to:
  /// **'Mes'**
  String get periodMonth;

  /// No description provided for @openDialog.
  ///
  /// In es, this message translates to:
  /// **'Abrir diálogo'**
  String get openDialog;

  /// No description provided for @openSheet.
  ///
  /// In es, this message translates to:
  /// **'Abrir hoja inferior'**
  String get openSheet;

  /// No description provided for @dialogDeleteTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar tarea?'**
  String get dialogDeleteTaskTitle;

  /// No description provided for @dialogDeleteTaskMessage.
  ///
  /// In es, this message translates to:
  /// **'Esta acción no se puede deshacer.'**
  String get dialogDeleteTaskMessage;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @sheetNewTaskTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva tarea'**
  String get sheetNewTaskTitle;

  /// No description provided for @sheetTaskNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre de la tarea'**
  String get sheetTaskNameLabel;

  /// No description provided for @emptyTasksTitle.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay tareas'**
  String get emptyTasksTitle;

  /// No description provided for @emptyTasksMessage.
  ///
  /// In es, this message translates to:
  /// **'Crea tu primera tarea para empezar a organizar tu hogar.'**
  String get emptyTasksMessage;

  /// No description provided for @emptyTasksAction.
  ///
  /// In es, this message translates to:
  /// **'Crear tarea'**
  String get emptyTasksAction;

  /// No description provided for @errorGenericTitle.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal'**
  String get errorGenericTitle;

  /// No description provided for @errorGenericMessage.
  ///
  /// In es, this message translates to:
  /// **'No pudimos cargar la información. Revisa tu conexión e inténtalo de nuevo.'**
  String get errorGenericMessage;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando…'**
  String get loading;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navTasks.
  ///
  /// In es, this message translates to:
  /// **'Tareas'**
  String get navTasks;

  /// No description provided for @navShopping.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get navShopping;

  /// No description provided for @navAgenda.
  ///
  /// In es, this message translates to:
  /// **'Agenda'**
  String get navAgenda;

  /// No description provided for @navMore.
  ///
  /// In es, this message translates to:
  /// **'Más'**
  String get navMore;

  /// No description provided for @greetingMorning.
  ///
  /// In es, this message translates to:
  /// **'Buenos días'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In es, this message translates to:
  /// **'Buenas tardes'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In es, this message translates to:
  /// **'Buenas noches'**
  String get greetingEvening;

  /// No description provided for @greetingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Hagamos de hoy un gran día.'**
  String get greetingSubtitle;

  /// No description provided for @myHousehold.
  ///
  /// In es, this message translates to:
  /// **'Mi hogar'**
  String get myHousehold;

  /// No description provided for @demoHouseholdName.
  ///
  /// In es, this message translates to:
  /// **'Hogar de ejemplo'**
  String get demoHouseholdName;

  /// No description provided for @householdSwitcherHint.
  ///
  /// In es, this message translates to:
  /// **'Cambiar de hogar'**
  String get householdSwitcherHint;

  /// No description provided for @householdSheetTitle.
  ///
  /// In es, this message translates to:
  /// **'Tus hogares'**
  String get householdSheetTitle;

  /// No description provided for @householdSheetMessage.
  ///
  /// In es, this message translates to:
  /// **'Pronto podrás crear hogares, invitar a tu familia y cambiar entre ellos.'**
  String get householdSheetMessage;

  /// No description provided for @notifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notifications;

  /// No description provided for @todayEyebrow.
  ///
  /// In es, this message translates to:
  /// **'Tu hogar hoy'**
  String get todayEyebrow;

  /// No description provided for @todayAllGood.
  ///
  /// In es, this message translates to:
  /// **'Todo bajo control'**
  String get todayAllGood;

  /// No description provided for @statTasks.
  ///
  /// In es, this message translates to:
  /// **'Tareas'**
  String get statTasks;

  /// No description provided for @statShopping.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get statShopping;

  /// No description provided for @statEvents.
  ///
  /// In es, this message translates to:
  /// **'Eventos'**
  String get statEvents;

  /// No description provided for @statSemantics.
  ///
  /// In es, this message translates to:
  /// **'{label}: {count}'**
  String statSemantics(String label, int count);

  /// No description provided for @organizeYourHome.
  ///
  /// In es, this message translates to:
  /// **'Organiza tu hogar'**
  String get organizeYourHome;

  /// No description provided for @moduleCleaning.
  ///
  /// In es, this message translates to:
  /// **'Limpieza'**
  String get moduleCleaning;

  /// No description provided for @moduleFinances.
  ///
  /// In es, this message translates to:
  /// **'Finanzas'**
  String get moduleFinances;

  /// No description provided for @moduleShopping.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get moduleShopping;

  /// No description provided for @modulePantry.
  ///
  /// In es, this message translates to:
  /// **'Despensa'**
  String get modulePantry;

  /// No description provided for @moduleCalendar.
  ///
  /// In es, this message translates to:
  /// **'Calendario'**
  String get moduleCalendar;

  /// No description provided for @moduleRecipes.
  ///
  /// In es, this message translates to:
  /// **'Recetas y menús'**
  String get moduleRecipes;

  /// No description provided for @moduleMaintenance.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento'**
  String get moduleMaintenance;

  /// No description provided for @moduleDocuments.
  ///
  /// In es, this message translates to:
  /// **'Documentos'**
  String get moduleDocuments;

  /// No description provided for @moduleFamily.
  ///
  /// In es, this message translates to:
  /// **'Mi familia'**
  String get moduleFamily;

  /// No description provided for @moduleAssistant.
  ///
  /// In es, this message translates to:
  /// **'Asistente inteligente'**
  String get moduleAssistant;

  /// No description provided for @moduleSettings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get moduleSettings;

  /// No description provided for @recipesSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Menú semanal'**
  String get recipesSubtitle;

  /// No description provided for @documentsSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Tus archivos'**
  String get documentsSubtitle;

  /// No description provided for @demoUpcomingEvents.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin eventos próximos} =1{1 evento próximo} other{{count} eventos próximos}}'**
  String demoUpcomingEvents(int count);

  /// No description provided for @demoUpcomingMaintenance.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin revisiones próximas} =1{1 revisión próxima} other{{count} revisiones próximas}}'**
  String demoUpcomingMaintenance(int count);

  /// No description provided for @demoFamilyMembers.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 integrante} other{{count} integrantes}}'**
  String demoFamilyMembers(int count);

  /// No description provided for @assistantPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿Qué necesitas organizar hoy?'**
  String get assistantPrompt;

  /// No description provided for @comingSoon.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get comingSoon;

  /// No description provided for @comingSoonMessage.
  ///
  /// In es, this message translates to:
  /// **'Estamos preparando esta sección para que organizar tu hogar sea aún más fácil.'**
  String get comingSoonMessage;

  /// No description provided for @tasksPlaceholderTitle.
  ///
  /// In es, this message translates to:
  /// **'Aquí verás las tareas del hogar'**
  String get tasksPlaceholderTitle;

  /// No description provided for @shoppingPlaceholderTitle.
  ///
  /// In es, this message translates to:
  /// **'Aquí verás tus listas de compras'**
  String get shoppingPlaceholderTitle;

  /// No description provided for @agendaPlaceholderTitle.
  ///
  /// In es, this message translates to:
  /// **'Aquí verás los eventos del hogar'**
  String get agendaPlaceholderTitle;

  /// No description provided for @moreFeatures.
  ///
  /// In es, this message translates to:
  /// **'Funciones'**
  String get moreFeatures;

  /// No description provided for @moreAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get moreAppearance;

  /// No description provided for @moreDevelopment.
  ///
  /// In es, this message translates to:
  /// **'Desarrollo'**
  String get moreDevelopment;

  /// No description provided for @welcomeTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu hogar, en armonía'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Limpieza, compras, finanzas y agenda familiar en un solo lugar.'**
  String get welcomeSubtitle;

  /// No description provided for @createAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get createAccount;

  /// No description provided for @haveAccount.
  ///
  /// In es, this message translates to:
  /// **'Ya tengo cuenta'**
  String get haveAccount;

  /// No description provided for @signInTitle.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get signInTitle;

  /// No description provided for @signInSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Qué bueno verte de nuevo.'**
  String get signInSubtitle;

  /// No description provided for @signInAction.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get signInAction;

  /// No description provided for @signingIn.
  ///
  /// In es, this message translates to:
  /// **'Iniciando sesión…'**
  String get signingIn;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPasswordLink;

  /// No description provided for @noAccountPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? Crear una'**
  String get noAccountPrompt;

  /// No description provided for @signUpTitle.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Empieza a organizar tu hogar en minutos.'**
  String get signUpSubtitle;

  /// No description provided for @signUpAction.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get signUpAction;

  /// No description provided for @signingUp.
  ///
  /// In es, this message translates to:
  /// **'Creando cuenta…'**
  String get signingUp;

  /// No description provided for @haveAccountPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta? Inicia sesión'**
  String get haveAccountPrompt;

  /// No description provided for @displayNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre'**
  String get displayNameLabel;

  /// No description provided for @displayNameHelper.
  ///
  /// In es, this message translates to:
  /// **'Así te verá tu familia en Vivensia.'**
  String get displayNameHelper;

  /// No description provided for @passwordRulesHelper.
  ///
  /// In es, this message translates to:
  /// **'Mínimo {min} caracteres, con letras y números.'**
  String passwordRulesHelper(int min);

  /// No description provided for @confirmEmailTitle.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu correo'**
  String get confirmEmailTitle;

  /// No description provided for @confirmEmailMessage.
  ///
  /// In es, this message translates to:
  /// **'Si la dirección es correcta, te enviamos un enlace para confirmar tu cuenta. Después podrás iniciar sesión.'**
  String get confirmEmailMessage;

  /// No description provided for @backToSignIn.
  ///
  /// In es, this message translates to:
  /// **'Volver a iniciar sesión'**
  String get backToSignIn;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Recupera tu contraseña'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Te enviaremos un enlace para crear una nueva.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendResetLink.
  ///
  /// In es, this message translates to:
  /// **'Enviar enlace'**
  String get sendResetLink;

  /// No description provided for @sendingResetLink.
  ///
  /// In es, this message translates to:
  /// **'Enviando…'**
  String get sendingResetLink;

  /// No description provided for @resetLinkSentMessage.
  ///
  /// In es, this message translates to:
  /// **'Si existe una cuenta con ese correo, recibirás un enlace en unos minutos.'**
  String get resetLinkSentMessage;

  /// No description provided for @errorEmailRequired.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu correo electrónico'**
  String get errorEmailRequired;

  /// No description provided for @errorEmailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Introduce un correo válido'**
  String get errorEmailInvalid;

  /// No description provided for @errorPasswordRequired.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu contraseña'**
  String get errorPasswordRequired;

  /// No description provided for @errorPasswordTooShort.
  ///
  /// In es, this message translates to:
  /// **'Debe tener al menos {min} caracteres'**
  String errorPasswordTooShort(int min);

  /// No description provided for @errorPasswordNeedsLetter.
  ///
  /// In es, this message translates to:
  /// **'Debe incluir al menos una letra'**
  String get errorPasswordNeedsLetter;

  /// No description provided for @errorPasswordNeedsDigit.
  ///
  /// In es, this message translates to:
  /// **'Debe incluir al menos un número'**
  String get errorPasswordNeedsDigit;

  /// No description provided for @errorNameRequired.
  ///
  /// In es, this message translates to:
  /// **'Introduce tu nombre'**
  String get errorNameRequired;

  /// No description provided for @errorNameTooLong.
  ///
  /// In es, this message translates to:
  /// **'Máximo {max} caracteres'**
  String errorNameTooLong(int max);

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In es, this message translates to:
  /// **'Correo o contraseña incorrectos.'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorEmailNotConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Confirma tu correo con el enlace que te enviamos antes de iniciar sesión.'**
  String get authErrorEmailNotConfirmed;

  /// No description provided for @authErrorEmailInUse.
  ///
  /// In es, this message translates to:
  /// **'Ya existe una cuenta con ese correo. Inicia sesión o recupera tu contraseña.'**
  String get authErrorEmailInUse;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In es, this message translates to:
  /// **'Esa contraseña es demasiado débil. Prueba con una más larga.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Revisa el correo electrónico.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorRateLimited.
  ///
  /// In es, this message translates to:
  /// **'Demasiados intentos. Espera unos minutos e inténtalo de nuevo.'**
  String get authErrorRateLimited;

  /// No description provided for @authErrorSignupDisabled.
  ///
  /// In es, this message translates to:
  /// **'El registro no está disponible en este momento.'**
  String get authErrorSignupDisabled;

  /// No description provided for @authErrorNetwork.
  ///
  /// In es, this message translates to:
  /// **'No hay conexión. Revisa tu internet e inténtalo de nuevo.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorUnexpected.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal. Inténtalo de nuevo.'**
  String get authErrorUnexpected;

  /// No description provided for @moreAccount.
  ///
  /// In es, this message translates to:
  /// **'Cuenta'**
  String get moreAccount;

  /// No description provided for @signOut.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get signOut;

  /// No description provided for @signOutConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cerrar sesión?'**
  String get signOutConfirmTitle;

  /// No description provided for @signOutConfirmMessage.
  ///
  /// In es, this message translates to:
  /// **'Podrás volver a entrar con tu correo y contraseña.'**
  String get signOutConfirmMessage;

  /// No description provided for @demoModeTitle.
  ///
  /// In es, this message translates to:
  /// **'Modo demostración'**
  String get demoModeTitle;

  /// No description provided for @demoModeMessage.
  ///
  /// In es, this message translates to:
  /// **'No hay servidor configurado: la app muestra datos de ejemplo y no requiere cuenta.'**
  String get demoModeMessage;

  /// No description provided for @onboardingTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo te llamamos?'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Tu nombre aparecerá en las tareas y listas que compartas con tu hogar.'**
  String get onboardingSubtitle;

  /// No description provided for @languageLabel.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get languageLabel;

  /// Nombre del idioma en su propio idioma (no se traduce).
  ///
  /// In es, this message translates to:
  /// **'Español'**
  String get languageSpanish;

  /// No description provided for @languageEnglish.
  ///
  /// In es, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @continueAction.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get continueAction;

  /// No description provided for @savingProfile.
  ///
  /// In es, this message translates to:
  /// **'Guardando…'**
  String get savingProfile;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get profileTitle;

  /// No description provided for @saveChanges.
  ///
  /// In es, this message translates to:
  /// **'Guardar cambios'**
  String get saveChanges;

  /// No description provided for @profileSaved.
  ///
  /// In es, this message translates to:
  /// **'Perfil actualizado.'**
  String get profileSaved;

  /// No description provided for @profileSaveError.
  ///
  /// In es, this message translates to:
  /// **'No pudimos guardar los cambios. Revisa tu conexión e inténtalo de nuevo.'**
  String get profileSaveError;

  /// No description provided for @greetingMorningNamed.
  ///
  /// In es, this message translates to:
  /// **'Buenos días, {name}'**
  String greetingMorningNamed(String name);

  /// No description provided for @greetingAfternoonNamed.
  ///
  /// In es, this message translates to:
  /// **'Buenas tardes, {name}'**
  String greetingAfternoonNamed(String name);

  /// No description provided for @greetingEveningNamed.
  ///
  /// In es, this message translates to:
  /// **'Buenas noches, {name}'**
  String greetingEveningNamed(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
