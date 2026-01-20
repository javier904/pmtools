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

  Future<List<SearchResultItem>> search(String query, String userEmail) async {
    if (query.trim().isEmpty) return [];

    final lowercaseQuery = query.toLowerCase();
    List<SearchResultItem> results = [];

    // Parallel execution for performance
    // debugPrint('GlobalSearch: Starting search for "$query"');
    await Future.wait([
      _searchProjects(lowercaseQuery, userEmail).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Projects');
         results.addAll(r);
      }),
      _searchTodos(lowercaseQuery, userEmail).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Todos');
         results.addAll(r);
      }),
      _searchRetros(lowercaseQuery, userEmail).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Retros');
         results.addAll(r);
      }),
      _searchEstimationSessions(lowercaseQuery, userEmail).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Estimations');
         results.addAll(r);
      }),
      _searchEisenhowerMatrices(lowercaseQuery, userEmail).then((r) {
         // debugPrint('GlobalSearch: Found ${r.length} Matrices');
         results.addAll(r);
      }),
    ]);

    // Sort by relevance (basic implementation: exact matches first) or recency
    // For now, let's sort by default title
    results.sort((a, b) => a.title.compareTo(b.title));
    
    return results;
  }

  Future<List<SearchResultItem>> _searchProjects(String query, String userEmail) async {
    try {
      // Fetching all projects relative to user (this might need optimization for large datasets)
      // Ideally we should have a search method in the service that does filtering
      final projects = await _agileService.getUserProjects(userEmail);
      
      return projects.where((p) {
        return p.name.toLowerCase().contains(query) || 
               p.description.toLowerCase().contains(query);
      }).map((p) => SearchResultItem(
        id: p.id,
        title: p.name,
        subtitle: p.description.isNotEmpty ? p.description : 'Agile Project',
        type: SearchResultType.project,
        route: '/agile-project', 
        arguments: {'id': p.id}, 
        colorHex: '#6C5CE7', // AppColors.primary
        iconOverride: Icons.rocket_launch_rounded
      )).toList();
    } catch (e) {
      debugPrint('Error searching projects: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchTodos(String query, String userEmail) async {
    try {
      // TodoService typically returns a stream, we might need a one-off fetch or converting stream to future
      // Assuming we can fetch lists. If no direct method, we might need to rely on what's available.
      // Checking SmartTodoService capabilities... 
      // It seems SmartTodoService uses Firestore directly. Let's assume we can fetch all for user.
      final lists = await _todoService.getTodoListsOnce(userEmail); // Need to verify if this exists or create it
      
      // We can also search within tasks if the service supports it or we fetch all tasks (expensive)
      // For MVP, let's search List Titles
      return lists.where((l) {
        return l.title.toLowerCase().contains(query);
      }).map((l) => SearchResultItem(
        id: l.id,
        title: l.title,
        subtitle: 'Todo List',
        type: SearchResultType.todo,
        route: '/smart-todo',
        arguments: {'id': l.id},
        colorHex: '#0984E3', // AppColors.secondary
        iconOverride: Icons.check_circle_outline_rounded
      )).toList();
    } catch (e) {
      debugPrint('Error searching todos: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchRetros(String query, String userEmail) async {
    try {
      final retros = await _retroService.streamUserRetrospectives(userEmail).first;
      
      return retros.where((r) {
        return r.sprintName.toLowerCase().contains(query);
      }).map((r) => SearchResultItem(
        id: r.id,
        title: r.sprintName,
        subtitle: 'Retrospective', // Could add date
        type: SearchResultType.retro,
        route: '/retrospective-board', 
        arguments: {'id': r.id},
        colorHex: '#FD79A8', // AppColors.pink
        iconOverride: Icons.psychology_rounded
      )).toList();
    } catch (e) {
      debugPrint('Error searching retros: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchEstimationSessions(String query, String userEmail) async {
    try {
       final sessions = await _pokerService.getSessionsByUser(userEmail);

       return sessions.where((s) {
         return s.name.toLowerCase().contains(query);
       }).map((s) => SearchResultItem(
         id: s.id,
         title: s.name,
         subtitle: 'Estimation Session',
         type: SearchResultType.estimation,
         route: '/estimation-room',
         arguments: {'id': s.id}, 
         colorHex: '#FFC107', // Colors.amber
         iconOverride: Icons.how_to_vote_rounded
       )).toList();
    } catch (e) {
      debugPrint('Error searching estimation sessions: $e');
      return [];
    }
  }

  Future<List<SearchResultItem>> _searchEisenhowerMatrices(String query, String userEmail) async {
    try {
      final matrices = await _eisenhowerService.streamMatricesByUser(userEmail).first;
      
      return matrices.where((m) {
        return m.title.toLowerCase().contains(query);
      }).map((m) => SearchResultItem(
        id: m.id,
        title: m.title,
        subtitle: 'Eisenhower Matrix',
        type: SearchResultType.eisenhower,
        route: '/eisenhower', 
        arguments: {'id': m.id},
        colorHex: '#00B894', // AppColors.success
        iconOverride: Icons.grid_view_rounded
      )).toList();
    } catch (e) {
      debugPrint('Error searching matrices: $e');
      return [];
    }
  }
}
