import 'package:flutter/material.dart';

import 'network/NetworkFunctions.dart';
import 'DTO/BaseResponse.dart';
import 'DTO/GetAllAssetsResponse.dart';

class UpdateAsset extends StatefulWidget {
  UpdateAsset(this.assetRecord, this.parentAction);
  AssetRecord assetRecord;
  ValueChanged<int> parentAction;

  @override
  _UpdateAssetState createState() => _UpdateAssetState();
}

class _UpdateAssetState extends State<UpdateAsset> {
  Future<BaseResponse> _futureBaseResponse;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController personNameController = TextEditingController();
  TextEditingController personSurnameController = TextEditingController();
  TextEditingController personEmailController = TextEditingController();
  bool _isAssigned;
  DateTime selectedDate = DateTime.now();
  String typeValue;
  @override
  void initState(){
    typeValue = widget.assetRecord.type;
    _isAssigned = widget.assetRecord.isAssigned;
    nameController.text = widget.assetRecord.name;
    descriptionController.text = widget.assetRecord.description;
    personNameController.text = typeValue == "İnsan Kaynağı" ? widget.assetRecord.personName : null;
    personSurnameController.text = typeValue == "İnsan Kaynağı" ? widget.assetRecord.personSurname : null;
    personEmailController.text = typeValue == "İnsan Kaynağı" ? widget.assetRecord.personEmail : null;
    setState(() { });
    super.initState();
  }

  @override
  void dispose(){
    typeValue = null;
    selectedDate = null;
    nameController.dispose();
    descriptionController.dispose();
    personNameController.dispose();
    personSurnameController.dispose();
    personEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.pop(context),
          ),
          title: Text("UPDATE ASSET"),
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
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: DropdownButton<String>(
                    value: widget.assetRecord.type,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
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
                        typeValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child:TextField(
                    controller: nameController,
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child:TextField(
                    controller: descriptionController,
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child:Text("Added Date: " + widget.assetRecord.addedDate),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300.0,
                  height: 50.0,
                  color: Color(0xfff0e8ca),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Is Assigned?'),
                      LabeledRadio(
                        label: 'YES',
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        value: true,
                        groupValue: _isAssigned,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isAssigned = newValue;
                          });
                        },
                      ),
                      LabeledRadio(
                        label: 'NO',
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        value: false,
                        groupValue: _isAssigned,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isAssigned = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "Dijital" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xfff0e8ca),
                      ),
                      onPressed: () {
                        selectDate(context);
                      },
                      child: Text(
                        selectedDate.day == DateTime.now().day ? "Expiry Date: " + widget.assetRecord.expiryDate : "Expiry Date: " + selectedDate.toString(),
                        style: TextStyle(color: Color(0xff707070),),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "İnsan Kaynağı" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child:TextField(
                      controller: personNameController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "İnsan Kaynağı" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child:TextField(
                      controller: personSurnameController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Visibility(
              visible: typeValue == "İnsan Kaynağı" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child:TextField(
                      controller: personEmailController,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 10.0),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xff4e9b2b),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Save Changes", style: TextStyle(fontSize: 13),),
                    onPressed: () {
                      bool expiryDateHasChanged = false;
                      if(selectedDate.year != DateTime.now().year ||
                          selectedDate.month != DateTime.now().month ||
                          selectedDate.day != DateTime.now().day){
                        expiryDateHasChanged = true;
                      }

                      print(expiryDateHasChanged);

                      switch (typeValue) {
                        case "Fiziksel": {
                          _futureBaseResponse = NetworkFunctions.updateAsset(
                              widget.assetRecord.id,
                              typeValue,
                              nameController.text,
                              descriptionController.text,
                              0,
                              null,
                              null,
                              null,
                              _isAssigned
                          );
                        }
                        break;

                        case "Dijital": {
                          _futureBaseResponse = NetworkFunctions.updateAsset(
                              widget.assetRecord.id,
                              typeValue,
                              nameController.text,
                              descriptionController.text,
                              expiryDateHasChanged ? (selectedDate.toUtc().millisecondsSinceEpoch~/1000) : 0,
                              null,
                              null,
                              null,
                              _isAssigned
                          );
                        }
                        break;

                        case "İnsan Kaynağı": {
                          _futureBaseResponse = NetworkFunctions.updateAsset(
                              widget.assetRecord.id,
                              typeValue,
                              nameController.text,
                              descriptionController.text,
                              0,
                              personNameController.text,
                              personSurnameController.text,
                              personEmailController.text,
                              _isAssigned
                          );
                        }
                        break;
                      }

                      _futureBaseResponse.then((value) {
                        if(value.success){
                          widget.parentAction(1);
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ),
                Container(
                  width: 120.0,
                  height: 50.0,
                  color: Color(0xffc53737),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
          ],
        )
    );
  }
  Future selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2222));
    if (picked != null && picked!= selectedDate) {
      setState(() => selectedDate = picked);
    }
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key key,
    this.label,
    this.padding,
    this.groupValue,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}