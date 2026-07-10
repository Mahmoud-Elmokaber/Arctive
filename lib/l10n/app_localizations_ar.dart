// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'أركتايف';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get loginSubtitle => 'هيكل أولي جاهز للعربية والإنجليزية للمصادقة.';

  @override
  String get dashboardTitle => 'لوحة التحكم';

  @override
  String get dashboardSubtitle => 'واجهة مؤقتة لعمليات المستندات المهنية.';

  @override
  String get documentsTitle => 'المستندات';

  @override
  String get documentsSubtitle => 'واجهة مؤقتة لمكتبة المستندات للخطوات القادمة.';

  @override
  String get documentDetailsTitle => 'تفاصيل المستند';

  @override
  String documentDetailsSubtitle(String documentId) {
    return 'معرّف المستند: $documentId';
  }

  @override
  String get scanTitle => 'مسح OCR';

  @override
  String get scanSubtitle => 'واجهة مؤقتة لمسح المستندات واستخراج النص.';

  @override
  String get alertsTitle => 'التنبيهات';

  @override
  String get alertsSubtitle => 'واجهة مؤقتة لمراجعة التنبيهات والامتثال.';

  @override
  String get analyticsTitle => 'التحليلات';

  @override
  String get analyticsSubtitle => 'واجهة مؤقتة لتتبع الأداء ورؤى المستندات.';
}
