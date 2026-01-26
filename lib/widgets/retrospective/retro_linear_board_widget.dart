import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/widgets/retrospective/retro_column_widget.dart';
import 'package:flutter/material.dart';
import 'package:agile_tools/l10n/app_localizations.dart';

class RetroLinearBoardWidget extends StatelessWidget {
  final RetrospectiveModel retro;
  final String currentUserEmail;
  final String currentUserName;
  final bool showAuthorNames;

  const RetroLinearBoardWidget({
    Key? key,
    required this.retro,
    required this.currentUserEmail,
    required this.currentUserName,
    this.showAuthorNames = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (retro.columns.isEmpty) {
      return Center(child: Text(l10n.retroNoColumnsConfigured));
    }

    final bool useScrollable = retro.columns.length > 3;

    if (useScrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: retro.columns.map((col) {
            return Container(
              width: 320,
              margin: const EdgeInsets.only(right: 16),
              child: RetroColumnWidget(
                retro: retro,
                column: col,
                currentUserEmail: currentUserEmail,
                currentUserName: currentUserName,
                showAuthorNames: showAuthorNames,
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: retro.columns.map((col) {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.5))),
              ),
              child: RetroColumnWidget(
                retro: retro,
                column: col,
                currentUserEmail: currentUserEmail,
                currentUserName: currentUserName,
                showAuthorNames: showAuthorNames,
              ),
            ),
          );
        }).toList(),
      );
    }
  }
}
