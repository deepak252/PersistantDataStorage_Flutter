import 'package:flutter/material.dart';
import 'package:hello/dbhelper.dart';

class MyHome extends StatelessWidget {
  final DatabaseHelper dbhelperInstance=DatabaseHelper.instance;
  
  void insertData()async{
    Map<String,dynamic> row={
      
      DatabaseHelper.columnName:"Mohit",
      DatabaseHelper.columnAge:15,
    };
    final id=await dbhelperInstance.insert(row);
    print(id);
  }

  void queryAll() async{
    var allRows=await dbhelperInstance.queryAll(); // getting LIST of rows
    allRows.forEach((row){
      print(row);
    });    
  }
  void querySpecific() async{
    var allRows=await dbhelperInstance.querySpecific(20); // getting LIST of rows
    print(allRows);   
  }
  void deleteData() async{
    int id=await dbhelperInstance.deleteData(2);
    print(id);
  }

  void updateData() async{
    int row=await dbhelperInstance.updateData(4);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(
              colour: Colors.green,
              label: 'Insert',
              onPressed: insertData,
            ),
            CustomButton(
              colour: Colors.blueAccent,
              label: 'Query',
              onPressed: queryAll,
            ),
            CustomButton(
              colour: Colors.purple,
              label: 'Query Specific',
              onPressed: querySpecific,
            ),
            CustomButton(
              colour: Colors.orange,
              label: 'Update',
              onPressed: updateData,
            ),
            CustomButton(
              colour: Colors.red,
              label: 'Delete',
              onPressed: deleteData,
            )

          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color colour;
  CustomButton({@required this.label,this.onPressed,@required this.colour});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: colour,
          primary: Colors.white,
          minimumSize: Size(150, 40),
        ),
            
                     
      ),
    );
  }
}