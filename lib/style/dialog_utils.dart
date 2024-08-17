import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoadingDialog({required BuildContext context}){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        content: SizedBox(
          height: 40,
          child: Center(child: CircularProgressIndicator(),),
        ),
      );
    },);
  }
  static void showMessageDialog({required BuildContext context,required String message , required void Function() onPress}){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        content: Text(message,textAlign: TextAlign.center,),
        actions: [
          TextButton(onPressed: onPress, child: Text("ok"))
        ],
      );
    },);
  }
  static void showConfirmationDialog({required BuildContext context,
    required String message ,
    required void Function() onPositivePress,
    required void Function() onNegativePress}){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        content: Text(message,textAlign: TextAlign.center,),
        actions: [
          TextButton(onPressed: onPositivePress, child: Text("Yes")),
          TextButton(onPressed: onNegativePress, child: Text("No"))
        ],
      );
    },);
  }

}