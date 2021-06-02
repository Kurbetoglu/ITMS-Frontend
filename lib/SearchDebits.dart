import 'package:asset_yonet/models/GetAllDebitsResponse.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'UpdateDebit.dart';

String typeValue, startDateValue, endDateValue, isDeliveredValue;

class SearchDebits extends StatefulWidget {
  SearchDebits({Key key}) : super(key: key);

  @override
  _SearchDebitsState createState() => _SearchDebitsState();
}

class _SearchDebitsState extends State<SearchDebits> {
  Future<GetAllDebitsResponse> _futureGetAllDebitsResponse;
  List<DebitRecord> debitRecords;

  @override
  void initState() {
    _futureGetAllDebitsResponse = NetworkFunctions.getAllDebits(0, 0);
    _futureGetAllDebitsResponse.then((value) {
      setState(() { });
    });
    super.initState();
  }

  updateWidget(int number){
    _futureGetAllDebitsResponse = NetworkFunctions.getAllDebits(0, 0);
    _futureGetAllDebitsResponse.then((value) {
      setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.popUntil(context, ModalRoute.withName("/homepage")),
        ),
        title: Text("SEARCH DEBITS"),
        backgroundColor: Color(0xff67acb0),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff518199),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 75.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: typeValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Fiziksel',
                      'Dijital',
                      'İnsan',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Type",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        typeValue = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 90.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: startDateValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Önce Yeni',
                      'Önce Eski',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Start Date",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        startDateValue = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 90.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: endDateValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Önce Yeni',
                      'Önce Eski',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "End Date",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        endDateValue = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: isDeliveredValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'True',
                      'False',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "isDelivered",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        isDeliveredValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Flexible(
              child: _futureGetAllDebitsResponse == null ? Container(width: 0, height: 0,) : buildCustomCards(),
            ),
          ]),
    );
  }

  FutureBuilder<GetAllDebitsResponse> buildCustomCards(){
    return FutureBuilder<GetAllDebitsResponse>(
      future: _futureGetAllDebitsResponse,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        return snapshot.hasData
            ? DebitRecordList(snapshot.data.records, updateWidget)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class DebitRecordList extends StatelessWidget {
  DebitRecordList(this.debitRecords, this.parentAction);
  List<DebitRecord> debitRecords;
  ValueChanged<int> parentAction;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: debitRecords.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomCard(debitRecords[index], parentAction);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class CustomCard extends StatefulWidget {
  CustomCard(this.debitRecord, this.parentAction);
  DebitRecord debitRecord;
  ValueChanged<int> parentAction;

  @override
  CustomCardWidget createState() => CustomCardWidget();
}

class CustomCardWidget extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateDebit(widget.debitRecord, widget.parentAction)
            )
        );
      } ,
      child: Card(
          color: Color(0xfff0e8ca),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Assigner")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.assigner)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("User")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.user)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Asset Type")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.assetType)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Asset Name")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.assetName)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Asset Desc.")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.assetDescription)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Start Date")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.startDate)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("End Date")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.endDate)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Created Date")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.createdDate)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Edited Date")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.editedDate)),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("isDelivered")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.isDelivered.toString())),
                ],
              ),

              Row(
                children: [
                  Container(
                      width: 90,
                      height: 20,
                      color: Color(0xff4e9b2b),
                      child: Text("Cause")),
                  Container(
                      height: 20,
                      child: Text(widget.debitRecord.cause)),
                ],
              ),
            ],
          )),
    ) ;
  }
}
