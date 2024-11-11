import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ijas/Provider/IjasProvider.dart';
import 'package:ijas/firebase_options.dart';
import 'package:ijas/view/HomePage.dart';
=======
import 'package:pie/Provider/RagaProvider.dart';
import 'package:pie/firebase_options.dart';
import 'package:pie/view/LoginPage.dart';
>>>>>>> 2a79d88 (pie)
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
<<<<<<< HEAD
        ChangeNotifierProvider(create: (BuildContext context) => IjasProvider()),
      ],
      child: CupertinoApp(
        title: 'Flutter Demo',
        theme: CupertinoThemeData(brightness: Brightness.light),
        home: HomePage(),
=======
        ChangeNotifierProvider(
            create: (BuildContext context) => RagaProvider()),
      ],
      child: CupertinoApp(
        title: 'Raga',
        debugShowCheckedModeBanner: false,
        theme: const CupertinoThemeData(
            brightness: Brightness.light, textTheme: CupertinoTextThemeData()),
        home: LoginPage(),
>>>>>>> 2a79d88 (pie)
      ),
    );
  }
}

