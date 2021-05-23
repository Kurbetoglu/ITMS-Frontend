import 'package:flutter/material.dart';

class RemoveAssetConfirm extends StatefulWidget {
  const RemoveAssetConfirm({Key key}) : super(key: key);

  @override
  _RemoveAssetConfirmState createState() => _RemoveAssetConfirmState();
}

class _RemoveAssetConfirmState extends State<RemoveAssetConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
