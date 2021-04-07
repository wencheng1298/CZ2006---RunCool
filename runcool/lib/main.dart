import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runcool/firebase/authenticationManager.dart';
import 'package:runcool/pages/RuncoolNavBar.dart';
import 'package:runcool/pages/SignUpUI/LogIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/firebase/Wrapper.dart';
import 'package:runcool/firebase/Service/auth.dart';
import 'package:runcool/models/User.dart';

//Required for routing to different UIs
import './pages/HomePageUI.dart';
import './pages/MyActivitiesUI.dart';
import 'pages/Events/CreateEventUI.dart';
import 'pages/Events/ChooseEventUI.dart'; //Temporary
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleMapsAppData()),
        StreamProvider<AppUser>.value(value: AuthService().user)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(color: Colors.white),
            centerTitle: true,
          ),
        ),
        home: Wrapper(),
      ),
    );
    //],
    //   ChangeNotifierProvider(
    //     create: (context) => GoogleMapsAppData(),
    //     child: MaterialApp(

    //     ),
    //   ),
    // ],
    //  );

    // AuthenticationManager().getCurrUserFromFirebase() == null ? LogInUI() : RuncoolNavBar(),
  }
}
//
// return ChangeNotifierProvider(
//   create: (context) => GoogleMapsAppData(),
//   child: MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.black,
//           titleTextStyle: TextStyle(color: Colors.white),
//           centerTitle: true,
//         ),
//       ),

//working code
//
// return
// //MultiProvider(
// //providers: [
// StreamProvider<AppUser>.value(
// value: AuthService().user,
// child: MaterialApp(
// home: Wrapper(),
// ),
// );
// // ChangeNotifierProvider(
// //   create: (context) => GoogleMapsAppData(),
// //   child: MaterialApp(
// //     title: 'Flutter Demo',
// //     theme: ThemeData(
// //       primarySwatch: Colors.blue,
// //       appBarTheme: AppBarTheme(
// //         backgroundColor: Colors.black,
// //         titleTextStyle: TextStyle(color: Colors.white),
// //         centerTitle: true,
// //       ),
// //     ),
// //   ),
// // ),
// // ],
// // );
//
// // AuthenticationManager().getCurrUserFromFirebase() == null ? LogInUI() : RuncoolNavBar(),
// }
// }
