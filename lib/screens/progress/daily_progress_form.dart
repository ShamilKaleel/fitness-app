
import 'package:flutter/material.dart';
import 'package:fitnesapp/models/daily_progress.dart';
import 'package:fitnesapp/services/daily_progress_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailyProgressForm extends StatefulWidget {
  final DailyProgress? progress;

  const DailyProgressForm({Key? key, this.progress}) : super(key: key);

  @override
  _DailyProgressFormState createState() => _DailyProgressFormState();
}

class _DailyProgressFormState extends State<DailyProgressForm> {
  final _formKey = GlobalKey<FormState>();
  final _service = DailyProgressService();

  late int _doneExercise;
  late int _totalExercise;
  late String _bodyPart;
  late DateTime _date;
  late String _userId;

  @override
  void initState() {
    super.initState();
    final progress = widget.progress;
    if (progress != null) {
      _doneExercise = progress.doneExercise;
      _totalExercise = progress.totalExercise;
      _bodyPart = progress.bodyPart;
      _date = progress.date;
      _userId = progress.userId;
    } else {
      _doneExercise = 0;
      _totalExercise = 0;
      _bodyPart = '';
      _date = DateTime.now();
      _userId = FirebaseAuth
          .instance.currentUser!.uid; // Default user ID (change as needed)
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final progress = DailyProgress(
          id: widget.progress?.id ?? DateTime.now().millisecondsSinceEpoch,
          doneExercise: _doneExercise,
          totalExercise: _totalExercise,
          date: _date,
          userId: _userId,
          bodyPart: _bodyPart,
        );
        if (widget.progress == null) {
          await _service.addDailyProgress(progress);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Added successfully!')));
        } else {
          await _service.updateDailyProgress(progress);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Updated successfully!')));
        }
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.progress == null ? 'Add Progress' : 'Edit Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _doneExercise.toString(),
                decoration: InputDecoration(labelText: 'Done Exercise'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter done exercises' : null,
                onSaved: (value) => _doneExercise = int.parse(value!),
              ),
              TextFormField(
                initialValue: _totalExercise.toString(),
                decoration: InputDecoration(labelText: 'Total Exercise'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter total exercises' : null,
                onSaved: (value) => _totalExercise = int.parse(value!),
              ),
              TextFormField(
                initialValue: _bodyPart,
                decoration: InputDecoration(labelText: 'Body Part'),
                validator: (value) => value!.isEmpty ? 'Enter body part' : null,
                onSaved: (value) => _bodyPart = value!,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.progress == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
