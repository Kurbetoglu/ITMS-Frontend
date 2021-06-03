import 'package:flutter/material.dart';

import 'DTO/BaseResponse.dart';
import 'network/NetworkFunctions.dart';


DateTime selectedDate = DateTime.now();

class AddAsset extends StatefulWidget {
  const AddAsset({Key key}) : super(key: key);

  @override
  _AddAssetState createState() => _AddAssetState();
}

class _AddAssetState extends State<AddAsset> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController personNameTextEditingController = TextEditingController();
  TextEditingController personSurnameTextEditingController = TextEditingController();
  TextEditingController personEmailTextEditingController = TextEditingController();
  Future<BaseResponse> _futureBaseResponse;
  String typeValue;
  bool isEmailValid = false;

  @override
  void dispose() {
    typeValue = null;
    isEmailValid = null;
    nameTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    personNameTextEditingController.dispose();
    personSurnameTextEditingController.dispose();
    personEmailTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName("/homepage")),
          ),
          title: Text("ADD ASSET"),
          backgroundColor: Color(0xff67acb0),
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
                  height: 40.0,
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
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 40.0,
                    color: Color(0xfff0e8ca),
                    child: TextFormField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(hintText: "Name"),
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
                          controller: descriptionTextEditingController,
                          decoration: InputDecoration(hintText: "Description"),
                        )
                    )
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "Dijital" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 300.0,
                      height: 40.0,
                      color: Color(0xfff0e8ca),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xfff0e8ca),
                        ),
                        onPressed: () {
                          selectDate(context);
                        },
                        child: const Text(
                          "Pick Expiry Date",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "İnsan Kaynağı" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 300.0,
                      height: 40.0,
                      color: Color(0xfff0e8ca),
                      child: Center(
                          child: TextFormField(
                            controller: personNameTextEditingController,
                            decoration: InputDecoration(hintText: "Person Name"),
                          )
                      )
                  )
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "İnsan Kaynağı" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 300.0,
                      height: 40.0,
                      color: Color(0xfff0e8ca),
                      child: Center(
                          child: TextFormField(
                            controller: personSurnameTextEditingController,
                            decoration: InputDecoration(hintText: "Person Surname"),
                          )
                      )
                  )
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "İnsan Kaynağı" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 300.0,
                      height: 65.0,
                      alignment: Alignment.bottomCenter,
                      color: Color(0xfff0e8ca),
                      child: TextFormField(
                        autovalidate: true,
                        controller: personEmailTextEditingController,
                        decoration: InputDecoration(hintText: "Person Email"),
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
                    child: Text("Add Asset"),
                    onPressed: () {
                      if(isEmailValid){
                        switch(typeValue){
                          case "Fiziksel":{
                            _futureBaseResponse = NetworkFunctions.addAsset(
                              typeValue,
                              nameTextEditingController.text,
                              descriptionTextEditingController.text,
                              0,
                              null,
                              null,
                              null,
                            );
                          }
                          break;

                          case "Dijital":{
                            _futureBaseResponse = NetworkFunctions.addAsset(
                              typeValue,
                              nameTextEditingController.text,
                              descriptionTextEditingController.text,
                              (selectedDate.toUtc().millisecondsSinceEpoch ~/ 1000),
                              null,
                              null,
                              null,
                            );
                          }
                          break;

                          case "İnsan Kaynağı":{
                            _futureBaseResponse = NetworkFunctions.addAsset(
                              typeValue,
                              nameTextEditingController.text,
                              descriptionTextEditingController.text,
                              0,
                              personNameTextEditingController.text,
                              personSurnameTextEditingController.text,
                              personEmailTextEditingController.text,
                            );
                          }
                          break;
                        }

                        _futureBaseResponse.then((value) {
                          print(value.success);
                          if (value.success) {
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
