import 'package:flutter/material.dart';

import 'models/BaseResponse.dart';
import 'network/NetworkFunctions.dart';

class RemoveAssetConfirm extends StatefulWidget {
  RemoveAssetConfirm(int assetId, ValueChanged<int> parentAction){
    this.parentAction = parentAction;
    this.assetId = assetId;
  }
  int assetId;
  ValueChanged<int> parentAction;
  @override
  _RemoveAssetConfirmState createState() => _RemoveAssetConfirmState(assetId);
}

class _RemoveAssetConfirmState extends State<RemoveAssetConfirm> {
  _RemoveAssetConfirmState(int assetId){
    this.assetId = assetId;
  }

  Future<BaseResponse> _futureBaseResponse;
  int assetId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
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
                      child: Text("Are you sure to remove this asset?",
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
                      _futureBaseResponse = NetworkFunctions.removeAsset(assetId);
                      _futureBaseResponse.then((value) async {
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
                    child: Text("NO"),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ],
        )
    );

  }
}
