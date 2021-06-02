import 'package:asset_yonet/RemoveAssetConfirm.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'DTO/GetAllAssetsResponse.dart';

String typeValue, addedDateValue, isAssignedValue;

class RemoveAsset extends StatefulWidget {
  @override
  _RemoveAssetState createState() => _RemoveAssetState();
}

class _RemoveAssetState extends State<RemoveAsset> {
  TextEditingController searchController = TextEditingController();
  Future<GetAllAssetsResponse> _futureGetAllAssetsResponse;

  @override
  void initState() {
    _futureGetAllAssetsResponse = NetworkFunctions.getAllAssets(null, 0, 0);
    _futureGetAllAssetsResponse.then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose(){
    typeValue = null;
    addedDateValue = null;
    isAssignedValue = null;
    searchController.dispose();
    super.dispose();
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
                  Navigator.popUntil(context, ModalRoute.withName("/homepage")),
            ),
            title: Text("REMOVE ASSETS"),
            backgroundColor: Color(0xff67acb0),
          ),
          body: ListView(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    color: Color(0xfff0e8ca),
                    width: 280,
                    height: 30,
                    child: TextFormField(controller: searchController,)),
                Container(
                  width: 100.0,
                  height: 30.0,
                  color: Color(0xff4e9b2b),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Search"),
                    onPressed: () {
                      _futureGetAllAssetsResponse = NetworkFunctions.getAllAssets(searchController.text, 0, 0);
                      _futureGetAllAssetsResponse.then((value) {
                        setState(() {});
                      });
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
                    value: addedDateValue,
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
                        addedDateValue = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: isAssignedValue,
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
                        isAssignedValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: _futureGetAllAssetsResponse == null
                ? Container(width: 0, height: 0,)
                : generateCustomDataRows(),
            ),

          ])),
    );
  }

  FutureBuilder<GetAllAssetsResponse> generateCustomDataRows() {
    return FutureBuilder<GetAllAssetsResponse>(
      future: _futureGetAllAssetsResponse,
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
  List<AssetRecord> assetRecords;

  CustomDataRow(List<AssetRecord> assetRecords) {
    this.assetRecords = assetRecords;
  }

  @override
  CustomDataRowWidget createState() => CustomDataRowWidget(assetRecords);
}

class CustomDataRowWidget extends State<CustomDataRow> {
  List<AssetRecord> assetRecords;

  CustomDataRowWidget(List<AssetRecord> assetRecords) {
    this.assetRecords = assetRecords;
  }

  updateWidget(int number){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 15,
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
            label: Text('Type'),
          ),
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Description'),
          ),
          DataColumn(
            label: Text('AddedDate'),
          ),
          DataColumn(
            label: Text('Is Assigned?'),
          ),
          DataColumn(
            label: Text('REMOVE', style: TextStyle(color: Colors.red),),
          ),
        ],
        rows: assetRecords
            .map((assetRecord) => DataRow(
            cells: [
                  DataCell(Text(assetRecord.type)),
                  DataCell(Text(assetRecord.name)),
                  DataCell(Text(assetRecord.description)),
                  DataCell(Text(assetRecord.addedDate)),
                  DataCell(Text(assetRecord.isAssigned.toString())),
                  DataCell(Text("REMOVE", style: TextStyle(color: Colors.red),), onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RemoveAssetConfirm(assetRecord.id, updateWidget)
                        ),
                    );
                  } ),
                ]))
            .toList(),
      ),
    );
  }
}
