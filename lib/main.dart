import 'package:arctive/firebase_options.dart';
import 'package:arctive/core/router/app_router.dart';
import 'package:arctive/core/theme/app_theme.dart';
import 'package:arctive/core/widgets/debug_role_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arctive/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: ArctiveApp()));
}

class ArctiveApp extends ConsumerWidget {
  const ArctiveApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Arctive',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      locale: const Locale('ar'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null) child,
            if (kDebugMode)
              const Positioned(
                right: 16,
                bottom: 16,
                child: SafeArea(child: DebugRoleSwitcher()),
              ),
          ],
        );
      },
    );
  }
}
