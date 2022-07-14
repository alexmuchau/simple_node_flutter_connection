import 'dart:convert';

import 'package:crud/config.dart';
import 'package:crud/models/employeeModel.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<List<EmployeeModel>?> getEmployees() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
    };

    try {
      var url = Uri.http(Config.apiURL, Config.employeesURL);

      var response = await http.get(url, headers: requestHeaders);

      var status = response.statusCode;

      if (status == 200) {
        var data = jsonDecode(response.body);

        return employeesFromJson(data[0]);
        // return null;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> saveProduct(EmployeeModel model, bool isEditMode) async {
    var employeeURL = Config.employeesURL;

    if (isEditMode) {
      employeeURL = employeeURL + '/' + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, employeeURL);

    var requestMethod = isEditMode ? 'PUT' : 'POST';

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["name"] = model.name!;
    request.fields["salary"] = model.salary!.toString();

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> delete(employeeId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.employeesURL + "/" + employeeId);

    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
