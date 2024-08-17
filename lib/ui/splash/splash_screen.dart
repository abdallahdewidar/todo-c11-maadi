import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';
import 'package:todo_c11_maadi/ui/home/home_screen.dart';
import 'package:todo_c11_maadi/ui/login/login_screen.dart';


class SplashScreen extends StatelessWidget {
  static const String routeName = "splash";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthUserProvider authUserProvider  = Provider.of<AuthUserProvider>(context);
    Future.delayed(Duration(milliseconds: 2500),() async {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if(currentUser == null){
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }else{
        await authUserProvider.retrieveUsersData();
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    },);
    return Scaffold(
      body: Center(child: Image.asset("assets/images/logo.png"),).animate().fade(
        duration: Duration(milliseconds: 2500),
        begin: 0,
        end: 1
      ),
    );
  }
}
