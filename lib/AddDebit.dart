import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DTO/GetAssetsByTypeResponse.dart';
import 'DTO/BaseResponse.dart';
import 'network/NetworkFunctions.dart';

class AddDebit extends StatefulWidget {
  const AddDebit({Key key}) : super(key: key);

  @override
  _AddDebitState createState() => _AddDebitState();
}

class _AddDebitState extends State<AddDebit> {
  TextEditingController userEmailTextEditingController = TextEditingController();
  TextEditingController assetIdTextEditingController = TextEditingController();
  TextEditingController causeTextEditingController = TextEditingController();
  Future<GetAssetsByTypeResponse> _futureGetAssetsByTypeResponse;
  Future<BaseResponse> _futureBaseResponse;
  String typeValue, nameValue;
  DateTime selectedDate = DateTime.now();
  int selectedId = 0;
  bool isEmailValid = false;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    userEmailTextEditingController.dispose();
    assetIdTextEditingController.dispose();
    causeTextEditingController.dispose();
    typeValue = null;
    nameValue = null;
    selectedId = 0;
    selectedDate = null;
    isEmailValid = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("ADD DEBIT"),
          backgroundColor: Color(0xff67acb0),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName("/homepage"));
            }
          ),
        ),

        backgroundColor: Color(0xff518199),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 65.0,
                    alignment: Alignment.bottomCenter,
                    color: Color(0xfff0e8ca),
                    child: TextFormField(
                      autovalidate: true,
                      controller: userEmailTextEditingController,
                      decoration: InputDecoration(hintText: "User Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if(value.isEmpty){
                          isEmailValid = false;
                          return null;
                        }
                        else {
                          if(validateEmail(value)){
                            isEmailValid = true;
                            return null;
                          }
                          else {
                            return 'Email is not valid.';
                          }
                        }
                      },
                    )
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 40.0,
                    color: Color(0xfff0e8ca),
                    child: TextFormField(
                      controller: assetIdTextEditingController,
                      decoration: InputDecoration(hintText: "Asset Id"),
                    )
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 40.0,
                    color: Color(0xfff0e8ca),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        primary: Color(0xfff0e8ca),
                      ),
                      onPressed: () {
                        selectDate(context);
                      },
                      child: Text(
                        selectedDate.day == DateTime.now().day ? "Pick End Date" : "End Date: " + selectedDate.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 40.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                          controller: causeTextEditingController,
                          decoration: InputDecoration(hintText: "Cause"),
                    )))
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xff4e9b2b),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Add Debit"),
                    onPressed: () {
                      if(isEmailValid){
                        _futureBaseResponse = NetworkFunctions.addDebit(
                            userEmailTextEditingController.text,
                            int.parse(assetIdTextEditingController.text),
                            (selectedDate.toUtc().millisecondsSinceEpoch ~/ 1000),
                            causeTextEditingController.text
                        );
                        _futureBaseResponse.then((value) {
                          if(value.success){
                            Navigator.popUntil(context, ModalRoute.withName("/homepage"));
                          }
                        });
                      }
                    },
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xffc53737),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName("/homepage"));
                    }
                  ),
                )
              ],
            ),
          ],
        )
    );
  }

  Future selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2222));
    if (picked != null && picked!= selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  bool validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value) ? true : false;
  }
}
