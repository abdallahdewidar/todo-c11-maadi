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
  DateTime selecteddate=DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context);
    AuthUserProvider provideruser= Provider.of<AuthUserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(

            firstDate: DateTime.now(),
            dayProps: EasyDayProps(
              inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Colors.white
                )
              ),
              todayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: Colors.transparent
                )
              ),
            ),
            focusDate: selecteddate,
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateChange: (newselectedDate) {
setState(() {
  selecteddate=DateTime(
    newselectedDate.year,
    newselectedDate.month,
    newselectedDate.day,
  );
});
            },
          ),

    Expanded(
      child: StreamBuilder(
      stream: TaskCollection.newGetTasks(provideruser.firebaseUser!.uid,selecteddate),
      builder: (context,snapshot){
      if(snapshot.connectionState==ConnectionState.waiting){
      return const Center(child:  CircularProgressIndicator(),);
      }
      else if (snapshot.hasError){
      return Center(child: Text(snapshot.error!.toString()));
      }
      else
      {
      List<Task>tasks=snapshot.data??[];
      return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
      itemBuilder: (context, index) {
      return ToDoWidget(task: tasks[index]);
      },
      separatorBuilder: (context, index) {
      return const SizedBox(
      height: 10,
      );
      },
      itemCount: tasks.length),
      );}
      }),
    )]
            ),


      );

  }
}
