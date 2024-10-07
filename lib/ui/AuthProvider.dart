import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_c11_maadi/firebase/model/User.dart' as MyUser;
import 'package:flutter/material.dart';
import 'package:todo_c11_maadi/firebase/task_collection.dart';
import 'package:todo_c11_maadi/firebase/user_collection.dart';

import '../firebase/model/Task.dart';

class AuthUserProvider extends ChangeNotifier{
  User? firebaseUser;
  MyUser.User? databaseUser;

  setUsers(User newFirebaseUser , MyUser.User newDatabaseUser){
    firebaseUser = newFirebaseUser;
    databaseUser = newDatabaseUser;
    print("Set users");
    notifyListeners();
  }

  Future<void> retrieveUsersData()async{
    firebaseUser = FirebaseAuth.instance.currentUser;
    databaseUser = await UserCollection.getUser(firebaseUser?.uid??"");
    print(databaseUser?.email);
  }

}