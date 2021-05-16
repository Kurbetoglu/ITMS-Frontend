import 'package:asset_yonet/Users.dart';
import 'package:asset_yonet/addAsset.dart';
import 'package:asset_yonet/addDebit.dart';
import 'package:asset_yonet/addUser.dart';
import 'package:asset_yonet/editAsset.dart';
import 'package:asset_yonet/editDebit.dart';
import 'package:asset_yonet/editUser.dart';
import 'package:asset_yonet/homepage.dart';
import 'package:asset_yonet/removeAssetConfirm.dart';
import 'package:asset_yonet/removeDebit.dart';
import 'package:asset_yonet/removeDebitConfirm.dart';
import 'package:asset_yonet/removeUserConfirm.dart';
import 'package:asset_yonet/searchDebits.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/addAsset": (context) => addAsset(),
        "/addDebit": (context) => addDebit(),
        "/addUser": (context) => addUser(),
        "/homepage": (context) => homepage(),
        "/removeDebit": (context) => removeDebit(),
        "/searchDebits": (context) => searchDebits(),
        "/users": (context) => users(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOG IN"),
        backgroundColor: Color(0xff67acb0),
      ),
      backgroundColor: Color(0xff518199),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                  autovalidate: true,
                  child: Theme(
                    data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ))),
                    child: Container(
                      width: 300.0,
                      height: 300.0,
                      color: Color(0xff67acb0),
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Email",
                                fillColor: Color(0xfff0e8ca),
                                filled: true),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Color(0xff707070)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Password",
                                fillColor: Color(0xfff0e8ca),
                                filled: true
                            ),
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Color(0xff707070)),
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                          ),
                          MaterialButton(
                            color: Color(0xff4e9b2b),
                            textColor: Colors.white,
                            child: Text("LOGIN"),
                            onPressed: () =>
                                {Navigator.pushNamed(context, "/homepage")},
                            splashColor: Colors.green[900],
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
