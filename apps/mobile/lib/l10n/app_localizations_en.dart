// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Vivensia';

  @override
  String get tagline => 'Organize less. Live more.';

  @override
  String get routeNotFoundTitle => 'We couldn\'t find this page';

  @override
  String get goHome => 'Go to home';

  @override
  String get openShowcase => 'View design system';

  @override
  String get showcaseTitle => 'Design system';

  @override
  String get showcaseDemoData => 'Sample data';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get sectionColors => 'Colors';

  @override
  String get sectionTypography => 'Typography';

  @override
  String get sectionButtons => 'Buttons';

  @override
  String get sectionInputs => 'Text fields';

  @override
  String get sectionCards => 'Cards';

  @override
  String get sectionBadges => 'Badges';

  @override
  String get sectionSelectors => 'Selectors';

  @override
  String get sectionProgress => 'Progress';

  @override
  String get sectionLists => 'Lists';

  @override
  String get sectionOverlays => 'Dialogs and sheets';

  @override
  String get sectionStates => 'States';

  @override
  String get sectionSkeleton => 'Loading placeholders';

  @override
  String get colorPrimary => 'Primary';

  @override
  String get colorSecondary => 'Secondary';

  @override
  String get colorTertiary => 'Tertiary';

  @override
  String get colorGold => 'Gold';

  @override
  String get colorSuccess => 'Success';

  @override
  String get colorWarning => 'Warning';

  @override
  String get colorError => 'Error';

  @override
  String get colorInfo => 'Info';

  @override
  String get buttonPrimary => 'Primary action';

  @override
  String get buttonSecondary => 'Secondary';

  @override
  String get buttonTertiary => 'Tertiary';

  @override
  String get buttonLoading => 'Saving…';

  @override
  String get buttonDisabled => 'Unavailable';

  @override
  String get fieldEmailLabel => 'Email';

  @override
  String get fieldEmailHint => 'name@example.com';

  @override
  String get fieldEmailHelper => 'We\'ll use it to sign in';

  @override
  String get fieldEmailError => 'Enter a valid email';

  @override
  String get fieldPasswordLabel => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get demoCleaningTitle => 'Cleaning';

  @override
  String demoPendingTasks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pending tasks',
      one: '1 pending task',
    );
    return '$_temp0';
  }

  @override
  String get demoBudgetTitle => 'Monthly budget';

  @override
  String demoPercentUsed(int percent) {
    return '$percent% used';
  }

  @override
  String get demoShoppingTitle => 'Shopping';

  @override
  String demoProducts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get badgeDone => 'Done';

  @override
  String get badgeDueSoon => 'Due soon';

  @override
  String get badgeOverdue => 'Overdue';

  @override
  String get badgeNew => 'New';

  @override
  String get badgeAchievement => 'Achievement';

  @override
  String get badgeShared => 'Shared';

  @override
  String get badgeInfo => 'Update';

  @override
  String get roomKitchen => 'Kitchen';

  @override
  String get roomBathroom => 'Bathroom';

  @override
  String get roomLivingRoom => 'Living room';

  @override
  String get roomBedroom => 'Bedroom';

  @override
  String get periodDay => 'Day';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodMonth => 'Month';

  @override
  String get openDialog => 'Open dialog';

  @override
  String get openSheet => 'Open bottom sheet';

  @override
  String get dialogDeleteTaskTitle => 'Delete task?';

  @override
  String get dialogDeleteTaskMessage => 'This action can\'t be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get sheetNewTaskTitle => 'New task';

  @override
  String get sheetTaskNameLabel => 'Task name';

  @override
  String get emptyTasksTitle => 'No tasks yet';

  @override
  String get emptyTasksMessage =>
      'Create your first task to start organizing your home.';

  @override
  String get emptyTasksAction => 'Create task';

  @override
  String get errorGenericTitle => 'Something went wrong';

  @override
  String get errorGenericMessage =>
      'We couldn\'t load the information. Check your connection and try again.';

  @override
  String get retry => 'Try again';

  @override
  String get loading => 'Loading…';

  @override
  String get navHome => 'Home';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navShopping => 'Shopping';

  @override
  String get navAgenda => 'Calendar';

  @override
  String get navMore => 'More';
}
