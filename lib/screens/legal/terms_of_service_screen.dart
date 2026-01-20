import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'legal_document_screen.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LegalDocumentScreen(
      title: l10n.legalTermsOfService,
      lastUpdated: l10n.legalLastUpdatedDate,
      mdContent: l10n.legalTermsContent,
    );
  }
}
