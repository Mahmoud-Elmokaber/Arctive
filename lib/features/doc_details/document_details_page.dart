import 'package:arctive/core/utils/placeholder_page.dart';
import 'package:flutter/material.dart';
import 'package:arctive/l10n/app_localizations.dart';

class DocumentDetailsPage extends StatelessWidget {
  const DocumentDetailsPage({super.key, required this.documentId});

  final String documentId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PlaceholderPage(
      title: l10n.documentDetailsTitle,
      description: l10n.documentDetailsSubtitle(documentId),
      trailing: documentId,
    );
  }
}
