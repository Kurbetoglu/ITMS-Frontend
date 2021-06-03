import 'package:flutter/material.dart';

import 'DTO/BaseResponse.dart';
import 'DTO/GetAllUsersResponse.dart';
import 'network/NetworkFunctions.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser(this.userRecord, this.parentAction);
  UserRecord userRecord;
  ValueChanged<int> parentAction;

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  Future<BaseResponse> _futureBaseResponse;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController surnameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController telephoneNumberTextEditingController = TextEditingController();
  bool isEmailValid = false, isTelephoneNumberValid = false;

  @override
  void initState(){
    nameTextEditingController.text = widget.userRecord.name;
    surnameTextEditingController.text = widget.userRecord.surname;
    emailTextEditingController.text = widget.userRecord.email;
    telephoneNumberTextEditingController.text = widget.userRecord.telephoneNumber;
    super.initState();
  }

  @override
  void dispose(){
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("UPDATE USER"),
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
                  child:TextField(
                    controller: nameTextEditingController,
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
                  child:TextField(
                    controller: surnameTextEditingController,
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
                  width: 130.0,
                  height: 50.0,
                  color: Color(0xff4e9b2b),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Save Changes", style: TextStyle(fontSize: 13),),
                    onPressed: () {
                      if(isEmailValid && isTelephoneNumberValid){
                        _futureBaseResponse = NetworkFunctions.updateUser(
                            widget.userRecord.id,
                            nameTextEditingController.text,
                            surnameTextEditingController.text,
                            emailTextEditingController.text,
                            telephoneNumberTextEditingController.text
                        );
                        _futureBaseResponse.then((value) {
                          if(value.success){
                            print(value.success);
                            widget.parentAction(1);
                            Navigator.pop(context);
                          }
                        });
                      }
                    },
                  ),
                ),
                Container(
                  width: 130.0,
                  height: 50.0,
                  color: Color(0xffc53737),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            //3
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