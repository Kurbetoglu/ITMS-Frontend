import 'package:asset_yonet/models/BaseResponse.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<BaseResponse> _futureBaseResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HOME PAGE"),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _futureBaseResponse = NetworkFunctions.adminLogoff();
                    _futureBaseResponse.then((value) {
                      if(value.success){
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                      }
                    });
                  },
                  child: Icon(
                      Icons.logout
                  ),
                )
            ),
          ],
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
                    width: 200.0,
                    height: 50.0,
                    color: Color(0xffe48e55),
                    child: MaterialButton(
                      textColor: Colors.white,
                      child: Text("Search Assets"),
                      onPressed: () => {},
                    )
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),//1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200.0,
                  height: 50.0,
                  color: Color(0xffe48e55),
                  child: MaterialButton(
                      textColor: Colors.white,
                      child: Text("Add Asset"),
                    onPressed: () => {
                      Navigator.pushNamed(context, "/addAsset")
                    },
                    ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),//2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200.0,
                  height: 50.0,
                  color: Color(0xffe48e55),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Remove Asset"),
                    onPressed: () => {},
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
                  width: 200.0,
                  height: 50.0,
                  color: Color(0xffe48e55),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Search Debits"),
                    onPressed: () => {
                      Navigator.pushNamed(context, "/searchDebits")
                    },
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
                  width: 200.0,
                  height: 50.0,
                  color: Color(0xffe48e55),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Add Debit"),
                    onPressed: () => {
                      Navigator.pushNamed(context, "/addDebit")
                    },
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
                  width: 200.0,
                  height: 50.0,
                  color: Color(0xffe48e55),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Remove Debit" ),
                    onPressed: () => {
                      Navigator.pushNamed(context, "/removeDebit")
                    },

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
                  width: 200.0,
                  height: 50.0,
                  color: Color(0xffe48e55),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Users"),
                    onPressed: () => {
                      Navigator.pushNamed(context, "/users")
                    },
                  ),
                )
              ],
            ),
            //3
          ],
        )
    );
  }
}

