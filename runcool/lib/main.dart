import 'package:flutter/material.dart';
import 'package:runcool/pages/SignUpUI/LogIn.dart';
import 'package:firebase_core/firebase_core.dart';

//Required for routing to different UIs
import './pages/HomePageUI.dart';
import './pages/MyActivitiesUI.dart';
import './pages/CreateEventUI.dart';
import './pages/ChooseEventUI.dart'; //Temporary
import './pages/NotificationUI.dart';
import './pages/ProfileUI.dart';
import './pages/SignUpUI/LogIn.dart';
import './pages/SignUpUI/SignUpUI1.dart';

// void main() {
//   runApp(MyApp());
// }
void main() async {
  // https://stackoverflow.com/a/63492262
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
          centerTitle: true,
        ),
      ),
      home: LogInUI(),
    );
  }
}
