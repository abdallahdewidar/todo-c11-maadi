import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/firebase/model/User.dart' as MyUser;
import 'package:todo_c11_maadi/FirebaseErrorCodes.dart';
import 'package:todo_c11_maadi/firebase/user_collection.dart';
import 'package:todo_c11_maadi/style/dialog_utils.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';
import 'package:todo_c11_maadi/ui/home/home_screen.dart';
import 'package:todo_c11_maadi/ui/register/register_screen.dart';

import '../../style/constants.dart';
import '../../style/reusable_components/CustomFormField.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/back.jpg"),fit: BoxFit.fill)
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25
          ),
          title: Text("Login"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CustomFormField(label: "Email",type: TextInputType.emailAddress,
                        controller: emailController
                        ,validator: (value){
                          if(value == null || value.isEmpty){
                            return "Please enter email";
                          }
                          if(!isValidEmail(value)){
                            return "Enter valid email";
                          }
                          return null;
                        }),
                    CustomFormField(label: "Password",

                      controller: passwordController,
                      isPassword: true,validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter password";
                        }
                        if(value.length<6){
                          return "Password must contain at least 6 characters";
                        }
                        return null;
                      },),

                    SizedBox(height: 24,),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){
                              LoginAccount();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Login",style: Theme.of(context).textTheme.labelLarge,),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ))),
                    SizedBox(height: 24,),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RegisterScreen.routeName);
                    }, child: Text("Or Create My Account",style: TextStyle(
                      color: Colors.grey
                    ),)
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  LoginAccount()async{
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context,listen: false);
    if(formKey.currentState?.validate()??false){
      try {
        DialogUtils.showLoadingDialog(context: context);
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text
        );
        MyUser.User? user = await UserCollection.getUser(credential.user?.uid??"");
        provider.setUsers(credential.user!, user!);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == userNotFound) {
          Navigator.pop(context);
          DialogUtils.showMessageDialog(context: context, message: "No user found for that email.", onPress: (){
            Navigator.pop(context);
          });
        } else if (e.code == wrongPass) {
          Navigator.pop(context);
          DialogUtils.showMessageDialog(context: context, message: "Wrong password provided for that user.", onPress: (){
            Navigator.pop(context);
          });
        }
      }
    }
  }
}
