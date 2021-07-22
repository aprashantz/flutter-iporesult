import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  var boid;
  List boidList = [];
  var selectedBO;
  List companyList = [
    'Mahila Laghubiita',
    'Union Life Insurance',
    'Jivan Laghubitta'
  ];
  var selectedCompany;

  //for adding bo id ui
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  boid = val;
                });
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Enter your valid BO ID",
                  labelText: "BO ID",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                  )),
            ),
            actions: <Widget>[
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.indigo,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (!boid.isEmpty) {
                    boidList.add(boid);
                    Navigator.of(context).pop();
                    print(boidList);
                    boid = "";
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.indigo));
    return Scaffold(
      floatingActionButton: floatAdd(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),

            //choose company dropdown
            DropdownButton(
                hint: Text(
                  "Choose Company",
                  style: TextStyle(fontSize: 25, color: Colors.indigo),
                ),
                value: selectedCompany,
                onChanged: (newValue) {
                  setState(() {
                    selectedCompany = newValue;
                  });
                },
                items: companyList.map((company) {
                  return DropdownMenuItem(
                    child: new Text(company),
                    value: company,
                  );
                }).toList()),
            SizedBox(
              height: 30,
            ),

            //choose bo id dropdown
            DropdownButton(
              hint: Text(
                'Choose BoID',
                style: TextStyle(fontSize: 25, color: Colors.indigo),
              ),
              value: selectedBO,
              onChanged: (newValue) {
                setState(() {
                  selectedBO = newValue;
                });
              },
              items: boidList.map((boid) {
                return DropdownMenuItem(
                  child: new Text(boid.toString()),
                  value: boid,
                );
              }).toList(),
            ),
            SizedBox(
              height: 30,
            ),

            ElevatedButton(
                child: Text(
                  "Check Result",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }

  //add bo id button widget
  Widget floatAdd() => FloatingActionButton.extended(
        label: Text(
          "New BOID",
        ),
        icon: Icon(Icons.add),
        onPressed: () async {
          await showInformationDialog(context);
        },
      );
}
