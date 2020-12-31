import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ogralator/utils/regExp.dart';

import 'package:ogralator/models/passengersGroup.model.dart';
import 'package:hexcolor/hexcolor.dart';

class PassengersGroupCard extends StatefulWidget {
  final double fare;
  final PassengersGroup group;
  final Function updateGroup;
  final Function removeCard;

  PassengersGroupCard(
      {Key key, this.fare, this.group, this.updateGroup, this.removeCard})
      : super(key: key);

  @override
  _PassengersGroupCardState createState() => _PassengersGroupCardState();
}

class _PassengersGroupCardState extends State<PassengersGroupCard> {
  double remainder;
  final greyColor = HexColor("#E6E6E6");
  final darkOrange = HexColor("#F7BD42");
  final numberOfPassengersController = new TextEditingController();
  final paidMoneyController = new TextEditingController();

  void _numberOfPassengersChanged(text) {
    final int newNumberOfPassengers = text.isEmpty ? 0 : int.parse(text);
    widget.updateGroup(numberOfPassengers: newNumberOfPassengers);
    _calculateGroupRemainder();
  }

  void _paidMoneyChanged(text) {
    final double newPaidMoney = text.isEmpty ? 0 : double.parse(text);
    widget.updateGroup(paidMoney: newPaidMoney);
    _calculateGroupRemainder();
  }

  void _calculateGroupRemainder() {
    setState(() {
      remainder = widget.group.paidMoney -
          widget.fare * widget.group.numberOfPassengers;
    });
  }

  @override
  Widget build(BuildContext context) {
    _calculateGroupRemainder();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      numberOfPassengersController.text = widget.group.numberOfPassengers == 0
          ? ""
          : widget.group.numberOfPassengers.toString();
      paidMoneyController.text =
          widget.group.paidMoney == 0 ? '' : int.parse(widget.group.paidMoney.toString());
    });
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Card(
                child: Container(
              decoration: BoxDecoration(color: greyColor),
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: numberOfPassengersController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(labelText: "كام نفر"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          onChanged: _numberOfPassengersChanged,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: paidMoneyController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(labelText: "الفلوس"),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter(doubleRegExp)
                          ], // Only numbers can be entered
                          onChanged: _paidMoneyChanged,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(4.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "الباقي",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Center(
                            child: Text(
                              remainder.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                        ],
                      ))
                ],
              ),
            )),
            Positioned(
                top: -15,
                left: -15,
                child: ButtonTheme(
                    minWidth: 30,
                    height: 30,
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: RaisedButton(
                        textColor: Colors.black,
                        onPressed: widget.removeCard,
                        child: Center(
                          child: Icon(Icons.clear),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100),
                        ))))
          ],
        ));
  }
}
