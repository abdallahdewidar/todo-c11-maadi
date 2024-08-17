import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/firebase/model/User.dart' as MyUser;
import 'package:todo_c11_maadi/firebase/user_collection.dart';
import 'package:todo_c11_maadi/style/constants.dart';
import 'package:todo_c11_maadi/style/reusable_components/CustomFormField.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';
import 'package:todo_c11_maadi/ui/home/home_screen.dart';

import '../../FirebaseErrorCodes.dart';
import '../../style/dialog_utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/back.jpg"),fit: BoxFit.fill)
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
          title: Text("Create Account"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormField(label: "Full Name",type: TextInputType.name,
                    controller: fullNameController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter your name";
                      }
                      return null;
                    },
                    ),
                    CustomFormField(label: "User Name",type: TextInputType.name,
                        controller: userNameController
                        ,validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter username";
                      }
                      return null;
                    }),
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

                    CustomFormField(label: "Password Confirmation",
                        controller: passwordConfirmController,
                        isPassword: true,
                      textInputAction: TextInputAction.done,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please enter password";
                        }
                        if(value != passwordController.text){
                          return "Password don't match";
                        }
                        return null;
                      }
                    ),
                    SizedBox(height: 24,),
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){
                              CreateAccount();
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
                                  Text("Create Account",style: Theme.of(context).textTheme.labelLarge,),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  CreateAccount()async{
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context,listen: false);
    if(formKey.currentState?.validate()??false){
      try {
        DialogUtils.showLoadingDialog(context: context);
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        MyUser.User user = MyUser.User(
            id: credential.user?.uid??"",
            email: emailController.text.trim(),
            fullName: fullNameController.text,
            userName: userNameController.text
        );
        await UserCollection.createUser(credential.user?.uid??"",user );
        provider.setUsers(credential.user!, user);
        Navigator.pop(context);
        DialogUtils.showMessageDialog(context: context, message: "Account created successfully ${credential.user?.email}", onPress: (){
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == weakPass) {
          Navigator.pop(context);
          DialogUtils.showMessageDialog(context: context, message: "The password provided is too weak.", onPress: (){
            Navigator.pop(context);
          });
        } else if (e.code == emailUsed) {
          Navigator.pop(context);
          DialogUtils.showMessageDialog(context: context, message: "The account already exists for that email.", onPress: (){
            Navigator.pop(context);
          });
        }
      } catch (e) {
        Navigator.pop(context);
        DialogUtils.showMessageDialog(context: context, message: "${e.toString()}", onPress: (){
          Navigator.pop(context);
        });
      }
    }
  }
}
