import 'package:asset_yonet/models/BaseResponse.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'models/GetAllUsersResponse.dart';

class UpdateUser extends StatefulWidget {
  UpdateUser(this.userRecord, this.parentAction);
  UserRecord userRecord;
  ValueChanged<int> parentAction;

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  Future<BaseResponse> _futureBaseResponse;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneNumberController = TextEditingController();

  @override
  void initState(){
    nameController.text = widget.userRecord.name;
    surnameController.text = widget.userRecord.surname;
    emailController.text = widget.userRecord.email;
    telephoneNumberController.text = widget.userRecord.telephoneNumber;
    super.initState();
  }

  @override
  void dispose(){
    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    telephoneNumberController.dispose();
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
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child:TextField(
                    controller: nameController,
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
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child:TextField(
                    controller: surnameController,
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
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child:TextField(
                    controller: emailController,
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
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child:TextField(
                    controller: telephoneNumberController,
                  ),
                ),
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
                      _futureBaseResponse = NetworkFunctions.updateUser(
                          widget.userRecord.id,
                          nameController.text,
                          surnameController.text,
                          emailController.text,
                          telephoneNumberController.text
                      );
                      _futureBaseResponse.then((value) {
                        if(value.success){
                          print(value.success);
                          widget.parentAction(1);
                          Navigator.pop(context);
                        }
                      });
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
        ));
  }
}


