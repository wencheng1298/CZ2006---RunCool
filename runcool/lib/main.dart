import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:runcool/utils/GoogleMapsAppData.dart';
import 'package:runcool/Wrapper.dart';
import 'package:runcool/controllers/AuthenticationManager.dart';
import 'package:runcool/models/User.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/gym.jpg"), context);
    User currUser = FirebaseAuth.instance.currentUser;
    String uid = (currUser == null) ? null : currUser.uid;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleMapsAppData()),
        StreamProvider<User>.value(value: AuthenticationManager().user),
        StreamProvider<AppUser>.value(value: AppUser.getUserFromID(uid))
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
