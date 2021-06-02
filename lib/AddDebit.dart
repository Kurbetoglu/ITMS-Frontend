import 'package:flutter/material.dart';

import 'models/GetAssetsByTypeResponse.dart';
import 'models/BaseResponse.dart';
import 'network/NetworkFunctions.dart';

String typeValue, nameValue;
int selectedId = 0;

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
  GetAssetsByTypeResponse _getAssetsByTypeResponse;

  DateTime selectedDate = DateTime.now();
  @override
  void initState(){
    _futureGetAssetsByTypeResponse = NetworkFunctions.getAssetsByType(1, 1, "");
    _futureGetAssetsByTypeResponse.then((value) {
      setState(() { });
    });
  }

  @override
  void dispose() {
    userEmailTextEditingController.dispose();
    assetIdTextEditingController.dispose();
    causeTextEditingController.dispose();
    typeValue = "";
    nameValue = "";
    selectedId = 0;
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
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: TextFormField(
                      controller: userEmailTextEditingController,
                      decoration: InputDecoration(hintText: "User Email"),
                      keyboardType: TextInputType.emailAddress,
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
}
