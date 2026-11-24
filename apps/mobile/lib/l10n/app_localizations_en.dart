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
      zero: 'No pending tasks',
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
      zero: 'No items',
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

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get greetingSubtitle => 'Let\'s make today a great day.';

  @override
  String get myHousehold => 'My home';

  @override
  String get demoHouseholdName => 'Sample home';

  @override
  String get householdSwitcherHint => 'Switch home';

  @override
  String get householdSheetTitle => 'Your homes';

  @override
  String get householdSheetMessage =>
      'Soon you\'ll be able to create homes, invite your family and switch between them.';

  @override
  String get notifications => 'Notifications';

  @override
  String get todayEyebrow => 'Your home today';

  @override
  String get todayAllGood => 'Everything under control';

  @override
  String get statTasks => 'Tasks';

  @override
  String get statShopping => 'Shopping';

  @override
  String get statEvents => 'Events';

  @override
  String statSemantics(String label, int count) {
    return '$label: $count';
  }

  @override
  String get organizeYourHome => 'Organize your home';

  @override
  String get moduleCleaning => 'Cleaning';

  @override
  String get moduleFinances => 'Finances';

  @override
  String get moduleShopping => 'Shopping';

  @override
  String get modulePantry => 'Pantry';

  @override
  String get moduleCalendar => 'Calendar';

  @override
  String get moduleRecipes => 'Recipes & meals';

  @override
  String get moduleMaintenance => 'Maintenance';

  @override
  String get moduleDocuments => 'Documents';

  @override
  String get moduleFamily => 'My family';

  @override
  String get moduleAssistant => 'Smart assistant';

  @override
  String get moduleSettings => 'Settings';

  @override
  String get recipesSubtitle => 'Weekly menu';

  @override
  String get documentsSubtitle => 'Your files';

  @override
  String demoUpcomingEvents(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count upcoming events',
      one: '1 upcoming event',
      zero: 'No upcoming events',
    );
    return '$_temp0';
  }

  @override
  String demoUpcomingMaintenance(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count upcoming checks',
      one: '1 upcoming check',
      zero: 'No upcoming checks',
    );
    return '$_temp0';
  }

  @override
  String demoFamilyMembers(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '1 member',
    );
    return '$_temp0';
  }

  @override
  String get assistantPrompt => 'What do you need to organize today?';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get comingSoonMessage =>
      'We\'re preparing this section to make organizing your home even easier.';

  @override
  String get tasksPlaceholderTitle => 'Your household tasks will appear here';

  @override
  String get shoppingPlaceholderTitle => 'Your shopping lists will appear here';

  @override
  String get agendaPlaceholderTitle => 'Your household events will appear here';

  @override
  String get moreFeatures => 'Features';

  @override
  String get moreAppearance => 'Appearance';

  @override
  String get moreDevelopment => 'Development';

  @override
  String get welcomeTitle => 'Your home, in harmony';

  @override
  String get welcomeSubtitle =>
      'Cleaning, shopping, finances and family calendar in one place.';

  @override
  String get createAccount => 'Create account';

  @override
  String get haveAccount => 'I already have an account';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get signInSubtitle => 'Good to see you again.';

  @override
  String get signInAction => 'Sign in';

  @override
  String get signingIn => 'Signing in…';

  @override
  String get forgotPasswordLink => 'Forgot your password?';

  @override
  String get noAccountPrompt => 'No account? Create one';

  @override
  String get signUpTitle => 'Create your account';

  @override
  String get signUpSubtitle => 'Start organizing your home in minutes.';

  @override
  String get signUpAction => 'Create account';

  @override
  String get signingUp => 'Creating account…';

  @override
  String get haveAccountPrompt => 'Already have an account? Sign in';

  @override
  String get displayNameLabel => 'Your name';

  @override
  String get displayNameHelper =>
      'This is how your family will see you in Vivensia.';

  @override
  String passwordRulesHelper(int min) {
    return 'At least $min characters, with letters and numbers.';
  }

  @override
  String get confirmEmailTitle => 'Check your email';

  @override
  String get confirmEmailMessage =>
      'If the address is correct, we sent you a link to confirm your account. Then you can sign in.';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get forgotPasswordTitle => 'Reset your password';

  @override
  String get forgotPasswordSubtitle =>
      'We\'ll send you a link to create a new one.';

  @override
  String get sendResetLink => 'Send link';

  @override
  String get sendingResetLink => 'Sending…';

  @override
  String get resetLinkSentMessage =>
      'If an account exists for that email, you\'ll receive a link in a few minutes.';

  @override
  String get errorEmailRequired => 'Enter your email';

  @override
  String get errorEmailInvalid => 'Enter a valid email';

  @override
  String get errorPasswordRequired => 'Enter your password';

  @override
  String errorPasswordTooShort(int min) {
    return 'Must be at least $min characters';
  }

  @override
  String get errorPasswordNeedsLetter => 'Must include at least one letter';

  @override
  String get errorPasswordNeedsDigit => 'Must include at least one number';

  @override
  String get errorNameRequired => 'Enter your name';

  @override
  String errorNameTooLong(int max) {
    return 'Maximum $max characters';
  }

  @override
  String get authErrorInvalidCredentials => 'Incorrect email or password.';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirm your email with the link we sent before signing in.';

  @override
  String get authErrorEmailInUse =>
      'An account with that email already exists. Sign in or reset your password.';

  @override
  String get authErrorWeakPassword =>
      'That password is too weak. Try a longer one.';

  @override
  String get authErrorInvalidEmail => 'Check the email address.';

  @override
  String get authErrorRateLimited =>
      'Too many attempts. Wait a few minutes and try again.';

  @override
  String get authErrorSignupDisabled => 'Sign-up isn\'t available right now.';

  @override
  String get authErrorNetwork =>
      'No connection. Check your internet and try again.';

  @override
  String get authErrorUnexpected => 'Something went wrong. Please try again.';

  @override
  String get moreAccount => 'Account';

  @override
  String get signOut => 'Sign out';

  @override
  String get signOutConfirmTitle => 'Sign out?';

  @override
  String get signOutConfirmMessage =>
      'You can sign back in with your email and password.';

  @override
  String get demoModeTitle => 'Demo mode';

  @override
  String get demoModeMessage =>
      'No server configured: the app shows sample data and doesn\'t require an account.';
}
