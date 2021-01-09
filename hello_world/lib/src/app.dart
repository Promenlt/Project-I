import 'package:hello_world/src/DataHandler/appData.dart';
import 'package:hello_world/src/resources/login_page.dart';
import 'package:hello_world/src/resources/home_page.dart';
import 'package:hello_world/src/resources/successfull_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
        home: LoginPage(),
    ),
    );

  }
}