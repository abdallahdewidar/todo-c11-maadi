import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/style/reusable_components/CustomFormField.dart';
import 'package:todo_c11_maadi/ui/home/widgets/AddTaskSheet.dart';

import '../../../firebase/model/Task.dart';
import '../../../firebase/task_collection.dart';
import '../../../style/appstyle.dart';
import '../../../style/dialog_utils.dart';
import '../../AuthProvider.dart';

class Edittask extends StatefulWidget {
  static const String routeName = "edit";

   Edittask({Key? key}) : super(key: key);

  @override
  State<Edittask> createState() => _EdittaskState();
}


class _EdittaskState extends State<Edittask> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  late DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    Task task = ModalRoute.of(context)!.settings.arguments as Task;
    if (title.text.isEmpty || description.text.isEmpty || selectedDate == null) {
      title.text = task.title ?? "";
      description.text = task.description ?? "";
      selectedDate = DateTime.fromMillisecondsSinceEpoch(task.date!.millisecondsSinceEpoch);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task", style: Appstyle.lightTheme.textTheme.titleLarge?.copyWith(color: Colors.white)),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edit Task",
              style: Appstyle.lightTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            CustomFormField(
              label: "Enter Task Title",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title can't be empty";
                }
                return null;
              },
              controller: title,
            ),
            CustomFormField(
              lines: 1,
              type: TextInputType.multiline,
              label: "Description",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description can't be empty";
                }
                return null;
              },
              controller: description,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Date",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).textTheme.titleLarge?.color ?? Appstyle.lightTextColor,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate!,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (newDate != null) {
                  selectedDate = newDate;
                  setState(() {});
                }
              },
              child: Text(
                "${selectedDate!.day} / ${selectedDate!.month} / ${selectedDate!.year}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  var provider = Provider.of<AuthUserProvider>(context, listen: false);
                  Task newTask = Task(
                    title: title.text,
                    description: description.text,
                    date: Timestamp.fromMillisecondsSinceEpoch(selectedDate!.millisecondsSinceEpoch),
                    id: task.id,
                    isDone: task.isDone,
                  );
                  TaskCollection.upadatetaskformfirestore(userId: provider.firebaseUser!.uid, task: newTask);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Edit"),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom * 1.1),
          ],
        ),
      ),
    );
  }
}
