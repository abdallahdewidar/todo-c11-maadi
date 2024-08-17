import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/firebase/task_collection.dart';
import 'package:todo_c11_maadi/style/appstyle.dart';
import 'package:todo_c11_maadi/style/dialog_utils.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';

import '../../../firebase/model/Task.dart';

class ToDoWidget extends StatefulWidget {
  Task task;
  ToDoWidget({super.key,required this.task});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
          motion: BehindMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
                onPressed: (context){
                  deleteTask();
                },
                icon: Icons.delete,
                label: "Delete",
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20)
              ),
            )
          ]),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 27,
          horizontal: 17
        ),
        decoration: BoxDecoration(
          color: Colors.white,
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
                  color: Theme.of(context).colorScheme.primary
                ),
              ),
              SizedBox(width: 25,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.task.title??"",style: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(height: 5,),
                    Text("${widget.task.description}"??"",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Appstyle.lightTextColor,
                      fontSize: 14
                    ),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 5,),
                        Text("${widget.task.date?.toDate().hour??"no hour"} : ${widget.task.date?.toDate().minute??"no minute"}")
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  child: Icon(Icons.check))
            ],
          ),
        ),
      ),
    );
  }

  deleteTask(){
    var provider = Provider.of<AuthUserProvider>(context,listen: false);
    DialogUtils.showConfirmationDialog(context: context,
        message: "Are you sure you want to delete task?",
        onPositivePress: ()async{
          Navigator.pop(context);
          DialogUtils.showLoadingDialog(context: context);
          await TaskCollection.deleteTask(provider.firebaseUser!.uid,widget.task.id??"");
          Navigator.pop(context);
        },
        onNegativePress: (){
          Navigator.pop(context);
        }
    );
  }
}
