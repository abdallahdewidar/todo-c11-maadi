import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/firebase/model/Task.dart';
import 'package:todo_c11_maadi/firebase/task_collection.dart';
import 'package:todo_c11_maadi/style/appstyle.dart';
import 'package:todo_c11_maadi/style/dialog_utils.dart';
import 'package:todo_c11_maadi/style/reusable_components/CustomFormField.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';

class AddTaskSheet extends StatefulWidget {
  AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add new Task",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Appstyle.lightTextColor
              ),),
              SizedBox(height: height*0.05,),
              CustomFormField(
                  label: "Title",
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "title can't be empty";
                    }
                    return null;
                  },
                  controller: titleController
              ),
              SizedBox(height: 10,),
              CustomFormField(
                lines: 4,
                  type: TextInputType.multiline,
                  label: "Description",
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "description can't be empty";
                    }
                    return null;
                  },
                  controller: descController
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Date",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Appstyle.lightTextColor
                ),),
              ),
              InkWell(
                onTap: (){
                  showDateCalender();
                },
                child: Text("${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey
                ),),
              ),
              SizedBox(height:height*0.05 ,),
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        addTask();
                      },
                      child: Text("Send"))),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom*1.1,)
            ],
          ),
        ),
      ),
    );
  }

  addTask()async{
    DialogUtils.showLoadingDialog(context: context);
    AuthUserProvider authProvider = Provider.of<AuthUserProvider>(context,listen: false);
    await TaskCollection.createTask(authProvider.firebaseUser!.uid, Task(
      title: titleController.text,
      description: descController.text,
      date: Timestamp.fromMillisecondsSinceEpoch(selectedDate.millisecondsSinceEpoch)
    ));
    Navigator.pop(context);
    DialogUtils.showMessageDialog(
        context: context,
        message: "Task Created successfully",
        onPress: (){
          Navigator.pop(context);
          Navigator.pop(context);
        });
  }
  showDateCalender()async{
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if(newDate!=null){
      selectedDate = newDate;
      setState(() {

      });
    }
  }
}
