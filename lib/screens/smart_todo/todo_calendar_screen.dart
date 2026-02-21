import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../models/smart_todo/todo_task_model.dart';
import '../../models/smart_todo/todo_list_model.dart';
import '../../services/smart_todo_service.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/smart_todo/todo_task_dialog.dart';
import '../../themes/app_theme.dart';

class TodoCalendarScreen extends StatefulWidget {
  final TodoListModel list;
  final List<TodoTaskModel> tasks;
  
  const TodoCalendarScreen({
    super.key,
    required this.list,
    required this.tasks,
  });

  @override
  State<TodoCalendarScreen> createState() => _TodoCalendarScreenState();
}

class _TodoCalendarScreenState extends State<TodoCalendarScreen> {
  final SmartTodoService _todoService = SmartTodoService();
  final CalendarController _calendarController = CalendarController();

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) {
            final tasks = widget.tasks;
            
            // Map tasks to Calendar Appointments
            final appointments = tasks.where((t) => t.dueDate != null).map((task) {
               final start = task.dueDate!;
               final effort = task.effort ?? 1;
               final durationHours = effort < 1 ? 1 : (effort > 8 ? 8 : effort);
               final end = start.add(Duration(hours: durationHours));
               
               // Get color from status
               final statusCol = widget.list.columns.firstWhere(
                 (c) => c.id == task.statusId,
                 orElse: () => TodoColumn(id: task.statusId, title: task.statusId, colorValue: Colors.blue.value)
               );
               
               // If the task was created without a specific time (midnight), treat it as all-day 
               // so it becomes fully visible on the top row instead of hiding at 00:00.
               // Tasks that have a specific time (e.g. 10:00) but no effort will default to 1 hour and plot correctly in the grid.
               bool isAllDay = (start.hour == 0 && start.minute == 0);
               
               return Appointment(
                 startTime: start,
                 endTime: end,
                 subject: task.title,
                 color: Color(statusCol.colorValue),
                 notes: task.description,
                 id: task.id,
                 isAllDay: isAllDay,
               );
            }).toList();

            return Container(
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
              child: Theme(
                data: Theme.of(context).copyWith(
                  // SfCalendar uses ToggleButtons internally. Material 3 defines these via ToggleButtonsTheme and ColorScheme.
                  toggleButtonsTheme: ToggleButtonsThemeData(
                    selectedColor: Colors.white,
                    fillColor: Theme.of(context).primaryColor,
                    color: context.textSecondaryColor,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 13),
                    borderColor: context.borderColor,
                    selectedBorderColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Colors.white,
                    surface: context.surfaceColor,
                    onSurface: context.textPrimaryColor,
                    secondaryContainer: Theme.of(context).primaryColor,
                    onSecondaryContainer: Colors.white,
                  ),
                  textTheme: Theme.of(context).textTheme.copyWith(
                    labelLarge: TextStyle(color: context.textPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                child: SfCalendarTheme(
                  data: SfCalendarThemeData(
                    backgroundColor: context.surfaceColor,
                    headerTextStyle: TextStyle(color: context.textPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                    viewHeaderDayTextStyle: TextStyle(color: context.textSecondaryColor, fontWeight: FontWeight.w600, fontSize: 13, fontFamily: 'Inter'),
                    viewHeaderDateTextStyle: TextStyle(color: context.textPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                    timeTextStyle: TextStyle(color: context.textSecondaryColor, fontSize: 12, fontFamily: 'Inter'),
                  ),
                  child: SfCalendar(
                  controller: _calendarController,
                  view: CalendarView.week,
                  allowedViews: const [
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.workWeek,
                    CalendarView.month,
                  ],
                  dataSource: _TaskDataSource(appointments),
                  firstDayOfWeek: 1, // Monday
                  allowDragAndDrop: true,
                  allowAppointmentResize: true,
                  showNavigationArrow: true,
                  showDatePickerButton: true,
                  onDragEnd: (AppointmentDragEndDetails details) async {
                     final appointment = details.appointment as Appointment?;
                     if (appointment != null && details.droppingTime != null) {
                        try {
                           final droppedTask = tasks.firstWhere((t) => t.id == appointment.id);
                           final updatedTask = droppedTask.copyWith(
                             dueDate: details.droppingTime,
                           );
                           await _todoService.updateTask(widget.list.id, updatedTask);
                           if (context.mounted) {
                             final l10n = AppLocalizations.of(context);
                             ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text(l10n?.actionSave ?? 'Dati aggiornati'), backgroundColor: Colors.green),
                             );
                           }
                        } catch (e) {
                           // Handle error
                        }
                     }
                  },
                  onAppointmentResizeEnd: (AppointmentResizeEndDetails details) async {
                     final appointment = details.appointment as Appointment?;
                     if (appointment != null && details.endTime != null && details.startTime != null) {
                        try {
                           final resizedTask = tasks.firstWhere((t) => t.id == appointment.id);
                           // Calculate new effort in hours based on the difference
                           final difference = details.endTime!.difference(details.startTime!);
                           final newEffortHours = difference.inHours > 0 ? difference.inHours : 1;
                           
                           final updatedTask = resizedTask.copyWith(
                             effort: newEffortHours,
                           );
                           await _todoService.updateTask(widget.list.id, updatedTask);
                        } catch (e) {
                           // Handle error
                        }
                     }
                  },
                  onTap: (CalendarTapDetails details) {
                    if (details.targetElement == CalendarElement.appointment) {
                      final appointment = details.appointments?.first as Appointment?;
                      if (appointment != null) {
                        final tappedTask = tasks.firstWhere((t) => t.id == appointment.id);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => TodoTaskDialog(
                            listId: widget.list.id,
                            task: tappedTask,
                            listColumns: widget.list.columns,
                            participants: widget.list.participants,
                            listAvailableTags: widget.list.availableTags,
                          ),
                        );
                      }
                    } else if (details.targetElement == CalendarElement.calendarCell) {
                      // Tap on empty slot: quick creation with pre-filled date
                      final selectedDate = details.date;
                      if (selectedDate != null) {
                        final newTask = TodoTaskModel(
                          id: '',
                          listId: widget.list.id,
                          title: '',
                          statusId: widget.list.columns.isNotEmpty ? widget.list.columns.first.id : 'todo',
                          assignedTo: const [],
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => TodoTaskDialog(
                            listId: widget.list.id,
                            task: newTask,
                            listColumns: widget.list.columns,
                            participants: widget.list.participants,
                            listAvailableTags: widget.list.availableTags,
                          ),
                        );
                      }
                    }
                  },
                  cellBorderColor: context.borderColor,
                  todayHighlightColor: Theme.of(context).primaryColor,
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  timeSlotViewSettings: TimeSlotViewSettings(
                    timeTextStyle: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                    timeFormat: 'HH:mm',
                  ),
                  headerStyle: CalendarHeaderStyle(
                    textStyle: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  viewHeaderStyle: ViewHeaderStyle(
                    dayTextStyle: TextStyle(color: context.textSecondaryColor, fontWeight: FontWeight.w600, fontSize: 13, fontFamily: 'Inter'),
                    dateTextStyle: TextStyle(color: context.textPrimaryColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                  ),
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    showAgenda: true,
                  ),
                ),
                ),
              ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TaskDataSource extends CalendarDataSource {
  _TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}
