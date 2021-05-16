import 'package:flutter/material.dart';
import 'main.dart';
String _chosenValue;

class addAsset extends StatefulWidget {
  const addAsset({Key key}) : super(key: key);

  @override
  _addAssetState createState() => _addAssetState();
}

class _addAssetState extends State<addAsset> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName("/homepage")),
          ),
          title: Text("ADD ASSET"),
          backgroundColor: Color(0xff67acb0),
        ),
        backgroundColor: Color(0xff518199),   body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300.0,
                height: 30.0,
                color: Color(0xfff0e8ca),
                child:
                DropdownButton<String>(
                  value: _chosenValue,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor:Colors.black,
                  items: <String>[
                    'Fiziksel',
                    'Dijital',
                    'İnsan Kaynağı',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style:TextStyle(color:Colors.black,fontSize: 14),),
                    );
                  }).toList(),
                  hint:Text(
                    "Type",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                    }); },
                ),
              ),

            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10.0),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: TextFormField( decoration: InputDecoration(hintText: "Name"),)

              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
          ),//1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: Center(child: TextFormField( decoration: InputDecoration(hintText: "Desctription"),)
                  )
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
          ),//2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: Center(child: TextFormField( decoration: InputDecoration(hintText: "Expiry Date(if type is equal tı digital)"),)
                  )
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
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: Center(child: TextFormField( decoration: InputDecoration(hintText: "Person Name(if type is equal to HR)"),)
                  )
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
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: Center(child: TextFormField( decoration: InputDecoration(hintText: "Person Surname(if type is equal to HR)"),)
                  )
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
                  width: 300.0,
                  height: 30.0,
                  color: Color(0xfff0e8ca),
                  child: Center(child: TextFormField( decoration: InputDecoration(hintText: "Person Email(if type is equal to HR)"),)
                  )
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
                width: 120.0,
                height: 50.0,
                color: Color(0xff4e9b2b),
                child: MaterialButton(
                  textColor: Colors.white,
                  child: Text("Add Asset"),
                  onPressed: () => {},
                ),
              ),
              Container(
                width: 120.0,
                height: 50.0,
                color: Color(0xffc53737),
                child: MaterialButton(
                  textColor: Colors.white,
                  child: Text("Cancel"),
                  onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName("/homepage")),
                ),
              )
            ],
          ),
          //3
        ],
      )
    );
  }
}
