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

  @override
  void dispose() {
    nameTextEditingController.dispose();
    surnameTextEditingController.dispose();
    emailTextEditingController.dispose();
    telephoneNumberTextEditingController.dispose();
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
                    height: 30.0,
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
                    height: 30.0,
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
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                          controller: emailTextEditingController,
                          decoration: InputDecoration(hintText: "Email"),
                          keyboardType: TextInputType.emailAddress,
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
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                          controller: telephoneNumberTextEditingController,
                          decoration: InputDecoration(hintText: "Telephone Number"),
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
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xff4e9b2b),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Add User"),
                    onPressed: () {
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
}
