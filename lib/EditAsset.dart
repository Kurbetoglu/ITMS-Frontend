import 'package:flutter/material.dart';

String _chosenValue;

class EditAsset extends StatefulWidget {
  const EditAsset({Key key}) : super(key: key);

  @override
  _EditAssetState createState() => _EditAssetState();
}

class _EditAssetState extends State<EditAsset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName("/homepage")),
          ),
          title: Text("EDIT ASSET"),
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
                    value: _chosenValue,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Android',
                      'IOS',
                      'Flutter',
                      'Node',
                      'Java',
                      'Python',
                      'PHP',
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
                        _chosenValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            //1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Name"),
                    )))
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            //2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Description"),
                    )))
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
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Added Date"),
                    )))
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
                  height: 50.0,
                  color: Color(0xfff0e8ca),
                  child: RadioGroup(),
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
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Expiry Date"),
                    )))
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
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Person Name"),
                    )))
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
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Person Surname"),
                    )))
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
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Person Email"),
                    )))
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
                    onPressed: () => {},
                  ),
                )
              ],
            ),
            //3
          ],
        ));
  }
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'ONE';

  // Group Value for Radio Button.
  int id = 1;

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //Column(children: <Widget>[]),
        //Column(children: <Widget>[]),
        //Column(children: <Widget>[]),
        Text(
          'Is Assigned?  |',
          style: TextStyle(fontSize: 16),
        ),
        Radio(
          value: 1,
          groupValue: id,
          onChanged: (val) {
            setState(() {
              radioButtonItem = 'ONE';
              id = 1;
            });
          },
        ),
        Text(
          'ONE',
        ),

        Radio(
          value: 2,
          groupValue: id,
          onChanged: (val) {
            setState(() {
              radioButtonItem = 'TWO';
              id = 2;
            });
          },
        ),
        Text(
          'TWO',
        ),
      ],
    );
  }
}
