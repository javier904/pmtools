import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'legal_document_screen.dart';

class CookiePolicyScreen extends StatelessWidget {
  const CookiePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LegalDocumentScreen(
      title: l10n.legalCookiePolicy,
      lastUpdated: l10n.legalLastUpdatedDate,
      mdContent: l10n.legalCookiesContent,
    );
  }
}
