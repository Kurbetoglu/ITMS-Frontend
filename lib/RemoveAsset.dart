import 'package:asset_yonet/RemoveAssetConfirm.dart';
import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'DTO/GetAllAssetsResponse.dart';

class RemoveAsset extends StatefulWidget {
  @override
  _RemoveAssetState createState() => _RemoveAssetState();
}

class _RemoveAssetState extends State<RemoveAsset> {
  String typeValue, nameValue, isAssignedValue;
  TextEditingController searchController = TextEditingController();
  Future<GetAllAssetsResponse> _futureGetAllAssetsResponse;
  int pageCount;
  @override
  void initState() {
    typeValue = null;
    nameValue = null;
    isAssignedValue = null;
    pageCount = 1;

    updateWidget(1);
    super.initState();
  }

  @override
  void dispose(){
    typeValue = null;
    nameValue = null;
    isAssignedValue = null;
    pageCount = 1;
    searchController.dispose();
    _futureGetAllAssetsResponse = null;
    super.dispose();
  }

  updateWidget(int number){
    _futureGetAllAssetsResponse = NetworkFunctions.getAllAssets(searchController.text, pageCount, NetworkFunctions.maxDataPerPage, typeValue, isAssignedValue, nameValue);
    _futureGetAllAssetsResponse.then((value) {
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
                  Navigator.popUntil(context, ModalRoute.withName("/homepage")),
            ),
            title: Text("REMOVE ASSET"),
            backgroundColor: Color(0xff67acb0),
          ),
          body: ListView(children: <Widget>[
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
                    value: nameValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Name',
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
                      "Name",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        nameValue = value == 'Name' ? null : value;
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
                    value: isAssignedValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Is Assigned?',
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
                      "Is Assigned?",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        isAssignedValue = value == 'Is Assigned?' ? null : value;
                        updateWidget(1);
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Container(
              padding: EdgeInsets.all(10),
              child: _futureGetAllAssetsResponse == null
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
                      _futureGetAllAssetsResponse = NetworkFunctions.getAllAssets(searchController.text, pageCount, NetworkFunctions.maxDataPerPage, typeValue, isAssignedValue, nameValue);
                      _futureGetAllAssetsResponse.then((value) {
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

  FutureBuilder<GetAllAssetsResponse> generateCustomDataRows() {
    return FutureBuilder<GetAllAssetsResponse>(
      future: _futureGetAllAssetsResponse,
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
  CustomDataRow(this.assetRecords, this.parentAction);

  List<AssetRecord> assetRecords;
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
        rows: widget.assetRecords
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
                            builder: (context) => RemoveAssetConfirm(assetRecord.id, widget.parentAction)
                        ),
                    );
                  } ),
                ]))
            .toList(),
      ),
    );
  }
}
