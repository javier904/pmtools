import 'dart:async';
import 'package:agile_tools/models/retrospective_model.dart';
import 'package:agile_tools/services/retrospective_firestore_service.dart';
import 'package:flutter/material.dart';

class RetroTimerWidget extends StatefulWidget {
  final String retroId;
  final RetroTimer timer;
  final bool isFacilitator;

  const RetroTimerWidget({
    Key? key,
    required this.retroId,
    required this.timer,
    required this.isFacilitator,
  }) : super(key: key);

  @override
  State<RetroTimerWidget> createState() => _RetroTimerWidgetState();
}

class _RetroTimerWidgetState extends State<RetroTimerWidget> {
  Timer? _localTicker;
  Duration _remaining = Duration.zero;
  bool _alertShown = false;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _startTicker();
  }

  @override
  void didUpdateWidget(covariant RetroTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.timer.endTime != oldWidget.timer.endTime || widget.timer.isRunning != oldWidget.timer.isRunning) {
      _alertShown = false; // Reset alert for new timer session
      _updateTime();
    }
  }

  @override
  void dispose() {
    _localTicker?.cancel();
    super.dispose();
  }

  void _startTicker() {
    _localTicker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.timer.isActive) {
        setState(() {
          _updateTime();
        });
        
        // Alert if time is up
        if ((_remaining.inSeconds <= 0) && !_alertShown && widget.isFacilitator) {
           _alertShown = true;
           _showTimeUpDialog();
        }
      }
    });
  }

  void _showTimeUpDialog() {
    // Post-frame callback to avoid build conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('⏰ Tempo Scaduto!', style: TextStyle(color: Colors.red)),
            content: const Text('Il tempo per questa fase è terminato. Concludi la discussione o estendi il tempo.'),
            actions: [
              TextButton(
                onPressed: () {
                   Navigator.pop(context);
                   // Optional: Extend time?
                },
                child: const Text('Ok, ho capito'),
              ),
            ],
          ),
        );
      }
    });
  }

  void _updateTime() {
    if (widget.timer.isActive) {
      _remaining = widget.timer.remaining;
      // Allow negative for "overdue"
    } else {
      _remaining = Duration(minutes: widget.timer.durationMinutes);
    }
  }

  String _formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final isNegative = seconds < 0;
    if (isNegative) seconds = -seconds;
    
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "${isNegative ? '-' : ''}$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRunning = widget.timer.isActive;
    final isOver = isRunning && _remaining.inSeconds <= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isOver ? Colors.red.withOpacity(0.1) : theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isOver ? Colors.red : theme.dividerColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 16,
            color: isOver ? Colors.red : theme.primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            _formatDuration(_remaining),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isOver ? Colors.red : theme.textTheme.bodyMedium?.color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          if (widget.isFacilitator) ...[
            const SizedBox(width: 8),
            _buildControls(context, isRunning),
          ]
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context, bool isRunning) {
    if (isRunning) {
      return InkWell(
        onTap: () => RetrospectiveFirestoreService().stopTimer(widget.retroId),
        child: const Tooltip(
           message: 'Stop Timer',
           child: Icon(Icons.stop_circle_outlined, size: 20, color: Colors.red),
        ),
      );
    } else {
      return PopupMenuButton<int>(
        tooltip: 'Start Timer',
        icon: const Icon(Icons.play_circle_outline, size: 20, color: Colors.green),
        onSelected: (minutes) {
          RetrospectiveFirestoreService().startTimer(widget.retroId, minutes);
        },
        itemBuilder: (context) => [
          const PopupMenuItem(value: 5, child: Text('5 Min')),
          const PopupMenuItem(value: 10, child: Text('10 Min')),
          const PopupMenuItem(value: 15, child: Text('15 Min')),
          const PopupMenuItem(value: 20, child: Text('20 Min')),
          const PopupMenuItem(value: 30, child: Text('30 Min')),
        ],
      );
    }
  }
}
