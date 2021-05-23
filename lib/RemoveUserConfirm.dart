import 'package:flutter/material.dart';

class RemoveUserConfirm extends StatefulWidget {
  const RemoveUserConfirm({Key key}) : super(key: key);

  @override
  _RemoveUserConfirmState createState() => _RemoveUserConfirmState();
}

class _RemoveUserConfirmState extends State<RemoveUserConfirm> {
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
                      child: Text("Are you sure to remove this user?",
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
                    onPressed: () => {},
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xffc53737),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("NO"),
                    onPressed: () => {},
                  ),
                )
              ],
            ),
          ],
        )
    );

  }
}

