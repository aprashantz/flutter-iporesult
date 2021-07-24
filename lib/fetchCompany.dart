import 'dart:convert';

//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Company {
  var id, name, scrip, isFileUploaded;
//constructor
  Company(this.id, this.name, this.scrip, this.isFileUploaded);
}

List<Company> companies = [];
List companyList = [];

Future<List<Company>> getCompanyData() async {
  final response = await http.get(
      Uri.https('iporesult.cdsc.com.np', 'result/companyShares/fileUploaded'));

  var jsonData;
  if (response.statusCode == 200) {
    jsonData = json.decode(response.body);
  }
  //var jsonData = jsonDecode(response.body);
  //print(jsonData["body"]);
  //print(jsonData["body"][1]["name"]);

  for (var c in jsonData["body"]) {
    //Company company =
    //   Company(c["name"], c["username"], c["email"], c["name"]);
    //companies.add(company);
    if (!companyList.contains(c["scrip"])) {
      companyList.add(c["scrip"]);
      Company company =
          Company(c["id"], c["name"], c["scrip"], c["isFileUploaded"]);
      companies.add(company);
    }

    //print(c["name"]);
  }
  return companies;
  //print(companyList);
}
