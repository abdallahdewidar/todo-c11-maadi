import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/Todo%20provonidor.dart';
import 'package:todo_c11_maadi/firebase/task_collection.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';

import '../../../firebase/model/Task.dart';
import '../widgets/TodoWidget.dart';

class TasksTab extends StatefulWidget {
   TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    AuthUserProvider authProvider = Provider.of<AuthUserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDatePicker(),
          _buildTaskList(authProvider),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return EasyInfiniteDateTimeLine(
      firstDate: DateTime.now(),
      dayProps: EasyDayProps(
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        todayStyle: DayStyle(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      focusDate: selectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
      onDateChange: (newSelectedDate) {
        setState(() {
          selectedDate = newSelectedDate;
        });
      },
    );
  }

  Widget _buildTaskList(AuthUserProvider authProvider) {
    return Expanded(
      child: StreamBuilder<List<Task>>(
        stream: TaskCollection.newGetTasks(authProvider.firebaseUser!.uid, selectedDate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            List<Task> tasks = snapshot.data ?? [];
            return _taskListView(tasks);
          }
        },
      ),
    );
  }

  Widget _taskListView(List<Task> tasks) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ToDoWidget(task: tasks[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 10);
        },
        itemCount: tasks.length,
      ),
    );
  }
}
