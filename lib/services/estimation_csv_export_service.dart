import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;

import '../models/planning_poker_session_model.dart';
import '../models/planning_poker_story_model.dart';
import 'user_profile_service.dart';

class EstimationRoomCsvExportService {
  final UserProfileService _userProfileService = UserProfileService();

  /// Simple CSV Converter helper to avoid adding 'csv' package dependency if not present
  /// If 'csv' package is present, prefer using it.
  Future<void> exportSessionToCsv(PlanningPokerSessionModel session, List<PlanningPokerStoryModel> stories) async {
    try {
      if (!kIsWeb) {
        throw UnsupportedError('L\'esportazione CSV e supportata solo su Web al momento.');
      }

      final List<List<dynamic>> rows = [];

      // 1. Session Metadata Header
      final creatorDisplayName = await _userProfileService.getNameByEmail(session.createdBy);
      rows.add(['Session Name', session.name]);
      rows.add(['Created By', creatorDisplayName]);
      rows.add(['Created At', DateFormat('yyyy-MM-dd HH:mm').format(session.createdAt)]);
      rows.add(['Status', session.status.name]);
      rows.add(['Estimation Mode', session.estimationMode.name]);
      rows.add(['Total Participants', session.participantCount]);
      rows.add(['Total Voters', session.voterCount]);
      rows.add(['Total Stories', session.storyCount]);
      rows.add([]); // Empty row as separator

      // 2. Stories Definition
      if (stories.isNotEmpty) {
        // Collect all distinct voter emails who participated across all stories
        final Set<String> allVoterEmails = {};
        for (final story in stories) {
          allVoterEmails.addAll(story.votes.keys);
        }
        final List<String> voterEmailsList = allVoterEmails.toList()..sort();

        // Fetch display names for all voters
        final Map<String, String> voterDisplayNames = {};
        for (final email in voterEmailsList) {
          final displayName = await _userProfileService.getNameByEmail(email);
          voterDisplayNames[email] = displayName;
        }

        final List<String> voterColumns = voterEmailsList.map((email) => voterDisplayNames[email] ?? email).toList();

        // Build Table Header
        final List<dynamic> headerRow = [
          'Story ID',
          'Title',
          'Status',
          'Final Estimate',
          'Average Vote',
          'PERT Optimistic Average',
          'PERT Realistic Average',
          'PERT Pessimistic Average',
        ];
        headerRow.addAll(voterColumns);
        rows.add(headerRow);

        // Map each story to a row
        for (final story in stories) {
          final List<dynamic> row = [
            story.linkedTaskId ?? story.id,
            story.title,
            story.status.name,
            story.finalEstimate ?? '',
          ];

          // Compute Simple Average (if possible)
          double sum = 0;
          int count = 0;
          double pOptSum = 0, pRealSum = 0, pPessSum = 0;
          
          for (final vote in story.votes.values) {
             if (vote.decimalValue != null) {
                sum += vote.decimalValue!;
                count++;
             } else {
                 final val = double.tryParse(vote.value);
                 if (val != null) {
                    sum += val;
                    count++;
                 }
             }
             
             if (vote.optimisticValue != null) pOptSum += vote.optimisticValue!;
             if (vote.realisticValue != null) pRealSum += vote.realisticValue!;
             if (vote.pessimisticValue != null) pPessSum += vote.pessimisticValue!;
          }

          if (count > 0) {
             row.add((sum / count).toStringAsFixed(2));
             if (session.estimationMode.name == 'threePoint' && pRealSum > 0) {
                 row.add((pOptSum / count).toStringAsFixed(2));
                 row.add((pRealSum / count).toStringAsFixed(2));
                 row.add((pPessSum / count).toStringAsFixed(2));
             } else {
                 row.add('');
                 row.add('');
                 row.add('');
             }
          } else {
             row.add(''); // No average
             row.add(''); // No PERT opt
             row.add(''); // No PERT real
             row.add(''); // No PERT pess
          }

          // Append Individual Votes
          for (final email in voterEmailsList) {
            final vote = story.votes[email];
            if (vote != null) {
               if (session.estimationMode.name == 'threePoint' && vote.realisticValue != null) {
                   row.add("O:${vote.optimisticValue} R:${vote.realisticValue} P:${vote.pessimisticValue}");
               } else {
                   row.add(vote.value);
               }
            } else {
               row.add('');
            }
          }
          rows.add(row);
        }
      }

      await _triggerDownload(rows, "Estimation_Session_${session.name.replaceAll(' ', '_')}");

    } catch (e) {
      debugPrint("Error exporting session to CSV: $e");
      rethrow;
    }
  }

  Future<void> _triggerDownload(List<List<dynamic>> rows, String filename) async {
    String csvContent = const ListToCsvConverter().convert(rows);

    if (kIsWeb) {
      // Usa codifica UTF-8 con BOM per supportare caratteri speciali su Excel
      final bytes = utf8.encode('\uFEFF$csvContent');
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..setAttribute("download", "$filename.csv");

      html.document.body!.children.add(anchor);
      anchor.click();
      
      html.document.body!.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    }
  }
}
