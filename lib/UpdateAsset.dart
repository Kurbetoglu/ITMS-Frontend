import 'package:asset_yonet/network/NetworkFunctions.dart';
import 'package:flutter/material.dart';

import 'models/BaseResponse.dart';
import 'models/GetAllAssetsResponse.dart';

DateTime selectedDate;
String typeValue, radioButtonItem;
int radioButtonId;

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
  TextEditingController _personSurnameController = TextEditingController();
  TextEditingController personEmailController = TextEditingController();

  @override
  void initState(){
    typeValue = widget.assetRecord.type;
    selectedDate = DateTime.now();
    nameController.text = widget.assetRecord.name;
    descriptionController.text = widget.assetRecord.description;
    personNameController.text = typeValue == "İnsan Kaynağı" ? widget.assetRecord.personName : null;
    _personSurnameController.text = typeValue == "İnsan Kaynağı" ? widget.assetRecord.personSurname : null;
    personEmailController.text = typeValue == "İnsan Kaynağı" ? widget.assetRecord.personEmail : null;
  }

  @override
  void dispose(){
    typeValue = "";
    selectedDate = null;
    nameController.dispose();
    descriptionController.dispose();
    personNameController.dispose();
    _personSurnameController.dispose();
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
                  child: RadioGroup(widget.assetRecord.isAssigned),
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
                      controller: _personSurnameController,
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
                      bool _isAssigned;
                      if(radioButtonId == 1){
                        _isAssigned = true;
                      } else {
                        _isAssigned = false;
                      }

                      bool expiryDateHasChanged = false;
                      if(selectedDate.year != DateTime.now().year &&
                          selectedDate.month != DateTime.now().month &&
                          selectedDate.day != DateTime.now().day){
                        expiryDateHasChanged = true;
                      }

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
                              _personSurnameController.text,
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

class RadioGroup extends StatefulWidget {
  RadioGroup(this.isAssigned);
  bool isAssigned;
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State<RadioGroup> {
  Widget build(BuildContext context) {
    radioButtonItem = widget.isAssigned ? 'YES' : 'NO';
    radioButtonId = widget.isAssigned ? 1 : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Is Assigned?',
          style: TextStyle(fontSize: 16),
        ),
        Radio(
          value: 1,
          groupValue: radioButtonId,
          onChanged: (dynamic val) {
            setState(() {
              radioButtonItem = 'YES';
              radioButtonId = 1;
            });
          },
        ),
        Text(
          'YES',
        ),

        Radio(
          value: 0,
          groupValue: radioButtonId,
          onChanged: (dynamic val) {
            setState(() {
              radioButtonItem = 'NO';
              radioButtonId = 0;
            });
          },
        ),
        Text(
          'NO',
        ),
      ],
    );
  }
}
