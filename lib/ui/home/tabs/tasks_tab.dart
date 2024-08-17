import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/firebase/task_collection.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';

import '../../../firebase/model/Task.dart';
import '../widgets/TodoWidget.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: TaskCollection.getTasks(provider.firebaseUser!.uid),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          List<Task> tasks = snapshot.data??[];
          return ListView.separated(
              itemBuilder: (context, index) => ToDoWidget(task: tasks[index],),
              separatorBuilder: (context, index) {
                return SizedBox(height: 20,);
              },
              itemCount: tasks.length);
        },
      ),
    );
  }
}
