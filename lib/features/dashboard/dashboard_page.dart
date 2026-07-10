import 'package:arctive/core/utils/placeholder_page.dart';
import 'package:flutter/material.dart';
import 'package:arctive/l10n/app_localizations.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PlaceholderPage(
      title: l10n.dashboardTitle,
      description: l10n.dashboardSubtitle,
    );
  }
}
