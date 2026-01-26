/// Comprehensive CFD Metrics Model for Smart Todo Analytics
/// Provides all data structures for Cumulative Flow Diagram analysis

/// Lead Time statistics - time from task creation to completion
class LeadTimeMetrics {
  final double averageDays;
  final double medianDays;
  final double percentile85Days;
  final double percentile95Days;
  final double minDays;
  final double maxDays;
  final int sampleSize;
  final double? previousPeriodAverage; // For trend comparison
  final List<LeadTimeDataPoint> dataPoints;

  const LeadTimeMetrics({
    required this.averageDays,
    required this.medianDays,
    required this.percentile85Days,
    required this.percentile95Days,
    required this.minDays,
    required this.maxDays,
    required this.sampleSize,
    this.previousPeriodAverage,
    this.dataPoints = const [],
  });

  /// Trend percentage compared to previous period
  double? get trendPercentage {
    if (previousPeriodAverage == null || previousPeriodAverage == 0) return null;
    return ((averageDays - previousPeriodAverage!) / previousPeriodAverage!) * 100;
  }

  /// Trend direction: -1 = improving (less time), 0 = stable, 1 = worsening
  int get trendDirection {
    final trend = trendPercentage;
    if (trend == null) return 0;
    if (trend < -5) return -1; // Improving (faster)
    if (trend > 5) return 1;   // Worsening (slower)
    return 0; // Stable
  }

  bool get hasData => sampleSize > 0;

  static const LeadTimeMetrics empty = LeadTimeMetrics(
    averageDays: 0,
    medianDays: 0,
    percentile85Days: 0,
    percentile95Days: 0,
    minDays: 0,
    maxDays: 0,
    sampleSize: 0,
  );
}

/// Individual lead time data point for charting
class LeadTimeDataPoint {
  final String taskId;
  final String taskTitle;
  final DateTime completedAt;
  final double leadTimeDays;

  const LeadTimeDataPoint({
    required this.taskId,
    required this.taskTitle,
    required this.completedAt,
    required this.leadTimeDays,
  });
}

/// Cycle Time statistics - time from work start to completion
class CycleTimeMetrics {
  final double averageDays;
  final double medianDays;
  final double percentile85Days;
  final double percentile95Days;
  final double minDays;
  final double maxDays;
  final int sampleSize;
  final double? previousPeriodAverage;
  final List<CycleTimeDataPoint> dataPoints;

  const CycleTimeMetrics({
    required this.averageDays,
    required this.medianDays,
    required this.percentile85Days,
    required this.percentile95Days,
    required this.minDays,
    required this.maxDays,
    required this.sampleSize,
    this.previousPeriodAverage,
    this.dataPoints = const [],
  });

  double? get trendPercentage {
    if (previousPeriodAverage == null || previousPeriodAverage == 0) return null;
    return ((averageDays - previousPeriodAverage!) / previousPeriodAverage!) * 100;
  }

  int get trendDirection {
    final trend = trendPercentage;
    if (trend == null) return 0;
    if (trend < -5) return -1;
    if (trend > 5) return 1;
    return 0;
  }

  bool get hasData => sampleSize > 0;

  static const CycleTimeMetrics empty = CycleTimeMetrics(
    averageDays: 0,
    medianDays: 0,
    percentile85Days: 0,
    percentile95Days: 0,
    minDays: 0,
    maxDays: 0,
    sampleSize: 0,
  );
}

/// Individual cycle time data point
class CycleTimeDataPoint {
  final String taskId;
  final String taskTitle;
  final DateTime startedAt;
  final DateTime completedAt;
  final double cycleTimeDays;

  const CycleTimeDataPoint({
    required this.taskId,
    required this.taskTitle,
    required this.startedAt,
    required this.completedAt,
    required this.cycleTimeDays,
  });
}

/// Throughput metrics - tasks completed per time period
class ThroughputMetrics {
  final double dailyAverage;
  final double weeklyAverage;
  final int totalCompleted;
  final int periodDays;
  final double? previousPeriodWeeklyAverage;
  final List<ThroughputDataPoint> dailyData;

  const ThroughputMetrics({
    required this.dailyAverage,
    required this.weeklyAverage,
    required this.totalCompleted,
    required this.periodDays,
    this.previousPeriodWeeklyAverage,
    this.dailyData = const [],
  });

  double? get trendPercentage {
    if (previousPeriodWeeklyAverage == null || previousPeriodWeeklyAverage == 0) return null;
    return ((weeklyAverage - previousPeriodWeeklyAverage!) / previousPeriodWeeklyAverage!) * 100;
  }

  int get trendDirection {
    final trend = trendPercentage;
    if (trend == null) return 0;
    if (trend > 5) return 1;  // Improving (more output)
    if (trend < -5) return -1; // Worsening (less output)
    return 0;
  }

  bool get hasData => totalCompleted > 0;

  static const ThroughputMetrics empty = ThroughputMetrics(
    dailyAverage: 0,
    weeklyAverage: 0,
    totalCompleted: 0,
    periodDays: 0,
  );
}

/// Daily throughput data point
class ThroughputDataPoint {
  final DateTime date;
  final int completed;

  const ThroughputDataPoint({
    required this.date,
    required this.completed,
  });
}

/// WIP (Work In Progress) metrics
class WipMetrics {
  final int totalWip;
  final int wipLimit; // Suggested limit based on team size
  final double averageAge;
  final Map<String, int> wipByColumn; // columnId -> count
  final List<AgingTask> agingTasks;

  const WipMetrics({
    required this.totalWip,
    required this.wipLimit,
    required this.averageAge,
    required this.wipByColumn,
    required this.agingTasks,
  });

  /// WIP status: ok, warning, critical
  WipStatus get status {
    if (wipLimit <= 0) return WipStatus.ok;
    final ratio = totalWip / wipLimit;
    if (ratio <= 0.8) return WipStatus.ok;
    if (ratio <= 1.0) return WipStatus.warning;
    return WipStatus.critical;
  }

  bool get hasData => totalWip > 0;

  static const WipMetrics empty = WipMetrics(
    totalWip: 0,
    wipLimit: 10,
    averageAge: 0,
    wipByColumn: {},
    agingTasks: [],
  );
}

enum WipStatus { ok, warning, critical }

/// Task currently in WIP with age information
class AgingTask {
  final String taskId;
  final String taskTitle;
  final String columnId;
  final String columnTitle;
  final DateTime startedAt;
  final double ageDays;
  final List<String> assignedTo;

  const AgingTask({
    required this.taskId,
    required this.taskTitle,
    required this.columnId,
    required this.columnTitle,
    required this.startedAt,
    required this.ageDays,
    this.assignedTo = const [],
  });

  /// Age status: ok (< 2 days), watch (2-5 days), aging (> 5 days)
  AgingStatus get status {
    if (ageDays < 2) return AgingStatus.ok;
    if (ageDays < 5) return AgingStatus.watch;
    return AgingStatus.aging;
  }
}

enum AgingStatus { ok, watch, aging }

/// Flow metrics - arrival rate vs completion rate
class FlowMetrics {
  final int arrivedCount;
  final int completedCount;
  final double arrivalRate; // per day
  final double completionRate; // per day
  final int periodDays;
  final List<FlowDataPoint> dailyData;

  const FlowMetrics({
    required this.arrivedCount,
    required this.completedCount,
    required this.arrivalRate,
    required this.completionRate,
    required this.periodDays,
    this.dailyData = const [],
  });

  /// Net flow: positive = backlog growing, negative = backlog shrinking
  int get netFlow => arrivedCount - completedCount;

  /// Flow balance status
  FlowStatus get status {
    if (netFlow <= 0) return FlowStatus.healthy;
    if (netFlow <= 3) return FlowStatus.growing;
    return FlowStatus.critical;
  }

  bool get hasData => arrivedCount > 0 || completedCount > 0;

  static const FlowMetrics empty = FlowMetrics(
    arrivedCount: 0,
    completedCount: 0,
    arrivalRate: 0,
    completionRate: 0,
    periodDays: 0,
  );
}

enum FlowStatus { healthy, growing, critical }

/// Daily flow data point
class FlowDataPoint {
  final DateTime date;
  final int arrived;
  final int completed;

  const FlowDataPoint({
    required this.date,
    required this.arrived,
    required this.completed,
  });

  int get netFlow => arrived - completed;
}

/// Bottleneck information for a column
class BottleneckInfo {
  final String columnId;
  final String columnTitle;
  final int taskCount;
  final double averageAgeDays;
  final double severity; // 0-1 scale

  const BottleneckInfo({
    required this.columnId,
    required this.columnTitle,
    required this.taskCount,
    required this.averageAgeDays,
    required this.severity,
  });

  /// Bottleneck severity level
  BottleneckSeverity get severityLevel {
    if (severity < 0.3) return BottleneckSeverity.low;
    if (severity < 0.6) return BottleneckSeverity.medium;
    return BottleneckSeverity.high;
  }
}

enum BottleneckSeverity { low, medium, high }

/// Team workload balance - task distribution per member
class TeamBalanceMetrics {
  final List<MemberWorkload> members;
  final int totalTasks;
  final double balanceScore; // 0-1, where 1 is perfectly balanced

  const TeamBalanceMetrics({
    required this.members,
    required this.totalTasks,
    required this.balanceScore,
  });

  bool get hasData => members.isNotEmpty;

  /// Balance status
  BalanceStatus get status {
    if (balanceScore >= 0.8) return BalanceStatus.balanced;
    if (balanceScore >= 0.5) return BalanceStatus.uneven;
    return BalanceStatus.imbalanced;
  }

  static const TeamBalanceMetrics empty = TeamBalanceMetrics(
    members: [],
    totalTasks: 0,
    balanceScore: 1.0,
  );
}

/// Workload for a single team member
class MemberWorkload {
  final String email;
  final String displayName;
  final int totalTasks;
  final Map<String, int> tasksByColumn; // columnId -> count
  final int todoCount;
  final int wipCount;
  final int doneCount;

  const MemberWorkload({
    required this.email,
    required this.displayName,
    required this.totalTasks,
    required this.tasksByColumn,
    required this.todoCount,
    required this.wipCount,
    required this.doneCount,
  });

  /// Workload level relative to average
  WorkloadLevel levelRelativeTo(double averageTasks) {
    if (averageTasks == 0) return WorkloadLevel.normal;
    final ratio = totalTasks / averageTasks;
    if (ratio < 0.5) return WorkloadLevel.low;
    if (ratio > 1.5) return WorkloadLevel.high;
    return WorkloadLevel.normal;
  }
}

enum BalanceStatus { balanced, uneven, imbalanced }
enum WorkloadLevel { low, normal, high }

/// Complete CFD Metrics container
class CfdMetrics {
  final LeadTimeMetrics leadTime;
  final CycleTimeMetrics cycleTime;
  final ThroughputMetrics throughput;
  final WipMetrics wip;
  final FlowMetrics flow;
  final List<BottleneckInfo> bottlenecks;
  final TeamBalanceMetrics teamBalance;
  final DateTime calculatedAt;
  final int periodDays;

  const CfdMetrics({
    required this.leadTime,
    required this.cycleTime,
    required this.throughput,
    required this.wip,
    required this.flow,
    required this.bottlenecks,
    required this.teamBalance,
    required this.calculatedAt,
    required this.periodDays,
  });

  /// Main bottleneck (highest severity)
  BottleneckInfo? get mainBottleneck {
    if (bottlenecks.isEmpty) return null;
    return bottlenecks.reduce((a, b) => a.severity > b.severity ? a : b);
  }

  bool get hasData => leadTime.hasData || cycleTime.hasData || throughput.hasData || wip.hasData || flow.hasData || teamBalance.hasData;

  static CfdMetrics empty = CfdMetrics(
    leadTime: LeadTimeMetrics.empty,
    cycleTime: CycleTimeMetrics.empty,
    throughput: ThroughputMetrics.empty,
    wip: WipMetrics.empty,
    flow: FlowMetrics.empty,
    bottlenecks: const [],
    teamBalance: TeamBalanceMetrics.empty,
    calculatedAt: DateTime.now(),
    periodDays: 0,
  );
}
