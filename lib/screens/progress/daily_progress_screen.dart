import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitnesapp/models/daily_progress.dart';
import 'package:fitnesapp/services/daily_progress_service.dart';
import 'package:fitnesapp/screens/progress/daily_progress_form.dart';
import 'package:fitnesapp/widgets/date_selector.dart';
import 'package:fitnesapp/widgets/progress_list_view.dart';

class DailyProgressScreen extends StatefulWidget {
  const DailyProgressScreen({super.key});

  @override
  State<DailyProgressScreen> createState() => _DailyProgressScreenState();
}

class _DailyProgressScreenState extends State<DailyProgressScreen> {
  final DailyProgressService _service = DailyProgressService();
  List<DailyProgress> _progressList = [];
  bool _isLoading = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchDailyProgress();
  }

  Future<void> _fetchDailyProgress() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _service.getDailyProgressByDate(_selectedDate);
      setState(() {
        _progressList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error fetching data:')));
    }
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _fetchDailyProgress(); // Fetch progress for the new date
  }

  void _navigateToForm({DailyProgress? progress}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DailyProgressForm(progress: progress),
      ),
    );
    if (result == true) {
      _fetchDailyProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Progress')),
      body: Column(
        children: [
          // Pass the callback for date change
          DateSelector(
            onDateChanged: _onDateChanged,
          ),
          _isLoading
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: _progressList.isEmpty
                      ? const Center(
                          child: Text(
                            'No progress for this date',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ProgressListView(
                          progressList: _progressList,
                          deleteProgress: _deleteProgress,
                        ),
                ),
        ],
      ),
    );
  }

  Future<void> _deleteProgress(int id) async {
    try {
      await _service.deleteDailyProgress(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Deleted successfully!'),
        behavior: SnackBarBehavior.floating, // Floating style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ));
      _fetchDailyProgress();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting record: $e')));
    }
  }
}
