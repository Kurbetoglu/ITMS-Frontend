import 'package:flutter/material.dart';

import 'DTO/GetAllDebitsResponse.dart';
import 'DTO/BaseResponse.dart';
import 'network/NetworkFunctions.dart';

class UpdateDebit extends StatefulWidget {
  UpdateDebit(this.debitRecord, this.parentAction);
  DebitRecord debitRecord;
  ValueChanged<int> parentAction;

  @override
  _UpdateDebitState createState() => _UpdateDebitState();
}

class _UpdateDebitState extends State<UpdateDebit> {
  DateTime selectedDate = DateTime.now();
  Future<BaseResponse> _futureBaseResponse;
  bool _isDelivered;

  @override
  void initState(){
    _isDelivered = widget.debitRecord.isDelivered;
    super.initState();
  }

  @override
  void dispose(){
    selectedDate = null;
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
                    child: Text(widget.debitRecord.assigner, style: TextStyle(color: Color(0xff707070))),
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
                    child: Text(widget.debitRecord.user, style: TextStyle(color: Color(0xff707070))),
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
                    child: Text(widget.debitRecord.assetType, style: TextStyle(color: Color(0xff707070))),
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
                    child: Text(widget.debitRecord.assetName, style: TextStyle(color: Color(0xff707070))),
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
                    child: Text(widget.debitRecord.assetDescription, style: TextStyle(color: Color(0xff707070))),
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
                    child: Text(widget.debitRecord.cause, style: TextStyle(color: Color(0xff707070))),
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
                    child: Text("Start Date: " + widget.debitRecord.startDate, style: TextStyle(color: Color(0xff707070))),
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
                        alignment: Alignment.centerLeft,
                        primary: Color(0xfff0e8ca),
                      ),
                      onPressed: () {
                        selectDate(context);
                      },
                      child: Text(
                        selectedDate.day == DateTime.now().day ? "End Date: " + widget.debitRecord.endDate : "End Date: " + selectedDate.toString(),
                        style: TextStyle(color: Colors.black,),
                      ),
                    ),
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300.0,
                  height: 50.0,
                  color: Color(0xfff0e8ca),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Is Assigned?'),
                      LabeledRadio(
                        label: 'YES',
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        value: true,
                        groupValue: _isDelivered,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isDelivered = newValue;
                          });
                        },
                      ),
                      LabeledRadio(
                        label: 'NO',
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        value: false,
                        groupValue: _isDelivered,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isDelivered = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
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
                    child: Text("Save Changes", style: TextStyle(fontSize: 13),),
                    onPressed: () {
                      bool expiryDateHasChanged = false;
                      if(selectedDate.year != DateTime.now().year ||
                          selectedDate.month != DateTime.now().month ||
                          selectedDate.day != DateTime.now().day){
                        expiryDateHasChanged = true;
                      }
                      print("expiryDateHasChanged: " + expiryDateHasChanged.toString());
                      _futureBaseResponse = NetworkFunctions.updateDebit(
                          widget.debitRecord.id,
                          widget.debitRecord.assetId,
                          expiryDateHasChanged ? (selectedDate.toUtc().millisecondsSinceEpoch ~/ 1000) : 0,
                          _isDelivered,
                      );

                      _futureBaseResponse.then((value) {
                        if(value.success){
                          widget.parentAction(1);
                          Navigator.pop(context);
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
                    onPressed: () => Navigator.pop(context),
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

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key key,
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}