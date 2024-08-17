import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/User.dart';

class UserCollection{

  static CollectionReference<User> getUserCollectionReference(){
    var database = FirebaseFirestore.instance;
    var collectionReference = database.collection(User.collectionName).withConverter(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFirestore(),
    );
    return collectionReference;
  }
  static Future<void> createUser(String userId,User user){
    var userCollectionReference = getUserCollectionReference();
    return userCollectionReference.doc(userId).set(user);

  }
  static Future<User?> getUser(String userid)async{
    var userCollectionReference = getUserCollectionReference();
    var snapshot = await userCollectionReference.doc(userid).get();
    return snapshot.data();
  }
}