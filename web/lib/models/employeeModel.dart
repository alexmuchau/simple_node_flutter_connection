List<EmployeeModel> employeesFromJson(dynamic str) =>
    List<EmployeeModel>.from((str).map((x) => EmployeeModel.fromJson(x)));

class EmployeeModel {
  late int? id;
  late String? name;
  late String? empCode;
  late double? salary;

  EmployeeModel({
    this.id,
    this.name,
    this.empCode,
    this.salary,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    empCode = json["empCode"];
    salary = json["salary"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data["_id"] = id;
    _data["name"] = name;
    _data["empCode"] = empCode;
    _data["salary"] = salary;

    return _data;
  }
}
