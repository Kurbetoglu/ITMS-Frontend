import 'package:asset_yonet/RemoveDebitConfirm.dart';
import 'package:flutter/material.dart';

import 'DTO/GetAllDebitsResponse.dart';
import 'network/NetworkFunctions.dart';

class RemoveDebit extends StatefulWidget {
  const RemoveDebit({Key key}) : super(key: key);

  @override
  _RemoveDebitState createState() => _RemoveDebitState();
}

class _RemoveDebitState extends State<RemoveDebit> {
  String typeValue, assetNameValue, isDeliveredValue;
  TextEditingController searchController = TextEditingController();
  Future<GetAllDebitsResponse> _futureGetAllDebitsResponse;
  List<DebitRecord> debitRecords;
  int pageCount;

  @override
  void initState() {
    typeValue = null;
    assetNameValue = null;
    isDeliveredValue = null;
    pageCount = 1;

    updateWidget(1);

    super.initState();
  }

  @override
  void dispose(){
    typeValue = null;
    assetNameValue = null;
    isDeliveredValue = null;
    _futureGetAllDebitsResponse = null;
    searchController.dispose();
    super.dispose();
  }

  updateWidget(int number){
    _futureGetAllDebitsResponse = NetworkFunctions.getAllDebits(searchController.text, pageCount, NetworkFunctions.maxDataPerPage, typeValue, isDeliveredValue, assetNameValue);
    _futureGetAllDebitsResponse.then((value) {
      if(value.success){
        setState(() {});
      }
    });
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
                    height: 40,
                    child: TextFormField(controller: searchController,)
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120.0,
                  height: 40.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: typeValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Type',
                      'Fiziksel',
                      'Dijital',
                      'İnsan Kaynağı',
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
                        typeValue = value == 'Type' ? null : value;
                        updateWidget(1);
                      });
                    },
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 40.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: assetNameValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Asset Name',
                      'Azalan',
                      'Artan',
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
                      "Asset Name",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        assetNameValue = value == 'Asset Name' ? null : value;
                        updateWidget(1);
                      });
                    },
                  ),
                ),
                Container(
                  width: 130.0,
                  height: 40.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: isDeliveredValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Is Delivered?',
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
                      'Is Delivered?',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        isDeliveredValue = value == 'Is Delivered?' ? null : value;
                        updateWidget(1);
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
                      _futureGetAllDebitsResponse = NetworkFunctions.getAllDebits(searchController.text, pageCount, NetworkFunctions.maxDataPerPage, typeValue, isDeliveredValue, assetNameValue);
                      _futureGetAllDebitsResponse.then((value) {
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
        return CustomCardWithDelete(debitRecords[index], parentAction);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class CustomCardWithDelete extends StatefulWidget {
  CustomCardWithDelete(this.debitRecord, this.parentAction);
  DebitRecord debitRecord;
  ValueChanged<int> parentAction;

  @override
  CustomCardWithDeleteWidget createState() => CustomCardWithDeleteWidget();
}

class CustomCardWithDeleteWidget extends State<CustomCardWithDelete> {
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
                  height: 25,
                  color: Color(0xffc53737),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Remove"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RemoveDebitConfirm(widget.debitRecord.id, widget.parentAction)
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
                valueContainer(widget.debitRecord.assigner),
              ],
            ),
            Row(
              children: [
                labelContainer("User"),
                valueContainer(widget.debitRecord.user),
              ],
            ),
            Row(
              children: [
                labelContainer("Asset Type"),
                valueContainer(widget.debitRecord.assetType),
              ],
            ),
            Row(
              children: [
                labelContainer("Asset Name"),
                valueContainer(widget.debitRecord.assetName),
              ],
            ),
            Row(
              children: [
                labelContainer("Asset Desc."),
                valueContainer(widget.debitRecord.assetDescription),
              ],
            ),
            Row(
              children: [
                labelContainer("Start Date"),
                valueContainer(widget.debitRecord.startDate),
              ],
            ),
            Row(
              children: [
                labelContainer("End Date"),
                valueContainer(widget.debitRecord.endDate),
              ],
            ),
            Row(
              children: [
                labelContainer("Created Date"),
                valueContainer(widget.debitRecord.createdDate),
              ],
            ),
            Row(
              children: [
                labelContainer("Edited Date"),
                valueContainer(widget.debitRecord.editedDate),
              ],
            ),
            Row(
              children: [
                labelContainer("isDelivered"),
                valueContainer(widget.debitRecord.isDelivered.toString()),
              ],
            ),
            Row(
              children: [
                labelContainer("Cause"),
                valueContainer(widget.debitRecord.cause),
              ],
            ),
          ],
        )
    );
  }

  Container labelContainer(String labelName){
    return Container(
        width: 90,
        height: 25,
        alignment: Alignment.centerLeft,
        padding: EdgeInsetsDirectional.only(start: 5),
        color: Color(0xff4e9b2b),
        child: Text(labelName)
    );
  }

  Container valueContainer(String valueName){
    return Container(
        height: 25,
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.only(start: 5),
        child: Text(valueName)
    );
  }
}
