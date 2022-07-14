import 'package:crud/employeeAddEdit.dart';
import 'package:crud/employeeList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const EmployeeList(),
          '/add': (context) => const EmployeeAddEdit(),
          '/edit': (context) => const EmployeeAddEdit(),
        });
  }
}
