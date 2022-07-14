import 'package:crud/apiService.dart';
import 'package:crud/employeeItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'models/employeeModel.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => EmployeeListState();
}

class EmployeeListState extends State<EmployeeList> {
  List<EmployeeModel> employees = List<EmployeeModel>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    // employees.add(
    //   EmployeeModel(
    //     id: 1,
    //     name: "Alex",
    //     empCode: "34321",
    //     salary: 4231,
    //   ),
    // );

    // employees.add(
    //   EmployeeModel(
    //     id: 1,
    //     name: "Sergio",
    //     empCode: "343221",
    //     salary: 3333,
    //   ),
    // );
  }

  Widget employeeList(employees) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.green,
                  minimumSize: const Size(88, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text("Add Product"),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return EmployeeItem(
                    model: employees[index],
                    onDelete: (EmployeeModel model) {},
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Node JS - CRUD"),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: loadProducts(),
    );
  }

  Widget loadProducts() {
    return FutureBuilder(
      future: APIService.getEmployees(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<EmployeeModel>?> model,
      ) {
        if (model.hasData) {
          return employeeList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
