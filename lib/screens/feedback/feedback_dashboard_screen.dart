import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/feedback_model.dart';
import '../../services/feedback_service.dart';
import '../../services/auth_service.dart';
import '../../themes/app_colors.dart';
import 'package:intl/intl.dart';

class FeedbackDashboardScreen extends StatefulWidget {
  const FeedbackDashboardScreen({super.key});

  @override
  State<FeedbackDashboardScreen> createState() => _FeedbackDashboardScreenState();
}

class _FeedbackDashboardScreenState extends State<FeedbackDashboardScreen> {
  final _feedbackService = FeedbackService();
  final _authService = AuthService();
  
  bool _isAdmin = false;
  String? _currentUserEmail;

  @override
  void initState() {
    super.initState();
    final user = _authService.currentUser;
    _currentUserEmail = user?.email?.toLowerCase();
    // Identifica l'admin
    if (_currentUserEmail == 'leonardotorella4@gmail.com') {
      _isAdmin = true;
    }
  }

  Stream<List<FeedbackModel>> _getFeedbackStream() {
    if (_isAdmin) {
      return _feedbackService.getAllFeedback();
    } else if (_currentUserEmail != null) {
      return _feedbackService.getUserFeedback(_currentUserEmail!);
    }
    return Stream.value([]);
  }

  Color _getStatusColor(FeedbackStatus status) {
    switch (status) {
      case FeedbackStatus.newRequest:
        return Colors.blue;
      case FeedbackStatus.inProgress:
        return Colors.orange;
      case FeedbackStatus.resolved:
        return Colors.green;
      case FeedbackStatus.closed:
        return Colors.grey;
    }
  }

  String _getStatusTranslation(FeedbackStatus status, AppLocalizations l10n) {
    switch (status) {
      case FeedbackStatus.newRequest:
        return l10n.feedbackStatusNew;
      case FeedbackStatus.inProgress:
        return l10n.feedbackStatusInProgress;
      case FeedbackStatus.resolved:
        return l10n.feedbackStatusResolved;
      case FeedbackStatus.closed:
        return l10n.feedbackStatusClosed;
    }
  }

  Future<void> _updateStatus(FeedbackModel item, FeedbackStatus newStatus) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await _feedbackService.updateFeedbackStatus(item.id, newStatus);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Status updated to ${_getStatusTranslation(newStatus, l10n)}'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.feedbackError}: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isAdmin ? l10n.feedbackAdminTitle : l10n.feedbackHistory),
        elevation: 0,
      ),
      body: StreamBuilder<List<FeedbackModel>>(
        stream: _getFeedbackStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${l10n.feedbackError}: ${snapshot.error}',
                style: const TextStyle(color: AppColors.error),
              ),
            );
          }

          final feedbackList = snapshot.data ?? [];

          if (feedbackList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    l10n.feedbackNoRequests,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView.separated(
                padding: const EdgeInsets.all(24.0),
                itemCount: feedbackList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = feedbackList[index];
                  final isBug = item.type == FeedbackType.bug;
                  
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header 
                          Row(
                            children: [
                              Icon(
                                isBug ? Icons.bug_report_rounded : Icons.lightbulb_outline_rounded,
                                color: isBug ? Colors.red[400] : Colors.amber[600],
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.subject,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              // Status Chip
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(item.status).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getStatusColor(item.status).withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  _getStatusTranslation(item.status, l10n),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(item.status),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          
                          // Description
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.grey[300] : Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          
                          // Footer
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.access_time_rounded, size: 14, color: Colors.grey[500]),
                                  const SizedBox(width: 4),
                                  Text(
                                    DateFormat('dd MMM yyyy, HH:mm').format(item.createdAt),
                                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                              if (_isAdmin) ...[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.person, size: 14, color: Colors.grey[500]),
                                    const SizedBox(width: 4),
                                    Text(
                                      item.userEmail,
                                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                // Admin dropdown status change
                                Container(
                                  height: 28,
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<FeedbackStatus>(
                                      value: item.status,
                                      icon: const Icon(Icons.arrow_drop_down, size: 16),
                                      style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color),
                                      onChanged: (newStatus) {
                                        if (newStatus != null && newStatus != item.status) {
                                          _updateStatus(item, newStatus);
                                        }
                                      },
                                      items: FeedbackStatus.values.map((status) {
                                        return DropdownMenuItem<FeedbackStatus>(
                                          value: status,
                                          child: Text(_getStatusTranslation(status, l10n)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
