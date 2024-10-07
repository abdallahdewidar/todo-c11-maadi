import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:todo_c11_maadi/firebase/user_collection.dart';

import 'model/Task.dart';

class TaskCollection{

  static CollectionReference<Task> getTaskCollection(String userId){
    var userCollection = UserCollection.getUserCollectionReference();
    var userDoc = userCollection.doc(userId);
    var taskCollection = userDoc.collection(Task.collectionName).withConverter(
        fromFirestore: (snapshot, options) {
          return Task.fromFireStore(snapshot.data());
        },
        toFirestore: (task, options) {
          return task.toFireStore();
        },
    );
    return taskCollection;
  }

  static Future<void> createTask(String userId,Task newTask)async{
    var collectionRef = getTaskCollection(userId);
    var docRef = collectionRef.doc();
    newTask.id = docRef.id;
    await docRef.set(newTask);
  }

  static Future<List<Task>> getTasks(String userId)async{
    var collectionRef = getTaskCollection(userId);
    var snapshot = await collectionRef.get();
    List<Task> tasks = snapshot.docs.map((snapshot) => snapshot.data()).toList();
    return tasks;
  }
  static Future<void> deleteTask(String userId,String taskId)async{
    var collectionRef = getTaskCollection(userId);
    var docRef = collectionRef.doc(taskId);
    await docRef.delete();
  }
  static Future<void> upadatetaskformfirestore({required String userId,required Task task}){
    return getTaskCollection(userId).doc(task.id).update(task.toFireStore()); }
  static Stream<List<Task>>newGetTasks(String userId,DateTime date)async*{
    var collectionRef = getTaskCollection(userId);
    var snapshot = collectionRef.where("date",isGreaterThanOrEqualTo:  Timestamp.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch),
    isLessThan:  Timestamp.fromMillisecondsSinceEpoch(date.add(Duration(days: 1)).millisecondsSinceEpoch)).snapshots();
    var queryDocList=snapshot.map((snapshotOfTask)=>snapshotOfTask.docs);
    var tasks=queryDocList.map((document)=>document.map((docs) => docs.data()).toList());
    yield* tasks;
  }

}
