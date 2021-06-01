import 'dart:io';

import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'models/BaseResponse.dart';

class RemoveDebitConfirm extends StatefulWidget {
  RemoveDebitConfirm(int debitId, ValueChanged<int> parentAction){
    this.parentAction = parentAction;
    this.debitId = debitId;
  }

  ValueChanged<int> parentAction;
  int debitId;

  @override
  _RemoveDebitConfirmState createState() => _RemoveDebitConfirmState(debitId);
}

class _RemoveDebitConfirmState extends State<RemoveDebitConfirm> {
  _RemoveDebitConfirmState(int debitId){
    this.debitId = debitId;
  }

  Future<BaseResponse> _futureBaseResponse;
  int debitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName("/removeDebit")),
          ),
          title: Text("CONFIRMATION"),
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
                    height: 50.0,
                    color: Color(0xffc53737),
                    child: Center(
                      child: Text("Are you sure to remove this debit?",
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.white)),
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
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xffc53737),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("YES"),
                    onPressed: () {
                      _futureBaseResponse = NetworkFunctions.removeDebit(debitId);
                      _futureBaseResponse.then((value) async {
                        if(value.success){
                          Navigator.popUntil(context, ModalRoute.withName("/homepage"));
                          widget.parentAction(1);
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
                    child: Text("NO"),
                    onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/removeDebit")),
                  ),
                )
              ],
            ),
          ],
        )
    );

  }
}

