import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'models/employeeModel.dart';

class EmployeeItem extends StatelessWidget {
  const EmployeeItem({Key? key, this.model, this.onDelete}) : super(key: key);

  final EmployeeModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: employeeWidget(context),
      ),
    );
  }

  Widget employeeWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.name!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Salario: ${model!.salary}",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: const Icon(Icons.delete, color: Colors.red),
                      onTap: () {
                        onDelete!(model);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
