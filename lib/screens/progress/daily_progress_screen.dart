import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitnesapp/models/daily_progress.dart';
import 'package:fitnesapp/services/daily_progress_service.dart';
import 'package:fitnesapp/screens/progress/daily_progress_form.dart';
import 'package:fitnesapp/widgets/date_selector.dart';

class DailyProgressScreen extends StatefulWidget {
  const DailyProgressScreen({super.key});

  @override
  _DailyProgressScreenState createState() => _DailyProgressScreenState();
}

class _DailyProgressScreenState extends State<DailyProgressScreen> {
  final DailyProgressService _service = DailyProgressService();
  List<DailyProgress> _progressList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDailyProgress();
  }

  Future<void> _fetchDailyProgress() async {
    try {
      final data = await _service.getAllDailyProgress();
      setState(() {
        _progressList = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching data: $e')));
    }
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
      appBar: AppBar(title: Text('Daily Progress')),
      body: Column(
        children: [
          const DateSelector(),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: _progressList.length,
                    itemBuilder: (context, index) {
                      final progress = _progressList[index];
                      return ListTile(
                        title: Text('Body Part: ${progress.bodyPart}'),
                        subtitle: Text(
                          'Date: ${DateFormat('yyyy-MM-dd').format(progress.date)}\n'
                          'Exercises: ${progress.doneExercise}/${progress.totalExercise}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProgress(progress.id),
                        ),
                        onTap: () => _navigateToForm(progress: progress),
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteProgress(int id) async {
    try {
      await _service.deleteDailyProgress(id);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Deleted successfully!')));
      _fetchDailyProgress();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting record: $e')));
    }
  }
}
