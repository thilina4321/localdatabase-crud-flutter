import 'package:flutter/material.dart';
import 'package:localdatastorage/provider/data_provider.dart';
import 'package:localdatastorage/screens/add_data_screen.dart';
import 'package:localdatastorage/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => DataProvider()),
      ],
      child: MaterialApp(
        routes: {
          '/': (ctx) => HomeScreen(),
          AddDataScreen.routeName: (ctx) => AddDataScreen(),
        },
      ),
    );
  }
}
