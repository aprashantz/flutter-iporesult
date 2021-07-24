import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'fetchCompany.dart';

var boid;
var selectedCompany;

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
  void initState() {
    getCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    //getCompanyData();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.indigo));
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 220,
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
                        company.scrip,
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
              padding: const EdgeInsets.only(left: 40, right: 40),
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
