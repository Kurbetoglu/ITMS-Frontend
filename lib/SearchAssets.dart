import 'package:flutter/material.dart';

import 'UpdateAsset.dart';
import 'models/GetAllAssetsResponse.dart';
import 'network/NetworkFunctions.dart';

String typeValue, addedDateValue, isAssignedValue;

class SearchAssets extends StatefulWidget {
  @override
  _SearchAssetsState createState() => _SearchAssetsState();
}

class _SearchAssetsState extends State<SearchAssets> {
  Future<GetAllAssetsResponse> _futureGetAllAssetsResponse;

  @override
  void initState() {
    _futureGetAllAssetsResponse = NetworkFunctions.getAllAssets(0, 0);
    _futureGetAllAssetsResponse.then((value) {
      setState(() {});
    });
    super.initState();
  }

  updateWidget(int number){
    _futureGetAllAssetsResponse = NetworkFunctions.getAllAssets(0, 0);
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
            title: Text("SEARCH ASSETS"),
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
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Container(
              padding: EdgeInsets.all(10),
              child: _futureGetAllAssetsResponse == null
                ? Container(width: 0, height: 0,)
                : generateCustomDataRows(),
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
            label: Text('Id'),
          ),
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
        ],
        rows: widget.assetRecords
            .map((assetRecord) => DataRow(
            cells: [
                  DataCell(
                      Text(assetRecord.id.toString()),
                      onTap: () => navigateToUpdateAssetPage(assetRecord)
                  ),
                  DataCell(
                      Text(assetRecord.type),
                      onTap: () => navigateToUpdateAssetPage(assetRecord)
                  ),
                  DataCell(
                      Text(assetRecord.name),
                      onTap: () => navigateToUpdateAssetPage(assetRecord)
                  ),
                  DataCell(
                      Text(assetRecord.description),
                      onTap: () => navigateToUpdateAssetPage(assetRecord)
                  ),
                  DataCell(
                      Text(assetRecord.addedDate),
                      onTap: () => navigateToUpdateAssetPage(assetRecord)
                  ),
                  DataCell(
                      Text(assetRecord.isAssigned.toString()),
                      onTap: () => navigateToUpdateAssetPage(assetRecord)
                  ),
                ]))
            .toList(),
      ),
    );
  }

  void navigateToUpdateAssetPage(AssetRecord assetRecord){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateAsset(assetRecord, widget.parentAction)
        )
    );
  }
}
