import 'dart:math' show sqrt;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/smart_todo/todo_list_model.dart';
import '../models/smart_todo/todo_task_model.dart';
import '../models/smart_todo/cfd_metrics_model.dart';

/// Data model for a single CFD data point (one day)
class CfdDataPoint {
  final DateTime date;
  final Map<String, int> columnCounts; // columnId -> task count

  CfdDataPoint({
    required this.date,
    required this.columnCounts,
  });

  int get totalTasks => columnCounts.values.fold(0, (sum, count) => sum + count);
}

/// Result of CFD calculation with metadata
class CfdChartData {
  final List<CfdDataPoint> dataPoints;
  final List<TodoColumn> columns;
  final DateTime startDate;
  final DateTime endDate;

  CfdChartData({
    required this.dataPoints,
    required this.columns,
    required this.startDate,
    required this.endDate,
  });

  bool get isEmpty => dataPoints.isEmpty;

  int get maxTaskCount {
    if (dataPoints.isEmpty) return 0;
    return dataPoints.map((p) => p.totalTasks).reduce((a, b) => a > b ? a : b);
  }
}

/// Complete analytics result containing chart data and all metrics
class CfdAnalyticsData {
  final CfdChartData chartData;
  final CfdMetrics metrics;

  CfdAnalyticsData({
    required this.chartData,
    required this.metrics,
  });
}

/// Service for calculating Cumulative Flow Diagram data and advanced metrics
class CfdDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CfdDataService _instance = CfdDataService._internal();
  factory CfdDataService() => _instance;
  CfdDataService._internal();

  static const String _listsCollection = 'smart_todo_lists';
  static const String _tasksSubcollection = 'smart_todo_tasks';
  static const String _auditSubcollection = 'audit_logs';

  // ═══════════════════════════════════════════════════════════════════════════
  // MAIN ANALYTICS METHOD
  // ═══════════════════════════════════════════════════════════════════════════

  /// Calculate complete CFD analytics including chart data and all metrics
  Future<CfdAnalyticsData> calculateAnalytics({
    required String listId,
    required List<TodoColumn> columns,
    required DateTime startDate,
    required DateTime endDate,
    int teamSize = 3, // For WIP limit calculation (default)
    int? customWipLimit, // Optional custom WIP limit
  }) async {
    final normalizedStart = DateTime(startDate.year, startDate.month, startDate.day);
    final normalizedEnd = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    final periodDays = normalizedEnd.difference(normalizedStart).inDays + 1;

    // Get all data
    final auditLogs = await _getAuditLogs(listId);
    final currentTasks = await _getCurrentTasksDetailed(listId);

    // Calculate chart data
    final chartData = _calculateChartData(
      normalizedStart,
      normalizedEnd,
      auditLogs,
      currentTasks,
      columns,
    );

    // Calculate previous period for trends
    final previousStart = normalizedStart.subtract(Duration(days: periodDays));
    final previousEnd = normalizedStart.subtract(const Duration(days: 1));

    // Calculate all metrics
    final metrics = await _calculateAllMetrics(
      listId: listId,
      columns: columns,
      startDate: normalizedStart,
      endDate: normalizedEnd,
      previousStart: previousStart,
      previousEnd: previousEnd,
      auditLogs: auditLogs,
      currentTasks: currentTasks,
      teamSize: teamSize,
      customWipLimit: customWipLimit,
    );

    return CfdAnalyticsData(
      chartData: chartData,
      metrics: metrics,
    );
  }

  /// Calculate only chart data (lighter weight)
  Future<CfdChartData> calculateCfdData({
    required String listId,
    required List<TodoColumn> columns,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final normalizedStart = DateTime(startDate.year, startDate.month, startDate.day);
    final normalizedEnd = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    final auditLogs = await _getAuditLogs(listId);
    final currentTasks = await _getCurrentTasksDetailed(listId);

    return _calculateChartData(
      normalizedStart,
      normalizedEnd,
      auditLogs,
      currentTasks,
      columns,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // METRICS CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  Future<CfdMetrics> _calculateAllMetrics({
    required String listId,
    required List<TodoColumn> columns,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime previousStart,
    required DateTime previousEnd,
    required List<_AuditLogEntry> auditLogs,
    required List<_TaskSnapshotDetailed> currentTasks,
    required int teamSize,
    int? customWipLimit,
  }) async {
    final periodDays = endDate.difference(startDate).inDays + 1;

    // Find done columns - with fallback detection
    print('🔍 CFD Metrics: Columns received: ${columns.map((c) => '${c.id}:${c.title}:isDone=${c.isDone}').toList()}');
    var doneColumnIds = columns.where((c) => c.isDone).map((c) => c.id).toSet();
    print('🔍 CFD Metrics: Done columns by isDone flag: $doneColumnIds');

    // Fallback: if no columns have isDone flag, detect by title
    if (doneColumnIds.isEmpty) {
      final doneKeywords = ['done', 'fatto', 'terminé', 'terminado', 'complete', 'completed', 'finished'];
      final doneByTitle = columns.where((c) =>
        doneKeywords.any((keyword) => c.title.toLowerCase().contains(keyword))
      ).map((c) => c.id).toSet();

      if (doneByTitle.isNotEmpty) {
        doneColumnIds = doneByTitle;
        print('🔍 CFD Metrics: Using title-based done column detection: $doneByTitle');
      }
    }
    print('🔍 CFD Metrics: Final done column IDs: $doneColumnIds');

    final todoColumnIds = columns.isNotEmpty ? {columns.first.id} : <String>{};

    // Calculate each metric
    final leadTime = _calculateLeadTime(
      auditLogs, currentTasks, doneColumnIds, startDate, endDate, previousStart, previousEnd,
    );

    final cycleTime = _calculateCycleTime(
      auditLogs, currentTasks, doneColumnIds, todoColumnIds, startDate, endDate, previousStart, previousEnd,
    );

    final throughput = _calculateThroughput(
      auditLogs, doneColumnIds, startDate, endDate, previousStart, previousEnd,
    );

    final wip = _calculateWip(
      currentTasks, columns, doneColumnIds, todoColumnIds, auditLogs, teamSize, customWipLimit,
    );

    final flow = _calculateFlow(
      auditLogs, doneColumnIds, startDate, endDate,
    );

    final bottlenecks = _detectBottlenecks(
      currentTasks, columns, doneColumnIds, todoColumnIds, auditLogs,
    );

    final teamBalance = _calculateTeamBalance(
      currentTasks, columns, doneColumnIds, todoColumnIds,
    );

    return CfdMetrics(
      leadTime: leadTime,
      cycleTime: cycleTime,
      throughput: throughput,
      wip: wip,
      flow: flow,
      bottlenecks: bottlenecks,
      teamBalance: teamBalance,
      calculatedAt: DateTime.now(),
      periodDays: periodDays,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LEAD TIME CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  LeadTimeMetrics _calculateLeadTime(
    List<_AuditLogEntry> auditLogs,
    List<_TaskSnapshotDetailed> currentTasks,
    Set<String> doneColumnIds,
    DateTime startDate,
    DateTime endDate,
    DateTime previousStart,
    DateTime previousEnd,
  ) {
    final dataPoints = <LeadTimeDataPoint>[];
    final previousDataPoints = <LeadTimeDataPoint>[];

    // Find all tasks that were completed (moved to done column)
    final completionEvents = <String, DateTime>{}; // taskId -> completion time
    final taskCreationTimes = <String, DateTime>{}; // taskId -> creation time
    final taskTitles = <String, String>{}; // taskId -> title

    // Build creation times from current tasks
    for (final task in currentTasks) {
      taskCreationTimes[task.id] = task.createdAt;
      taskTitles[task.id] = task.title;
    }

    // Also get creation times from audit logs for deleted tasks
    for (final log in auditLogs) {
      if (log.action == 'create') {
        taskCreationTimes[log.entityId] = log.timestamp;
        if (log.entityName != null) {
          taskTitles[log.entityId] = log.entityName!;
        }
      }
    }

    // Find completion events (moves to done column)
    print('🔍 CFD LeadTime: Searching ${auditLogs.length} audit logs for completions');
    print('🔍 CFD LeadTime: Done column IDs: $doneColumnIds');

    for (final log in auditLogs) {
      if (log.action == 'move' || log.action == 'update') {
        final newStatus = _getNewStatusFromChanges(log.changes);
        print('🔍 CFD LeadTime: Log action=${log.action}, entityId=${log.entityId}, newStatus=$newStatus, changes=${log.changes}');
        if (newStatus != null && doneColumnIds.contains(newStatus)) {
          // This is a completion event
          completionEvents[log.entityId] = log.timestamp;
          print('✅ CFD LeadTime: Found completion for task ${log.entityId}');
        }
      }
    }

    print('🔍 CFD LeadTime: Total completion events found: ${completionEvents.length}');

    // Calculate lead times for completed tasks
    for (final entry in completionEvents.entries) {
      final taskId = entry.key;
      final completedAt = entry.value;
      final createdAt = taskCreationTimes[taskId];

      if (createdAt != null) {
        final leadTimeDays = completedAt.difference(createdAt).inHours / 24.0;

        final dataPoint = LeadTimeDataPoint(
          taskId: taskId,
          taskTitle: taskTitles[taskId] ?? 'Unknown',
          completedAt: completedAt,
          leadTimeDays: leadTimeDays,
        );

        // Check if in current period
        if (!completedAt.isBefore(startDate) && !completedAt.isAfter(endDate)) {
          dataPoints.add(dataPoint);
        }
        // Check if in previous period
        else if (!completedAt.isBefore(previousStart) && !completedAt.isAfter(previousEnd)) {
          previousDataPoints.add(dataPoint);
        }
      }
    }

    if (dataPoints.isEmpty) {
      return LeadTimeMetrics.empty;
    }

    // Calculate statistics
    final leadTimes = dataPoints.map((d) => d.leadTimeDays).toList()..sort();
    final average = leadTimes.reduce((a, b) => a + b) / leadTimes.length;
    final median = _calculateMedian(leadTimes);
    final p85 = _calculatePercentile(leadTimes, 85);
    final p95 = _calculatePercentile(leadTimes, 95);

    double? previousAverage;
    if (previousDataPoints.isNotEmpty) {
      final prevTimes = previousDataPoints.map((d) => d.leadTimeDays).toList();
      previousAverage = prevTimes.reduce((a, b) => a + b) / prevTimes.length;
    }

    return LeadTimeMetrics(
      averageDays: average,
      medianDays: median,
      percentile85Days: p85,
      percentile95Days: p95,
      minDays: leadTimes.first,
      maxDays: leadTimes.last,
      sampleSize: dataPoints.length,
      previousPeriodAverage: previousAverage,
      dataPoints: dataPoints,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CYCLE TIME CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  CycleTimeMetrics _calculateCycleTime(
    List<_AuditLogEntry> auditLogs,
    List<_TaskSnapshotDetailed> currentTasks,
    Set<String> doneColumnIds,
    Set<String> todoColumnIds,
    DateTime startDate,
    DateTime endDate,
    DateTime previousStart,
    DateTime previousEnd,
  ) {
    final dataPoints = <CycleTimeDataPoint>[];
    final previousDataPoints = <CycleTimeDataPoint>[];

    // Track when tasks started work (left todo column)
    final taskStartTimes = <String, DateTime>{}; // taskId -> start work time
    final taskCompletionTimes = <String, DateTime>{}; // taskId -> completion time
    final taskTitles = <String, String>{};

    // Build titles from current tasks
    for (final task in currentTasks) {
      taskTitles[task.id] = task.title;
    }

    // Process audit logs to find start and completion times
    for (final log in auditLogs) {
      if (log.entityName != null) {
        taskTitles[log.entityId] = log.entityName!;
      }

      if (log.action == 'move' || log.action == 'update') {
        final previousStatus = _getPreviousStatusFromChanges(log.changes);
        final newStatus = _getNewStatusFromChanges(log.changes);

        // Check if task started work (moved out of todo)
        if (previousStatus != null && todoColumnIds.contains(previousStatus) &&
            newStatus != null && !todoColumnIds.contains(newStatus)) {
          // First time leaving todo is the start time
          if (!taskStartTimes.containsKey(log.entityId)) {
            taskStartTimes[log.entityId] = log.timestamp;
          }
        }

        // Check if task completed (moved to done)
        if (newStatus != null && doneColumnIds.contains(newStatus)) {
          taskCompletionTimes[log.entityId] = log.timestamp;
        }
      }
    }

    // Calculate cycle times for completed tasks that have start times
    for (final entry in taskCompletionTimes.entries) {
      final taskId = entry.key;
      final completedAt = entry.value;
      final startedAt = taskStartTimes[taskId];

      if (startedAt != null && startedAt.isBefore(completedAt)) {
        final cycleTimeDays = completedAt.difference(startedAt).inHours / 24.0;

        final dataPoint = CycleTimeDataPoint(
          taskId: taskId,
          taskTitle: taskTitles[taskId] ?? 'Unknown',
          startedAt: startedAt,
          completedAt: completedAt,
          cycleTimeDays: cycleTimeDays,
        );

        if (!completedAt.isBefore(startDate) && !completedAt.isAfter(endDate)) {
          dataPoints.add(dataPoint);
        } else if (!completedAt.isBefore(previousStart) && !completedAt.isAfter(previousEnd)) {
          previousDataPoints.add(dataPoint);
        }
      }
    }

    if (dataPoints.isEmpty) {
      return CycleTimeMetrics.empty;
    }

    final cycleTimes = dataPoints.map((d) => d.cycleTimeDays).toList()..sort();
    final average = cycleTimes.reduce((a, b) => a + b) / cycleTimes.length;
    final median = _calculateMedian(cycleTimes);
    final p85 = _calculatePercentile(cycleTimes, 85);
    final p95 = _calculatePercentile(cycleTimes, 95);

    double? previousAverage;
    if (previousDataPoints.isNotEmpty) {
      final prevTimes = previousDataPoints.map((d) => d.cycleTimeDays).toList();
      previousAverage = prevTimes.reduce((a, b) => a + b) / prevTimes.length;
    }

    return CycleTimeMetrics(
      averageDays: average,
      medianDays: median,
      percentile85Days: p85,
      percentile95Days: p95,
      minDays: cycleTimes.first,
      maxDays: cycleTimes.last,
      sampleSize: dataPoints.length,
      previousPeriodAverage: previousAverage,
      dataPoints: dataPoints,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // THROUGHPUT CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  ThroughputMetrics _calculateThroughput(
    List<_AuditLogEntry> auditLogs,
    Set<String> doneColumnIds,
    DateTime startDate,
    DateTime endDate,
    DateTime previousStart,
    DateTime previousEnd,
  ) {
    final periodDays = endDate.difference(startDate).inDays + 1;

    // Count completions per day
    final dailyCompletions = <DateTime, int>{};
    int totalCompleted = 0;
    int previousCompleted = 0;

    // Initialize all days with 0
    DateTime current = startDate;
    while (!current.isAfter(endDate)) {
      dailyCompletions[DateTime(current.year, current.month, current.day)] = 0;
      current = current.add(const Duration(days: 1));
    }

    // Count completions from audit logs
    for (final log in auditLogs) {
      if (log.action == 'move' || log.action == 'update') {
        final newStatus = _getNewStatusFromChanges(log.changes);
        if (newStatus != null && doneColumnIds.contains(newStatus)) {
          final day = DateTime(log.timestamp.year, log.timestamp.month, log.timestamp.day);

          if (!log.timestamp.isBefore(startDate) && !log.timestamp.isAfter(endDate)) {
            dailyCompletions[day] = (dailyCompletions[day] ?? 0) + 1;
            totalCompleted++;
          } else if (!log.timestamp.isBefore(previousStart) && !log.timestamp.isAfter(previousEnd)) {
            previousCompleted++;
          }
        }
      }
    }

    final dailyData = dailyCompletions.entries
        .map((e) => ThroughputDataPoint(date: e.key, completed: e.value))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    final dailyAverage = totalCompleted / periodDays;
    final weeklyAverage = dailyAverage * 7;

    double? previousWeeklyAverage;
    if (previousCompleted > 0) {
      final prevDays = previousEnd.difference(previousStart).inDays + 1;
      previousWeeklyAverage = (previousCompleted / prevDays) * 7;
    }

    return ThroughputMetrics(
      dailyAverage: dailyAverage,
      weeklyAverage: weeklyAverage,
      totalCompleted: totalCompleted,
      periodDays: periodDays,
      previousPeriodWeeklyAverage: previousWeeklyAverage,
      dailyData: dailyData,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // WIP CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  WipMetrics _calculateWip(
    List<_TaskSnapshotDetailed> currentTasks,
    List<TodoColumn> columns,
    Set<String> doneColumnIds,
    Set<String> todoColumnIds,
    List<_AuditLogEntry> auditLogs,
    int teamSize,
    int? customWipLimit,
  ) {
    // WIP = tasks not in todo and not in done
    final wipTasks = currentTasks.where((t) =>
      !todoColumnIds.contains(t.statusId) &&
      !doneColumnIds.contains(t.statusId)
    ).toList();

    final wipByColumn = <String, int>{};
    for (final col in columns) {
      if (!todoColumnIds.contains(col.id) && !doneColumnIds.contains(col.id)) {
        wipByColumn[col.id] = 0;
      }
    }

    // Track when each WIP task started work
    final taskStartTimes = <String, DateTime>{};
    for (final log in auditLogs) {
      if (log.action == 'move' || log.action == 'update') {
        final previousStatus = _getPreviousStatusFromChanges(log.changes);
        final newStatus = _getNewStatusFromChanges(log.changes);

        if (previousStatus != null && todoColumnIds.contains(previousStatus) &&
            newStatus != null && !todoColumnIds.contains(newStatus)) {
          if (!taskStartTimes.containsKey(log.entityId)) {
            taskStartTimes[log.entityId] = log.timestamp;
          }
        }
      }
    }

    final now = DateTime.now();
    final agingTasks = <AgingTask>[];

    for (final task in wipTasks) {
      // Count by column
      if (wipByColumn.containsKey(task.statusId)) {
        wipByColumn[task.statusId] = wipByColumn[task.statusId]! + 1;
      }

      // Calculate age
      final startTime = taskStartTimes[task.id] ?? task.createdAt;
      final ageDays = now.difference(startTime).inHours / 24.0;

      // Find column title
      final column = columns.firstWhere(
        (c) => c.id == task.statusId,
        orElse: () => const TodoColumn(id: '', title: 'Unknown'),
      );

      agingTasks.add(AgingTask(
        taskId: task.id,
        taskTitle: task.title,
        columnId: task.statusId,
        columnTitle: column.title,
        startedAt: startTime,
        ageDays: ageDays,
        assignedTo: task.assignedTo,
      ));
    }

    // Sort by age descending
    agingTasks.sort((a, b) => b.ageDays.compareTo(a.ageDays));

    // Calculate average age
    double averageAge = 0;
    if (agingTasks.isNotEmpty) {
      averageAge = agingTasks.map((t) => t.ageDays).reduce((a, b) => a + b) / agingTasks.length;
    }

    // WIP limit: custom value or default (2x team size)
    final wipLimit = customWipLimit ?? (teamSize * 2);

    return WipMetrics(
      totalWip: wipTasks.length,
      wipLimit: wipLimit,
      averageAge: averageAge,
      wipByColumn: wipByColumn,
      agingTasks: agingTasks,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FLOW CALCULATION (Arrival vs Completion)
  // ═══════════════════════════════════════════════════════════════════════════

  FlowMetrics _calculateFlow(
    List<_AuditLogEntry> auditLogs,
    Set<String> doneColumnIds,
    DateTime startDate,
    DateTime endDate,
  ) {
    final periodDays = endDate.difference(startDate).inDays + 1;

    final dailyData = <DateTime, _FlowDay>{};

    // Initialize all days
    DateTime current = startDate;
    while (!current.isAfter(endDate)) {
      final day = DateTime(current.year, current.month, current.day);
      dailyData[day] = _FlowDay();
      current = current.add(const Duration(days: 1));
    }

    // Process audit logs
    for (final log in auditLogs) {
      if (log.timestamp.isBefore(startDate) || log.timestamp.isAfter(endDate)) {
        continue;
      }

      final day = DateTime(log.timestamp.year, log.timestamp.month, log.timestamp.day);
      final flowDay = dailyData[day];
      if (flowDay == null) continue;

      if (log.action == 'create') {
        flowDay.arrived++;
      } else if (log.action == 'move' || log.action == 'update') {
        final newStatus = _getNewStatusFromChanges(log.changes);
        if (newStatus != null && doneColumnIds.contains(newStatus)) {
          flowDay.completed++;
        }
      }
    }

    int totalArrived = 0;
    int totalCompleted = 0;
    final flowDataPoints = <FlowDataPoint>[];

    for (final entry in dailyData.entries.toList()..sort((a, b) => a.key.compareTo(b.key))) {
      totalArrived += entry.value.arrived;
      totalCompleted += entry.value.completed;
      flowDataPoints.add(FlowDataPoint(
        date: entry.key,
        arrived: entry.value.arrived,
        completed: entry.value.completed,
      ));
    }

    return FlowMetrics(
      arrivedCount: totalArrived,
      completedCount: totalCompleted,
      arrivalRate: totalArrived / periodDays,
      completionRate: totalCompleted / periodDays,
      periodDays: periodDays,
      dailyData: flowDataPoints,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BOTTLENECK DETECTION
  // ═══════════════════════════════════════════════════════════════════════════

  List<BottleneckInfo> _detectBottlenecks(
    List<_TaskSnapshotDetailed> currentTasks,
    List<TodoColumn> columns,
    Set<String> doneColumnIds,
    Set<String> todoColumnIds,
    List<_AuditLogEntry> auditLogs,
  ) {
    final bottlenecks = <BottleneckInfo>[];

    // Get work-in-progress columns (not todo, not done)
    final wipColumns = columns.where((c) =>
      !todoColumnIds.contains(c.id) && !doneColumnIds.contains(c.id)
    ).toList();

    if (wipColumns.isEmpty) return bottlenecks;

    // Track start times for age calculation
    final taskStartTimes = <String, DateTime>{};
    for (final log in auditLogs) {
      if (log.action == 'move' || log.action == 'update') {
        final previousStatus = _getPreviousStatusFromChanges(log.changes);
        final newStatus = _getNewStatusFromChanges(log.changes);

        if (previousStatus != null && todoColumnIds.contains(previousStatus) &&
            newStatus != null && !todoColumnIds.contains(newStatus)) {
          if (!taskStartTimes.containsKey(log.entityId)) {
            taskStartTimes[log.entityId] = log.timestamp;
          }
        }
      }
    }

    final now = DateTime.now();

    for (final column in wipColumns) {
      final tasksInColumn = currentTasks.where((t) => t.statusId == column.id).toList();

      if (tasksInColumn.isEmpty) continue;

      // Calculate average age
      double totalAge = 0;
      for (final task in tasksInColumn) {
        final startTime = taskStartTimes[task.id] ?? task.createdAt;
        totalAge += now.difference(startTime).inHours / 24.0;
      }
      final averageAge = totalAge / tasksInColumn.length;

      // Calculate severity based on count and age
      // Higher count + higher age = higher severity
      final countScore = tasksInColumn.length / 10.0; // Normalize
      final ageScore = averageAge / 7.0; // Normalize to week
      final severity = ((countScore + ageScore) / 2).clamp(0.0, 1.0);

      if (tasksInColumn.length >= 2 || averageAge > 2) {
        bottlenecks.add(BottleneckInfo(
          columnId: column.id,
          columnTitle: column.title,
          taskCount: tasksInColumn.length,
          averageAgeDays: averageAge,
          severity: severity,
        ));
      }
    }

    // Sort by severity descending
    bottlenecks.sort((a, b) => b.severity.compareTo(a.severity));

    return bottlenecks;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TEAM BALANCE CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  TeamBalanceMetrics _calculateTeamBalance(
    List<_TaskSnapshotDetailed> currentTasks,
    List<TodoColumn> columns,
    Set<String> doneColumnIds,
    Set<String> todoColumnIds,
  ) {
    // Group tasks by assignee
    final memberTasks = <String, List<_TaskSnapshotDetailed>>{};

    for (final task in currentTasks) {
      if (task.assignedTo.isEmpty) {
        // Unassigned tasks
        memberTasks.putIfAbsent('_unassigned_', () => []).add(task);
      } else {
        for (final assignee in task.assignedTo) {
          memberTasks.putIfAbsent(assignee, () => []).add(task);
        }
      }
    }

    if (memberTasks.isEmpty) {
      return TeamBalanceMetrics.empty;
    }

    final members = <MemberWorkload>[];
    int totalAssignedTasks = 0;

    for (final entry in memberTasks.entries) {
      final email = entry.key;
      final tasks = entry.value;

      // Count by column type
      int todoCount = 0;
      int wipCount = 0;
      int doneCount = 0;
      final tasksByColumn = <String, int>{};

      for (final task in tasks) {
        final columnId = task.statusId;
        tasksByColumn[columnId] = (tasksByColumn[columnId] ?? 0) + 1;

        if (todoColumnIds.contains(columnId)) {
          todoCount++;
        } else if (doneColumnIds.contains(columnId)) {
          doneCount++;
        } else {
          wipCount++;
        }
      }

      members.add(MemberWorkload(
        email: email,
        displayName: email == '_unassigned_' ? 'Unassigned' : _formatDisplayName(email),
        totalTasks: tasks.length,
        tasksByColumn: tasksByColumn,
        todoCount: todoCount,
        wipCount: wipCount,
        doneCount: doneCount,
      ));

      if (email != '_unassigned_') {
        totalAssignedTasks += tasks.length;
      }
    }

    // Sort by total tasks descending
    members.sort((a, b) => b.totalTasks.compareTo(a.totalTasks));

    // Calculate balance score using coefficient of variation
    // Score of 1.0 = perfectly balanced, 0.0 = very imbalanced
    final assignedMembers = members.where((m) => m.email != '_unassigned_').toList();
    double balanceScore = 1.0;

    if (assignedMembers.length > 1) {
      final taskCounts = assignedMembers.map((m) => m.totalTasks.toDouble()).toList();
      final mean = taskCounts.reduce((a, b) => a + b) / taskCounts.length;

      if (mean > 0) {
        final variance = taskCounts.map((x) => (x - mean) * (x - mean)).reduce((a, b) => a + b) / taskCounts.length;
        final stdDev = variance > 0 ? sqrt(variance) : 0.0;
        final cv = stdDev / mean; // Coefficient of variation

        // Convert CV to score: CV of 0 = score 1.0, CV of 1+ = score ~0
        balanceScore = 1.0 / (1.0 + cv);
      }
    }

    return TeamBalanceMetrics(
      members: members,
      totalTasks: currentTasks.length,
      balanceScore: balanceScore,
    );
  }

  String _formatDisplayName(String email) {
    // Convert email to display name
    final name = email.split('@').first;
    return name.split('.').map((part) =>
      part.isNotEmpty ? '${part[0].toUpperCase()}${part.substring(1)}' : part
    ).join(' ');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CHART DATA CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════

  CfdChartData _calculateChartData(
    DateTime startDate,
    DateTime endDate,
    List<_AuditLogEntry> auditLogs,
    List<_TaskSnapshotDetailed> currentTasks,
    List<TodoColumn> columns,
  ) {
    final dataPoints = <CfdDataPoint>[];

    DateTime currentDate = startDate;
    while (!currentDate.isAfter(endDate)) {
      final dayEnd = DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);

      final columnCounts = _calculateTaskCountsAtDate(
        dayEnd,
        auditLogs,
        currentTasks,
        columns,
      );

      dataPoints.add(CfdDataPoint(
        date: currentDate,
        columnCounts: columnCounts,
      ));

      currentDate = currentDate.add(const Duration(days: 1));
    }

    return CfdChartData(
      dataPoints: dataPoints,
      columns: columns,
      startDate: startDate,
      endDate: endDate,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DATA FETCHING
  // ═══════════════════════════════════════════════════════════════════════════

  Future<List<_AuditLogEntry>> _getAuditLogs(String listId) async {
    try {
      final snapshot = await _firestore
          .collection(_listsCollection)
          .doc(listId)
          .collection(_auditSubcollection)
          .where('entityType', isEqualTo: 'task')
          .orderBy('timestamp', descending: false)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return _AuditLogEntry(
          entityId: data['entityId'] ?? '',
          entityName: data['entityName'],
          action: data['action'] ?? '',
          timestamp: _parseTimestamp(data['timestamp']),
          changes: List<Map<String, dynamic>>.from(data['changes'] ?? []),
        );
      }).toList();
    } catch (e) {
      print('CFD: Error fetching audit logs: $e');
      return [];
    }
  }

  Future<List<_TaskSnapshotDetailed>> _getCurrentTasksDetailed(String listId) async {
    try {
      final snapshot = await _firestore
          .collection(_listsCollection)
          .doc(listId)
          .collection(_tasksSubcollection)
          .where('isArchived', isEqualTo: false)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return _TaskSnapshotDetailed(
          id: doc.id,
          title: data['title'] ?? '',
          statusId: data['statusId'] ?? 'todo',
          createdAt: _parseTimestamp(data['createdAt']),
          assignedTo: List<String>.from(data['assignedTo'] ?? []),
        );
      }).toList();
    } catch (e) {
      print('CFD: Error fetching tasks: $e');
      return [];
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  Map<String, int> _calculateTaskCountsAtDate(
    DateTime targetDate,
    List<_AuditLogEntry> allLogs,
    List<_TaskSnapshotDetailed> currentTasks,
    List<TodoColumn> columns,
  ) {
    final counts = <String, int>{};
    for (final col in columns) {
      counts[col.id] = 0;
    }

    final taskStates = <String, String>{};

    // Start with current tasks
    for (final task in currentTasks) {
      if (task.createdAt.isAfter(targetDate)) continue;
      taskStates[task.id] = task.statusId;
    }

    // Reverse audit logs after target date
    final logsAfterTarget = allLogs.where((log) => log.timestamp.isAfter(targetDate)).toList();

    for (final log in logsAfterTarget.reversed) {
      final taskId = log.entityId;

      if (log.action == 'create') {
        taskStates.remove(taskId);
      } else if (log.action == 'delete') {
        final earlierLogs = allLogs.where(
          (l) => l.entityId == taskId && !l.timestamp.isAfter(targetDate)
        ).toList();

        if (earlierLogs.isNotEmpty) {
          String? lastStatus;
          for (final earlierLog in earlierLogs.reversed) {
            if (earlierLog.action == 'create') {
              lastStatus = _getStatusFromChanges(earlierLog.changes) ?? 'todo';
              break;
            } else if (earlierLog.action == 'move' || earlierLog.action == 'update') {
              final newStatus = _getNewStatusFromChanges(earlierLog.changes);
              if (newStatus != null) {
                lastStatus = newStatus;
                break;
              }
            }
          }
          if (lastStatus != null) {
            taskStates[taskId] = lastStatus;
          }
        }
      } else if (log.action == 'move' || log.action == 'update') {
        final previousStatus = _getPreviousStatusFromChanges(log.changes);
        if (previousStatus != null && taskStates.containsKey(taskId)) {
          taskStates[taskId] = previousStatus;
        }
      }
    }

    // Handle tasks from create logs
    final createLogs = allLogs.where(
      (log) => log.action == 'create' && !log.timestamp.isAfter(targetDate)
    ).toList();

    for (final createLog in createLogs) {
      if (!taskStates.containsKey(createLog.entityId)) {
        final taskLogs = allLogs.where(
          (l) => l.entityId == createLog.entityId && !l.timestamp.isAfter(targetDate)
        ).toList();

        String status = 'todo';
        for (final log in taskLogs) {
          if (log.action == 'create') {
            status = _getStatusFromChanges(log.changes) ?? 'todo';
          } else if (log.action == 'move' || log.action == 'update') {
            final newStatus = _getNewStatusFromChanges(log.changes);
            if (newStatus != null) {
              status = newStatus;
            }
          } else if (log.action == 'delete') {
            status = '';
            break;
          }
        }

        if (status.isNotEmpty) {
          taskStates[createLog.entityId] = status;
        }
      }
    }

    // Count tasks by column
    for (final entry in taskStates.entries) {
      final statusId = entry.value;
      if (counts.containsKey(statusId)) {
        counts[statusId] = counts[statusId]! + 1;
      } else if (columns.isNotEmpty) {
        counts[columns.first.id] = counts[columns.first.id]! + 1;
      }
    }

    return counts;
  }

  String? _getStatusFromChanges(List<Map<String, dynamic>> changes) {
    for (final change in changes) {
      if (change['field'] == 'statusId') {
        return change['newValue']?.toString();
      }
    }
    return null;
  }

  String? _getNewStatusFromChanges(List<Map<String, dynamic>> changes) {
    for (final change in changes) {
      if (change['field'] == 'statusId') {
        return change['newValue']?.toString();
      }
    }
    return null;
  }

  String? _getPreviousStatusFromChanges(List<Map<String, dynamic>> changes) {
    for (final change in changes) {
      if (change['field'] == 'statusId') {
        return change['previousValue']?.toString();
      }
    }
    return null;
  }

  DateTime _parseTimestamp(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    if (value.runtimeType.toString() == 'Timestamp') {
      return (value as dynamic).toDate();
    }
    return DateTime.now();
  }

  double _calculateMedian(List<double> sortedList) {
    if (sortedList.isEmpty) return 0;
    final middle = sortedList.length ~/ 2;
    if (sortedList.length % 2 == 0) {
      return (sortedList[middle - 1] + sortedList[middle]) / 2;
    }
    return sortedList[middle];
  }

  double _calculatePercentile(List<double> sortedList, int percentile) {
    if (sortedList.isEmpty) return 0;
    final index = ((percentile / 100) * (sortedList.length - 1)).round();
    return sortedList[index.clamp(0, sortedList.length - 1)];
  }
}

/// Internal helper class for flow tracking
class _FlowDay {
  int arrived = 0;
  int completed = 0;
}

/// Internal class for audit log entries
class _AuditLogEntry {
  final String entityId;
  final String? entityName;
  final String action;
  final DateTime timestamp;
  final List<Map<String, dynamic>> changes;

  _AuditLogEntry({
    required this.entityId,
    this.entityName,
    required this.action,
    required this.timestamp,
    required this.changes,
  });
}

/// Internal class for task snapshots with details
class _TaskSnapshotDetailed {
  final String id;
  final String title;
  final String statusId;
  final DateTime createdAt;
  final List<String> assignedTo;

  _TaskSnapshotDetailed({
    required this.id,
    required this.title,
    required this.statusId,
    required this.createdAt,
    required this.assignedTo,
  });
}
