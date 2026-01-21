import 'dart:async';
import 'package:flutter/material.dart';
import '../models/search_result_item.dart';
import '../services/agile_firestore_service.dart';
import '../services/smart_todo_service.dart';
import '../services/retrospective_firestore_service.dart';
import '../services/planning_poker_firestore_service.dart';
import '../services/eisenhower_firestore_service.dart';

class GlobalSearchService {
  final AgileFirestoreService _agileService = AgileFirestoreService();
  final SmartTodoService _todoService = SmartTodoService();
  final RetrospectiveFirestoreService _retroService = RetrospectiveFirestoreService();
  final PlanningPokerFirestoreService _pokerService = PlanningPokerFirestoreService();
  final EisenhowerFirestoreService _eisenhowerService = EisenhowerFirestoreService();

  Future<List<SearchResultItem>> search(
    String query,
    String userEmail, {
    bool includeArchived = false,
  }) async {
    if (query.trim().isEmpty) return [];

    final lowercaseQuery = query.toLowerCase();
    List<SearchResultItem> results = [];

    // Parallel execution for performance
    // debugPrint('GlobalSearch: Starting search for "$query" (includeArchived: $includeArchived)');
    await Future.wait([
      _searchProjects(lowercaseQuery, userEmail, includeArchived).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Projects');
         results.addAll(r);
      }),
      _searchTodos(lowercaseQuery, userEmail, includeArchived).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Todos');
         results.addAll(r);
      }),
      _searchRetros(lowercaseQuery, userEmail, includeArchived).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Retros');
         results.addAll(r);
      }),
      _searchEstimationSessions(lowercaseQuery, userEmail, includeArchived).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Estimations');
         results.addAll(r);
      }),
      _searchEisenhowerMatrices(lowercaseQuery, userEmail, includeArchived).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Matrices');
         results.addAll(r);
      }),
    ]);

    // Sort by relevance (basic implementation: exact matches first) or recency
    // For now, let's sort by default title
    results.sort((a, b) => a.title.compareTo(b.title));

    return results;
  }

  Future<List<SearchResultItem>> _searchProjects(String query, String userEmail, bool includeArchived) async {
    try {
      final projects = await _agileService.getUserProjects(userEmail);

      return projects.where((p) {
        // Filtra archiviati se non richiesti
        if (!includeArchived && p.isArchived == true) return false;
        return p.name.toLowerCase().contains(query) ||
               p.description.toLowerCase().contains(query);
      }).map((p) => SearchResultItem(
        id: p.id,
        title: p.name,
        subtitle: p.description.isNotEmpty ? p.description : 'Agile Project',
        type: SearchResultType.project,
        route: '/agile-project',
        arguments: {'id': p.id},
        colorHex: '#6C5CE7',
        iconOverride: Icons.rocket_launch_rounded,
        isArchived: p.isArchived == true,
      )).toList();
    } catch (e) {
      debugPrint('Error searching projects: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchTodos(String query, String userEmail, bool includeArchived) async {
    try {
      final lists = await _todoService.getTodoListsOnce(userEmail);

      return lists.where((l) {
        if (!includeArchived && l.isArchived == true) return false;
        return l.title.toLowerCase().contains(query);
      }).map((l) => SearchResultItem(
        id: l.id,
        title: l.title,
        subtitle: 'Todo List',
        type: SearchResultType.todo,
        route: '/smart-todo',
        arguments: {'id': l.id},
        colorHex: '#0984E3',
        iconOverride: Icons.check_circle_outline_rounded,
        isArchived: l.isArchived == true,
      )).toList();
    } catch (e) {
      debugPrint('Error searching todos: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchRetros(String query, String userEmail, bool includeArchived) async {
    try {
      final retros = await _retroService.streamUserRetrospectives(userEmail).first;

      return retros.where((r) {
        if (!includeArchived && r.isArchived == true) return false;
        return r.sprintName.toLowerCase().contains(query);
      }).map((r) => SearchResultItem(
        id: r.id,
        title: r.sprintName,
        subtitle: 'Retrospective',
        type: SearchResultType.retro,
        route: '/retrospective-board',
        arguments: {'id': r.id},
        colorHex: '#FD79A8',
        iconOverride: Icons.psychology_rounded,
        isArchived: r.isArchived == true,
      )).toList();
    } catch (e) {
      debugPrint('Error searching retros: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchEstimationSessions(String query, String userEmail, bool includeArchived) async {
    try {
       final sessions = await _pokerService.getSessionsByUser(userEmail);

       return sessions.where((s) {
         if (!includeArchived && s.isArchived == true) return false;
         return s.name.toLowerCase().contains(query);
       }).map((s) => SearchResultItem(
         id: s.id,
         title: s.name,
         subtitle: 'Estimation Session',
         type: SearchResultType.estimation,
         route: '/estimation-room',
         arguments: {'id': s.id},
         colorHex: '#FFC107',
         iconOverride: Icons.how_to_vote_rounded,
         isArchived: s.isArchived == true,
       )).toList();
    } catch (e) {
      debugPrint('Error searching estimation sessions: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchEisenhowerMatrices(String query, String userEmail, bool includeArchived) async {
    try {
      final matrices = await _eisenhowerService.streamMatricesByUser(userEmail).first;

      return matrices.where((m) {
        if (!includeArchived && m.isArchived == true) return false;
        return m.title.toLowerCase().contains(query);
      }).map((m) => SearchResultItem(
        id: m.id,
        title: m.title,
        subtitle: 'Eisenhower Matrix',
        type: SearchResultType.eisenhower,
        route: '/eisenhower',
        arguments: {'id': m.id},
        colorHex: '#00B894',
        iconOverride: Icons.grid_view_rounded,
        isArchived: m.isArchived == true,
      )).toList();
    } catch (e) {
      debugPrint('Error searching matrices: $e');
      return [];
    }
  }
}
