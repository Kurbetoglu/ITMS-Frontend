import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'RemoveUserConfirm.dart';
import 'models/GetAllUsersResponse.dart';

class RemoveUser extends StatefulWidget {
  @override
  _RemoveUserState createState() => _RemoveUserState();
}

class _RemoveUserState extends State<RemoveUser> {
  Future<GetAllUsersResponse> _futureGetAllUsersResponse;

  @override
  void initState() {
    _futureGetAllUsersResponse = NetworkFunctions.getAllUsers(0, 0);
    _futureGetAllUsersResponse.then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff518199),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName("/users")),
            ),
            title: Text("REMOVE USER"),
            backgroundColor: Color(0xff67acb0),
          ),
          body: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        color: Color(0xfff0e8ca),
                        width: 280,
                        height: 30,
                        child: TextFormField()),
                    Container(
                      width: 100.0,
                      height: 30.0,
                      color: Color(0xff4e9b2b),
                      child: MaterialButton(
                        textColor: Colors.white,
                        child: Text("Search"),
                        onPressed: () => {},
                      ),
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0),),
                Container(
                  padding: EdgeInsets.all(10),
                  child: _futureGetAllUsersResponse == null
                    ? Container(width: 0, height: 0,)
                    : generateCustomDataRows(),
                ),
              ]
          )
      ),
    );
  }

  FutureBuilder<GetAllUsersResponse> generateCustomDataRows() {
    return FutureBuilder<GetAllUsersResponse>(
      future: _futureGetAllUsersResponse,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        return snapshot.hasData
            ? CustomDataRow(snapshot.data.records)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class CustomDataRow extends StatefulWidget {
  CustomDataRow(this.userRecords);
  List<UserRecord> userRecords;

  @override
  CustomDataRowWidget createState() => CustomDataRowWidget();
}

class CustomDataRowWidget extends State<CustomDataRow> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10,
        horizontalMargin: 5,
        headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Color(0xff4e9b2b);
        }),
        dataRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Color(0xfff0e8ca);
        }),
        headingTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        columns: [
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Surname'),
          ),
          DataColumn(
            label: Text('Email'),
          ),
          DataColumn(
            label: Text('Telephone Number'),
          ),
          DataColumn(
            label: Text('REMOVE', style: TextStyle(color: Colors.red),),
          ),
        ],
        rows: widget.userRecords
            .map((userRecord) => DataRow(
            cells: [
                  DataCell(Text(userRecord.name)),
                  DataCell(Text(userRecord.surname)),
                  DataCell(Text(userRecord.email)),
                  DataCell(Text(userRecord.telephoneNumber)),
                  DataCell(Text("REMOVE", style: TextStyle(color: Colors.red),), onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RemoveUserConfirm(userRecord.id)
                      ),
                    );
                  } ),
                ]))
            .toList(),
      ),
    );
  }
}
