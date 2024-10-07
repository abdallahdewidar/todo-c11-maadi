import 'package:flutter/cupertino.dart';

import 'firebase/model/Task.dart';
import 'firebase/task_collection.dart';

class TodoProvider extends ChangeNotifier{
  List<Task>taskeslist=[];
  bool isloading=false;
  String taskserror="";
  refreshtask(String uid)async{
      try{
        isloading=true;
        notifyListeners();
    taskeslist= await TaskCollection.getTasks(uid);
    isloading=false;
    notifyListeners();
  }catch(eror){
taskserror=eror.toString();
isloading=false;
notifyListeners();
      }
}
}