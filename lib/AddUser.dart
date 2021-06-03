import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DTO/BaseResponse.dart';
import 'network/NetworkFunctions.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Future<BaseResponse> _futureBaseResponse;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController surnameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController telephoneNumberTextEditingController = TextEditingController();
  bool isEmailValid = false, isTelephoneNumberValid = false;

  @override
  void dispose() {
    nameTextEditingController.dispose();
    surnameTextEditingController.dispose();
    emailTextEditingController.dispose();
    telephoneNumberTextEditingController.dispose();
    isEmailValid = null;
    isTelephoneNumberValid = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName("/users")),
          ),
          title: Text("ADD USER"),
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
                          controller: surnameTextEditingController,
                          decoration: InputDecoration(hintText: "Surname"),
                        )
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
                    height: 65.0,
                    alignment: Alignment.bottomCenter,
                    color: Color(0xfff0e8ca),
                    child: TextFormField(
                      autovalidate: true,
                      controller: emailTextEditingController,
                      decoration: InputDecoration(hintText: "Email"),
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
                    height: 65.0,
                    alignment: Alignment.bottomCenter,
                    color: Color(0xfff0e8ca),
                    child: TextFormField(
                      autovalidate: true,
                      controller: telephoneNumberTextEditingController,
                      decoration: InputDecoration(hintText: "Telephone Number"),
                      validator: (value) {
                        if(value.isEmpty){
                          isTelephoneNumberValid = false;
                          return null;
                        }
                        else {
                          if(validateTelephoneNumber(value)){
                            isTelephoneNumberValid = true;
                            return null;
                          }
                          else {
                            return 'Telephone number is not valid.';
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
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xff4e9b2b),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Add User"),
                    onPressed: () {
                      if(isEmailValid && isTelephoneNumberValid){
                        _futureBaseResponse = NetworkFunctions.addUser(
                            nameTextEditingController.text,
                            surnameTextEditingController.text,
                            emailTextEditingController.text,
                            telephoneNumberTextEditingController.text
                        );
                        _futureBaseResponse.then((value) {
                          if (value.success){
                            Navigator.popUntil(context, ModalRoute.withName("/users"));
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
                    onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/users")),
                  ),
                )
              ],
            ),
          ],
        )
    );
  }

  bool validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value) ? true : false;
  }

  bool validateTelephoneNumber(String value) {
    Pattern pattern = r'^(?:[+0]9)?[0-9]{10,12}$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value) ? true : false;
  }
}
