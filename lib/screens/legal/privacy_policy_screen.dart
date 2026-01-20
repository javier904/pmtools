import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'legal_document_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LegalDocumentScreen(
      title: l10n.legalPrivacyPolicy,
      lastUpdated: l10n.legalLastUpdatedDate,
      mdContent: l10n.legalPrivacyContent,
    );
  }
}
