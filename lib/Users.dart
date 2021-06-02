import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName("/homepage")),
          ),
          title: Text("USERS"),
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
                      child: Text("Search Users"),
                      onPressed: () => Navigator.pushNamed(context, "/searchUsers"),
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
                    child: Text("Add User"),
                    onPressed: () => Navigator.pushNamed(context, "/addUser"),
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
                    child: Text("Remove User"),
                    onPressed: () => Navigator.pushNamed(context, "/removeUser"),
                  ),
                )
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
          ],
        )
    );
  }
}


