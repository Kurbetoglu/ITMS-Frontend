import 'dart:io';
import 'dart:math';

import 'package:asset_yonet/Homepage.dart';
import 'package:asset_yonet/models/GetAssetsByTypeResponse.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'models/BaseResponse.dart';

String typeValue, nameValue;
DateTime selectedDate = DateTime.now();
int selectedId = 0;
class AddDebit extends StatefulWidget {
  const AddDebit({Key key}) : super(key: key);

  @override
  _AddDebitState createState() => _AddDebitState();
}

class _AddDebitState extends State<AddDebit> {
  final userEmailTextEditingController = TextEditingController();
  final assetNameTextEditingController = TextEditingController();
  final causeTextEditingController = TextEditingController();
  Future<GetAssetsByTypeResponse> _futureGetAssetsByTypeResponse;
  Future<BaseResponse> _futureBaseResponse;
  GetAssetsByTypeResponse _getAssetsByTypeResponse;
  @override
  void dispose() {
    userEmailTextEditingController.dispose();
    assetNameTextEditingController.dispose();
    causeTextEditingController.dispose();
    typeValue = "";
    nameValue = "";
    selectedId = 0;
    super.dispose();
  }
  @override
  void initState(){
    _futureGetAssetsByTypeResponse = NetworkFunctions.getAssetsByType(1, 1, "");
    sleep(Duration(seconds: 2));
    _futureGetAssetsByTypeResponse.then((value) {
      setState(() { });
    });
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
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "User Email"),
                      keyboardType: TextInputType.emailAddress,
                    )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ), //1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: typeValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Fiziksel',
                      'Dijital',
                      'İnsan Kaynağı',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        onTap:  () async {
                          _futureGetAssetsByTypeResponse = NetworkFunctions.getAssetsByType(0, 0, value);
                          _futureGetAssetsByTypeResponse.then((value) {
                            setState(() { });
                          });
                        },
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Type",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        typeValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Flexible(
              child: _futureGetAssetsByTypeResponse == null ? buildRow() : futureBuilder(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Flexible(
              child: selectedId == 0 ? buildRow() : buildDetails(selectedId),
              //child: selectedId == 0 ? buildRow() : buildRow(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xfff0e8ca),
                      ),
                      onPressed: () {
                        selectDate(context);
                      },
                      child: const Text(
                        "Pick End Date",
                        style: TextStyle(
                          color: Color(0xff707070),
                        ),
                      ),
                    )
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Cause"),
                    )))
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),

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
                      _futureBaseResponse = NetworkFunctions.addDebit(
                          userEmailTextEditingController.text,
                          selectedId,
                          typeValue,
                          nameValue,
                          (selectedDate.toUtc().millisecondsSinceEpoch / 1000).toInt(),
                          causeTextEditingController.text
                      );
                      _futureBaseResponse.then((value) {
                        if(value.success){
                          dispose();
                          Navigator.popUntil(context, ModalRoute.withName("/homepage"));
                        }
                      });
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
                      dispose();
                      Navigator.popUntil(context, ModalRoute.withName("/homepage"));
                    }
                  ),
                )
              ],
            ),
            //3
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
  Visibility buildRow() {
    return Visibility(
        visible: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
            )
          ],
        )
    );
  }

  Column buildDetails(int id) {
    Record record;
    for(int i = 0; i < _getAssetsByTypeResponse.records.length; ++i){
      if (_getAssetsByTypeResponse.records[i].id == id){
        record = _getAssetsByTypeResponse.records[i];
      }
    }

    switch (typeValue){
      case "Fiziksel": {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.description),
            ),
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.addedDate),
            ),
          ],
        );
      }
      break;
      case "Dijital": {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.description),
            ),
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.addedDate),
            ),
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.expiryDate),
            ),
          ],
        );
      }
      break;
      case "İnsan Kaynağı": {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.description),
            ),
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.addedDate),
            ),
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.personName),
            ),
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.personSurname),
            ),
            Container(
              width: 300.0,
              height: 30.0,
              color: Color(0xfff0e8ca),
              child: Text(record.personEmail),
            ),
          ],
        );
      }
      break;
    }
  }

  FutureBuilder<GetAssetsByTypeResponse> futureBuilder() {
    return FutureBuilder<GetAssetsByTypeResponse>(
      future: _futureGetAssetsByTypeResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _getAssetsByTypeResponse = snapshot.data;
          List<String> list = new List<String>();
          for(int i = 0; i < snapshot.data.records.length; i++){
            if( snapshot.data.records[i].isAssigned){
              continue;
            }
            String string = "Id: " + snapshot.data.records[i].id.toString() + ", " + snapshot.data.records[i].name;
            list.add(string);
          }

          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child:  DropdownButton(
                      value: nameValue,
                      isDense: true,
                      items: list.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          var splittedName = value.split(', ');
                          nameValue = splittedName[1];
                          selectedId = int.parse(splittedName.skip(4).toString());
                        });
                      },
                    )
                ),
              ]
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
