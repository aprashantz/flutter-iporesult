import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

//making list of company from company class
List<Company> companies = [];
List companyList = [];

var boid;
var selectedBO;

var selectedCompany;

//function to get company data from meroshare api
getCompanyData() async {
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
  print(companyList);
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unofficial NEPSE IPO Result App',
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      getCompanyData();
    });
    // getCompanyData();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.indigo));
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
            ),

            //choose company dropdown
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: DropdownButton(
                  hint: Text(
                    "Choose Company",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  value: selectedCompany,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCompany = newValue;
                    });
                  },
                  items: companies.map((company) {
                    return DropdownMenuItem(
                      child: new Text(
                        company.name,
                        style: TextStyle(fontSize: 15),
                      ),
                      value: company,
                    );
                  }).toList()),
            ),
            SizedBox(
              height: 30,
            ),

            //boid ui
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  boid = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter your 13 digits BOID",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            ElevatedButton(
                child: Text(
                  "Check Result",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  print("boid: " + boid);
                  print("boid: $boid and company: ${selectedCompany.id}");
                }),

            //response of check result below
          ],
        ),
      ),
    );
  }
}

class Company {
  var id, name, scrip, isFileUploaded;
//constructor
  Company(this.id, this.name, this.scrip, this.isFileUploaded);
}
