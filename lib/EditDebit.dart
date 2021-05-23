import 'package:flutter/material.dart';

class EditDebit extends StatefulWidget {
  const EditDebit({Key key}) : super(key: key);

  @override
  _EditDebitState createState() => _EditDebitState();
}

class _EditDebitState extends State<EditDebit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.popUntil(context, ModalRoute.withName("/searchDebits")),
          ),
          title: Text("EDIT DEBIT"),
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
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "Assigner"),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ), //1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "User"),
                    )))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ), //2
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: 300.0,
                    height: 30.0,
                    color: Color(0xfff0e8ca),
                    child: Center(
                        child: TextFormField(
                      decoration: InputDecoration(hintText: "Asset Type"),
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
                      decoration: InputDecoration(hintText: "Asset Name"),
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
                      decoration:
                          InputDecoration(hintText: "Asset Desctription"),
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
                      decoration: InputDecoration(hintText: "Type"),
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
                      decoration: InputDecoration(hintText: "Start Date"),
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
                      decoration: InputDecoration(hintText: "Change End Date"),
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
          'Is Delivered?  |',
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
