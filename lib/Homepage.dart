import 'package:flutter/material.dart';

import 'DTO/BaseResponse.dart';
import 'network/NetworkFunctions.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<BaseResponse> _futureBaseResponse;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text("HOME PAGE"),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      _futureBaseResponse = NetworkFunctions.adminLogoff();
                      _futureBaseResponse.then((value) {
                        if (value.success) {
                          Navigator.popUntil(context, ModalRoute.withName("/"));
                        }
                      });
                    },
                    child: Icon(Icons.logout),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //color: Colors.white,
                    child: Image.asset('images/logo.png'),
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0),),
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
                        onPressed: () => Navigator.pushNamed(context, "/searchAssets"),
                      )
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0),),
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
                      onPressed: () => Navigator.pushNamed(context, "/addAsset"),
                    ),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0),),
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
                      onPressed: () => Navigator.pushNamed(context, "/removeAsset"),
                    ),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0),),
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
                      onPressed: () =>
                          {Navigator.pushNamed(context, "/searchDebits")},
                    ),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0),),
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
                      onPressed: () =>
                          {Navigator.pushNamed(context, "/addDebit")},
                    ),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200.0,
                    height: 50.0,
                    color: Color(0xffe48e55),
                    child: MaterialButton(
                      textColor: Colors.white,
                      child: Text("Remove Debit"),
                      onPressed: () =>
                          {Navigator.pushNamed(context, "/removeDebit")},
                    ),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.only(top: 10.0),),
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
                      onPressed: () => {Navigator.pushNamed(context, "/users")},
                    ),
                  )
                ],
              ),
            ],
          )),
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Warning"),
          content: Text("Do you really want to exit?"),
          actions: [
            ElevatedButton(
              child: Text("Yes"),
              onPressed: () {
                _futureBaseResponse = NetworkFunctions.adminLogoff();
                _futureBaseResponse.then((value) {
                  if (value.success) {
                    Navigator.pop(context, true);
                  }
                });
              },
            ),
            ElevatedButton(
              child: Text("No"),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
