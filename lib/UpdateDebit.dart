import 'package:asset_yonet/models/GetAllDebitsResponse.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'models/BaseResponse.dart';

DateTime selectedDate = DateTime.now();
String radioButtonItem;
int radioButtonId;

class UpdateDebit extends StatefulWidget {
  UpdateDebit(DebitRecord debitRecord){
    this.debitRecord = debitRecord;
  }

  DebitRecord debitRecord;

  @override
  _UpdateDebitState createState() => _UpdateDebitState(debitRecord);
}

class _UpdateDebitState extends State<UpdateDebit> {
  _UpdateDebitState(DebitRecord debitRecord){
    this.debitRecord = debitRecord;
  }

  Future<BaseResponse> _futureBaseResponse;
  DebitRecord debitRecord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("UPDATE DEBIT"),
          backgroundColor: Color(0xff67acb0),
        ),
        resizeToAvoidBottomInset: false,
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
                    child: Text(debitRecord.assigner),
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
                    child: Text(debitRecord.user),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ), //2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Text(debitRecord.assetType),
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
                    child: Text(debitRecord.assetName),
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
                    child: Text(debitRecord.assetDescription),
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
                    child: Text(debitRecord.cause),
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
                    child: Text(debitRecord.startDate),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xfff0e8ca),
                      ),
                      onPressed: () {
                        selectDate(context);
                      },
                      child: Text(
                        selectedDate.day == DateTime.now().day ? "End Date: " + debitRecord.endDate : "End Date: " + selectedDate.toString(),
                        style: TextStyle(color: Color(0xff707070),),
                      ),
                    ),
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
                  height: 50.0,
                  color: Color(0xfff0e8ca),
                  child: RadioGroup(debitRecord.isDelivered),
                ),
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
                    child: Text("Save Changes"),
                    onPressed: () {
                      bool _isDelivered;
                      if(radioButtonId == 1){
                        _isDelivered = true;
                      } else {
                        _isDelivered = false;
                      }

                      if(_isDelivered != debitRecord.isDelivered ||
                          (selectedDate.day != DateTime.now().day &&
                              selectedDate.month != DateTime.now().month &&
                              selectedDate.year != DateTime.now().year)){
                        _futureBaseResponse = NetworkFunctions.updateDebit(
                            debitRecord.id,
                            debitRecord.assetId,
                            _isDelivered ? 0 : (selectedDate.toUtc().millisecondsSinceEpoch/1000).toInt(),
                            _isDelivered,
                        );

                        _futureBaseResponse.then((value) {
                          if(value.success){
                            Navigator.pop(context);
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
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            //3
          ],
        ));
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

class RadioGroup extends StatefulWidget {
  RadioGroup(bool isDelivered){
    this.isDelivered = isDelivered;
  }
  bool isDelivered;
  @override
  RadioGroupWidget createState() => RadioGroupWidget(isDelivered);
}

class RadioGroupWidget extends State {
  RadioGroupWidget(bool isDelivered){
    this.isDelivered = isDelivered;
  }

  bool isDelivered;

  Widget build(BuildContext context) {
    radioButtonItem = isDelivered ? 'YES' : 'NO';
    radioButtonId = isDelivered ? 1 : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Is Delivered?',
          style: TextStyle(fontSize: 16),
        ),
        Radio(
          value: 1,
          groupValue: radioButtonId,
          onChanged: (dynamic val) {
            setState(() {
              radioButtonItem = 'YES';
              radioButtonId = 1;
            });
          },
        ),
        Text(
          'YES',
        ),

        Radio(
          value: 0,
          groupValue: radioButtonId,
          onChanged: (dynamic val) {
            setState(() {
              radioButtonItem = 'NO';
              radioButtonId = 0;
            });
          },
        ),
        Text(
          'NO',
        ),
      ],
    );
  }
}
