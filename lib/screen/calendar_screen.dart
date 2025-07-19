import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_casey/const/weekend_list.dart';
import 'package:my_casey/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class CalendarMemo {
  final String id;
  final String content;
  final DateTime createdAt;
  final TimeOfDay? scheduledTime;

  CalendarMemo({
    required this.id,
    required this.content,
    required this.createdAt,
    this.scheduledTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'scheduledTime': scheduledTime != null 
          ? {'hour': scheduledTime!.hour, 'minute': scheduledTime!.minute}
          : null,
    };
  }

  factory CalendarMemo.fromJson(Map<String, dynamic> json) {
    TimeOfDay? scheduledTime;
    if (json['scheduledTime'] != null) {
      scheduledTime = TimeOfDay(
        hour: json['scheduledTime']['hour'],
        minute: json['scheduledTime']['minute'],
      );
    }
    
    return CalendarMemo(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      scheduledTime: scheduledTime,
    );
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();
  List<CalendarMemo> selectedDateMemos = [];
  final TextEditingController _memoController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    _loadMemosForDate(selectedDay!);
  }

  @override
  void dispose() {
    _memoController.dispose();
    super.dispose();
  }

  String _getDateKey(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> _loadMemosForDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'memo_${_getDateKey(date)}';
    final memoData = prefs.getString(key);
    
    if (memoData != null) {
      final List<dynamic> jsonList = json.decode(memoData);
      List<CalendarMemo> memos = jsonList.map((e) => CalendarMemo.fromJson(e)).toList();
      
      // 정렬: 시간 설정 안 한 것 먼저, 그 다음 시간 순
      memos.sort((a, b) {
        if (a.scheduledTime == null && b.scheduledTime == null) return 0;
        if (a.scheduledTime == null) return -1;
        if (b.scheduledTime == null) return 1;
        
        int aMinutes = a.scheduledTime!.hour * 60 + a.scheduledTime!.minute;
        int bMinutes = b.scheduledTime!.hour * 60 + b.scheduledTime!.minute;
        return aMinutes.compareTo(bMinutes);
      });
      
      setState(() {
        selectedDateMemos = memos;
      });
    } else {
      setState(() {
        selectedDateMemos = [];
      });
    }
  }

  Future<void> _saveMemosForDate(DateTime date, List<CalendarMemo> memos) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'memo_${_getDateKey(date)}';
    
    if (memos.isEmpty) {
      await prefs.remove(key);
    } else {
      final jsonList = memos.map((e) => e.toJson()).toList();
      await prefs.setString(key, json.encode(jsonList));
    }
  }

  void _addMemo() {
    if (_memoController.text.trim().isEmpty || selectedDay == null) return;

    final newMemo = CalendarMemo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: _memoController.text.trim(),
      createdAt: DateTime.now(),
      scheduledTime: _selectedTime,
    );

    setState(() {
      selectedDateMemos.add(newMemo);
    });

    _saveMemosForDate(selectedDay!, selectedDateMemos);
    _memoController.clear();
    _selectedTime = null;
    _loadMemosForDate(selectedDay!); // 정렬을 위해 다시 로드
  }

  Future<void> _selectTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: AppColors.surface,
              hourMinuteTextColor: AppColors.textPrimary,
              dayPeriodTextColor: AppColors.textPrimary,
              dialHandColor: AppColors.primary,
              dialTextColor: AppColors.textPrimary,
              entryModeIconColor: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  void _removeTime() {
    setState(() {
      _selectedTime = null;
    });
  }

  void _editMemo(CalendarMemo memo) {
    _memoController.text = memo.content;
    _selectedTime = memo.scheduledTime;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('memoEdit'.tr(), style: Theme.of(context).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _memoController,
                decoration: InputDecoration(
                  hintText: 'enterMemo'.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'setTime'.tr()} ${'timeOptional'.tr()}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_selectedTime != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.access_time, size: 16, color: AppColors.primary),
                                const SizedBox(width: 6),
                                Text(
                                  _selectedTime!.format(context),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => setDialogState(() => _removeTime()),
                                  child: Icon(Icons.close, size: 16, color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _selectTime();
                      setDialogState(() {});
                    },
                    icon: Icon(Icons.schedule, size: 16),
                    label: Text(_selectedTime == null ? 'selectTime'.tr() : 'selectTime'.tr()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceLight,
                      foregroundColor: AppColors.textPrimary,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _memoController.clear();
                _selectedTime = null;
                Navigator.pop(context);
              },
              child: Text('cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                if (_memoController.text.trim().isNotEmpty) {
                  setState(() {
                    final index = selectedDateMemos.indexWhere((m) => m.id == memo.id);
                    selectedDateMemos[index] = CalendarMemo(
                      id: memo.id,
                      content: _memoController.text.trim(),
                      createdAt: memo.createdAt,
                      scheduledTime: _selectedTime,
                    );
                  });
                  _saveMemosForDate(selectedDay!, selectedDateMemos);
                  _memoController.clear();
                  _selectedTime = null;
                  Navigator.pop(context);
                  _loadMemosForDate(selectedDay!); // 정렬을 위해 다시 로드
                }
              },
              child: Text('save'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteMemo(CalendarMemo memo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('memoDelete'.tr(), style: Theme.of(context).textTheme.titleLarge),
        content: Text('deleteMemoConfirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selectedDateMemos.removeWhere((m) => m.id == memo.id);
              });
              _saveMemosForDate(selectedDay!, selectedDateMemos);
              Navigator.pop(context);
            },
            child: Text('delete'.tr(), style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  Widget _buildMemoSection() {
    if (selectedDay == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 날짜 헤더
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.surfaceLight),
          ),
          child: Row(
            children: [
              Icon(Icons.event_note_rounded, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                selectedDay != null 
                    ? DateFormat.yMMMd(context.locale.languageCode).format(selectedDay!)
                    : DateFormat.yMMMd(context.locale.languageCode).format(DateTime.now()),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                'memoCount'.tr().replaceAll('{}', selectedDateMemos.length.toString()),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // 메모 추가 입력
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _memoController,
                      decoration: InputDecoration(
                        hintText: 'enterMemo'.tr(),
                        hintStyle: TextStyle(color: AppColors.textTertiary, fontSize: 14),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      onSubmitted: (_) => _addMemo(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _addMemo,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
              if (_selectedTime != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, size: 14, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            _selectedTime!.format(context),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: _removeTime,
                            child: Icon(Icons.close, size: 14, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: _selectTime,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.schedule, size: 14, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text(
                            'setTime'.tr(),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'timeOptional'.tr(),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // 메모 리스트 (스크롤 제거)
        if (selectedDateMemos.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.note_add_outlined,
                    size: 48,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'noMemos'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...selectedDateMemos.map((memo) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.surfaceLight),
            ),
            child: Row(
              children: [
                if (memo.scheduledTime != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      memo.scheduledTime!.format(context),
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    memo.content,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => _editMemo(memo),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.info.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.edit, size: 16, color: AppColors.info),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => _deleteMemo(memo),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.delete, size: 16, color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // 스크롤 가능하게 변경
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textPrimary.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TableCalendar(
                  firstDay: DateTime.utc(2023, 9, 1),
                  lastDay: DateTime.utc(2025, 9, 30),
                  focusedDay: focusedDay,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ) ?? const TextStyle(),
                    leftChevronIcon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    rightChevronIcon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.chevron_right,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    headerPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                    setState(() {
                      this.selectedDay = selectedDay;
                      this.focusedDay = selectedDay;
                    });
                    _loadMemosForDate(selectedDay);
                  },
                  selectedDayPredicate: (DateTime date) {
                    if (selectedDay == null) {
                      return false;
                    }

                    return date.year == selectedDay!.year
                        && date.month == selectedDay!.month
                        && date.day == selectedDay!.day;
                  },
                  calendarStyle: CalendarStyle(
                    weekendTextStyle: TextStyle(
                      color: AppColors.info,
                      fontWeight: FontWeight.w500,
                    ),
                    defaultTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ) ?? const TextStyle(),
                    selectedDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppColors.primaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.accentOrange.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accentOrange,
                        width: 2,
                      ),
                    ),
                    todayTextStyle: TextStyle(
                      color: AppColors.accentOrange,
                      fontWeight: FontWeight.w600,
                    ),
                    outsideDaysVisible: true,
                    outsideTextStyle: TextStyle(
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w400,
                    ),
                    cellMargin: const EdgeInsets.all(4),
                    cellPadding: const EdgeInsets.all(0),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ) ?? const TextStyle(),
                    weekendStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w600,
                    ) ?? const TextStyle(),
                  ),
                  calendarBuilders: CalendarBuilders(
                    dowBuilder: (context, day) {
                      if (day.weekday == DateTime.sunday) {
                        final text = DateFormat.E().format(day);

                        return Center(
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                      if (day.weekday == DateTime.saturday) {
                        final text = DateFormat.E().format(day);

                        return Center(
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.info,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }
                      return null;
                    },

                    defaultBuilder: (context, day, _) {
                      DateTime yesterday = day.subtract(const Duration(days: 1));
                      DateTime tomorrow = day.add(const Duration(days: 1));
                      bool isYesterdayWeekend = false;
                      bool isTodayWeekend = false;
                      bool isTomorrowWeekend = false;
                      
                      for (List<int> weekendDay in WEEKEND_LIST) {
                        if ((day.year == weekendDay[0] && day.month == weekendDay[1] && day.day == weekendDay[2]) || day.weekday == DateTime.saturday || day.weekday == DateTime.sunday) {
                          isTodayWeekend = true;
                          return Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.error.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                day.day.toString(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }

                        if ((yesterday.year == weekendDay[0] && yesterday.month == weekendDay[1] && yesterday.day == weekendDay[2]) || yesterday.weekday == DateTime.saturday || yesterday.weekday == DateTime.sunday) {
                          isYesterdayWeekend = true;
                        }

                        if ((tomorrow.year == weekendDay[0] && tomorrow.month == weekendDay[1] && tomorrow.day == weekendDay[2]) || tomorrow.weekday == DateTime.saturday || tomorrow.weekday == DateTime.sunday) {
                          isTomorrowWeekend = true;
                        }
                      }

                      if (!isTodayWeekend && !isYesterdayWeekend && isTomorrowWeekend) {
                        return Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withOpacity(0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryLight.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              day.day.toString(),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }

                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildMemoSection(),
          ],
        ),
      ),
    );
  }
}
