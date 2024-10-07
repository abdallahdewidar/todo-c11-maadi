
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_maadi/Todo%20provonidor.dart';
import 'package:todo_c11_maadi/style/appstyle.dart';
import 'package:todo_c11_maadi/ui/AuthProvider.dart';
import 'package:todo_c11_maadi/ui/home/home_screen.dart';
import 'package:todo_c11_maadi/ui/home/widgets/edit%20task.dart';
import 'package:todo_c11_maadi/ui/login/login_screen.dart';
import 'package:todo_c11_maadi/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_c11_maadi/ui/splash/splash_screen.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(

       MultiProvider(providers: [
         ChangeNotifierProvider(create: (context)=> AuthUserProvider()
         ),
         ChangeNotifierProvider(create: (context)=> TodoProvider()
         ),
       ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Appstyle.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        SplashScreen.routeName:(_)=>SplashScreen(),
        Edittask.routeName:(_)=>Edittask()
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}

