// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Arctive';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginSubtitle => 'Arabic and English-ready authentication scaffold.';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get dashboardSubtitle => 'Professional document operations dashboard placeholder.';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get documentsSubtitle => 'Documents library placeholder for future workflows.';

  @override
  String get documentDetailsTitle => 'Document details';

  @override
  String documentDetailsSubtitle(String documentId) {
    return 'Document ID: $documentId';
  }

  @override
  String get scanTitle => 'OCR Scan';

  @override
  String get scanSubtitle => 'Scan and extract document text placeholder.';

  @override
  String get alertsTitle => 'Alerts';

  @override
  String get alertsSubtitle => 'Review alerts and compliance notifications placeholder.';

  @override
  String get analyticsTitle => 'Analytics';

  @override
  String get analyticsSubtitle => 'Track sector performance and document insights placeholder.';
}
