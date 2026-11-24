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
  /// **'{count, plural, =1{1 tarea pendiente} other{{count} tareas pendientes}}'**
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
  /// **'{count, plural, =1{1 producto} other{{count} productos}}'**
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
