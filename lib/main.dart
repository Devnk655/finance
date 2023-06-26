import 'package:finance/Screens/home.dart';
import 'package:finance/Widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'Screens/statistics.dart';
import 'model/add_date_data.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter( AdddataAdapter());
  await Hive.openBox<Add_data>("data");
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Bottom() ,
    );
  }
}
