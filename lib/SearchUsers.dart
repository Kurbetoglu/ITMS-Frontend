import 'package:flutter/material.dart';

import 'UpdateUser.dart';
import 'DTO/GetAllUsersResponse.dart';
import 'network/NetworkFunctions.dart';

class SearchUsers extends StatefulWidget {
  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  TextEditingController searchController = TextEditingController();
  Future<GetAllUsersResponse> _futureGetAllUsersResponse;
  int pageCount;

  @override
  void initState() {
    pageCount = 1;

    updateWidget(1);

    super.initState();
  }

  @override
  void dispose() {
    pageCount = 1;
    _futureGetAllUsersResponse = null;
    searchController.dispose();
    super.dispose();
  }

  updateWidget(int number){
    _futureGetAllUsersResponse = NetworkFunctions.getAllUsers(searchController.text, pageCount, NetworkFunctions.maxDataPerPage);
    _futureGetAllUsersResponse.then((value) {
      if(value.success){
        setState(() {});
      }
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
            title: Text("SEARCH USERS"),
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
                        height: 40,
                        child: TextFormField(controller: searchController,)),
                    Container(
                      width: 100.0,
                      height: 40.0,
                      color: Color(0xff4e9b2b),
                      child: MaterialButton(
                        textColor: Colors.white,
                        child: Text("Search"),
                        onPressed: () {
                          updateWidget(1);
                        },
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
                Padding(padding: const EdgeInsets.only(top: 10.0),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: ElevatedButton(
                        child: Text("<"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Color(0xff4e9b2b);
                              }),
                        ),
                        onPressed: () {
                          if(pageCount > 1){
                            pageCount -= 1;
                            updateWidget(1);
                          }
                        },
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text(
                          pageCount.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Color(0xfff0e8ca);
                              }),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text(">"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return Color(0xff4e9b2b);
                              }),
                        ),
                        onPressed: () {
                          pageCount += 1;
                          _futureGetAllUsersResponse = NetworkFunctions.getAllUsers(searchController.text, pageCount, NetworkFunctions.maxDataPerPage);
                          _futureGetAllUsersResponse.then((value) {
                            if(value.success){
                              if(value.dataCount != 0){
                                setState(() {});
                              }
                              else {
                                pageCount -= 1;
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ],
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
            ? CustomDataRow(snapshot.data.records, updateWidget)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class CustomDataRow extends StatefulWidget {
  CustomDataRow(this.userRecords, this.parentAction);
  List<UserRecord> userRecords;
  ValueChanged<int> parentAction;

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
        ],
        rows: widget.userRecords
            .map((userRecord) => DataRow(
            cells: [
                  DataCell(
                      Text(userRecord.name),
                      onTap: () => navigateToUpdateUserPage(userRecord)
                  ),
                  DataCell(
                      Text(userRecord.surname),
                      onTap: () => navigateToUpdateUserPage(userRecord)
                  ),
                  DataCell(
                      Text(userRecord.email),
                      onTap: () => navigateToUpdateUserPage(userRecord)
                  ),
                  DataCell(
                      Text(userRecord.telephoneNumber),
                      onTap: () => navigateToUpdateUserPage(userRecord)
                  ),
                ]))
            .toList(),
      ),
    );
  }

  void navigateToUpdateUserPage(UserRecord userRecord){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateUser(userRecord, widget.parentAction)
        )
    );
  }
}
