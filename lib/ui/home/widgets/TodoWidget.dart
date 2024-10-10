import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/firebase/task_collection.dart';
import 'package:todo_c11_maadi/style/appstyle.dart';
import 'package:todo_c11_maadi/style/dialog_utils.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';
import 'package:todo_c11_maadi/ui/home/widgets/edit%20task.dart';

import '../../../firebase/model/Task.dart';

class ToDoWidget extends StatefulWidget {
  Task task;
  ToDoWidget({super.key, required this.task});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkMode = theme.brightness == Brightness.dark;

    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask();
            },
            icon: Icons.delete,
            label: "Delete",
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, Edittask.routeName,
                  arguments: widget.task);
            },
            icon: Icons.edit_note,
            label: "Edit",
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 27, horizontal: 17),
        decoration: BoxDecoration(
          color: isDarkMode ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.task.isDone == true
                      ? Colors.green
                      : theme.colorScheme.primary,
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title ?? "",
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${widget.task.description}" ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isDarkMode
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.primary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: theme.iconTheme.color,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${widget.task.date?.toDate().hour ?? 'no hour'}:${widget.task.date?.toDate().minute ?? 'no minute'}",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  var provider = Provider.of<AuthUserProvider>(context, listen: false);
                  widget.task = Task(
                    isDone: !(widget.task.isDone ?? false),
                    id: widget.task.id,
                    description: widget.task.description,
                    date: widget.task.date,
                    title: widget.task.title,
                  );
                  TaskCollection.upadatetaskformfirestore(
                    userId: provider.firebaseUser!.uid,
                    task: widget.task,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.task.isDone == true ? Colors.green : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: widget.task.isDone == true
                    ? Text("Done")
                    : Icon(Icons.check),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    var provider = Provider.of<AuthUserProvider>(context, listen: false);
    DialogUtils.showConfirmationDialog(
      context: context,
      message: "Are you sure you want to delete this task?",
      onPositivePress: () async {
        Navigator.pop(context);
        DialogUtils.showLoadingDialog(context: context);
        await TaskCollection.deleteTask(provider.firebaseUser!.uid, widget.task.id ?? "");
        Navigator.pop(context);
      },
      onNegativePress: () {
        Navigator.pop(context);
      },
    );
  }
}