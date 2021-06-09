import 'package:flutter/material.dart';
import 'package:note_pad/pages/home.dart';
import 'package:provider/provider.dart';

import 'database/databaseHelper.dart';
main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbHelper>(
      create: (BuildContext context) =>DbHelper(),
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.grey[100] ,
          )
          ),
      ),
    );
  }
}