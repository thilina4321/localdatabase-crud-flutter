import 'package:flutter/material.dart';
import 'package:localdatastorage/provider/item_provider.dart';
import 'package:localdatastorage/screen/data_screen.dart';
import 'package:localdatastorage/screen/form_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ItemProvider(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/': (ctx) => DataScreen(),
          FormScreen.routeName: (ctx) => FormScreen(),
        },
      ),
    );
  }
}
