import 'package:asset_yonet/Users.dart';
import 'package:asset_yonet/AddAsset.dart';
import 'package:asset_yonet/AddDebit.dart';
import 'package:asset_yonet/AddUser.dart';
import 'package:asset_yonet/Homepage.dart';
import 'package:asset_yonet/models/AdminLoginResponse.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:asset_yonet/RemoveDebit.dart';
import 'package:asset_yonet/SearchDebits.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{

  runApp(MyApp());
}
Future<bool> cookieChecker() async{
  SharedPreferences initialPrefs = await SharedPreferences.getInstance();
  bool checkCookie = initialPrefs.containsKey("cookie");
  return checkCookie;
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/addAsset": (context) => AddAsset(),
        "/addDebit": (context) => AddDebit(),
        "/addUser": (context) => AddUser(),
        "/homepage": (context) => Homepage(),
        "/removeDebit": (context) => RemoveDebit(),
        "/searchDebits": (context) => SearchDebits(),
        "/users": (context) => Users(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  Future<AdminLoginResponse> _futureAdminLoginResponse;

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    cookieChecker().then((value) {
      if(value){
        Navigator.pushNamed(context, "/homepage");
      }
    });
    super.initState();
  }
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
                            controller: emailTextEditingController,
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
                            controller: passwordTextEditingController,
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
                            onPressed: () {
                              if(emailTextEditingController.text.isNotEmpty && passwordTextEditingController.text.isNotEmpty){
                                _futureAdminLoginResponse = NetworkFunctions.adminLogin(emailTextEditingController.text, passwordTextEditingController.text);
                                _futureAdminLoginResponse.then((response) {
                                  if(response.success){
                                    Navigator.pushNamed(context, "/homepage");
                                  }
                                  else {
                                    print("login error");
                                  }
                                }
                                );
                              }
                            },
                            splashColor: Colors.green[900],
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}

