import 'package:asset_yonet/RemoveDebitConfirm.dart';
import 'package:flutter/material.dart';

import 'models/GetAllDebitsResponse.dart';
import 'network/NetworkFunctions.dart';

String typeValue, startDateValue, endDateValue, isDeliveredValue;

class RemoveDebit extends StatefulWidget {
  const RemoveDebit({Key key}) : super(key: key);

  @override
  _RemoveDebitState createState() => _RemoveDebitState();
}

class _RemoveDebitState extends State<RemoveDebit> {
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

  @override
  void dispose(){
    typeValue = null;
    startDateValue = null;
    endDateValue = null;
    isDeliveredValue = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            Navigator.popUntil(context, ModalRoute.withName("/homepage"));
          }
        ),
        title: Text("REMOVE DEBIT"),
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
                    child: TextFormField()
                ),
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
                      'İnsan ',
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
                      'En Yeni',
                      'En Eski',
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
                  width: 100.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: endDateValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'En Yeni',
                      'En Eski',
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
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Flexible(
              child: _futureGetAllDebitsResponse == null ? Container(width: 0, height: 0,) : buildCustomCards(),
            ),
          ]
      ),
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
            ? DebitRecordList(snapshot.data.records)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

class DebitRecordList extends StatelessWidget {
  DebitRecordList(this.debitRecords);
  List<DebitRecord> debitRecords;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: debitRecords.length,
      itemBuilder: (BuildContext context, int index) {
        return CustomCardWithDelete(debitRecords[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class CustomCardWithDelete extends StatefulWidget {
  CustomCardWithDelete(this.debitRecord);
  DebitRecord debitRecord;

  @override
  CustomCardWithDeleteWidget createState() => CustomCardWithDeleteWidget();
}

class CustomCardWithDeleteWidget extends State<CustomCardWithDelete> {
  updateWidget(int number){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xfff0e8ca),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 387,
                  height: 20,
                  color: Color(0xffc53737),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Remove"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RemoveDebitConfirm(widget.debitRecord.id, updateWidget)
                          )
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Assigner"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.assigner)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("User"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.user)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Asset Type"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.assetType)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Asset Name"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.assetName)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Asset Desc."),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.assetDescription)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Start Date"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.startDate)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("End Date"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.endDate)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Created Date"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.createdDate)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Edited Date"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.editedDate)
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("isDelivered"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.isDelivered.toString())
                ),
              ],
            ),
            Row(
              children: [
                labelContainer("Cause"),
                Container(
                    height: 20,
                    child: Text(widget.debitRecord.cause)
                ),
              ],
            ),
          ],
        )
    );
  }

  Container labelContainer(String labelName){
    return Container(
        width: 90,
        height: 20,
        color: Color(0xff4e9b2b),
        child: Text(labelName)
    );
  }
}
