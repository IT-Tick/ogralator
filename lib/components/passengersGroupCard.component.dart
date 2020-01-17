import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ogralator/utils/regExp.dart';

import 'package:ogralator/models/passengersGroup.model.dart';

class PassengersGroupCard extends StatefulWidget {
    final double fare;
    final PassengersGroup group;
    final Function updateGroup;

    PassengersGroupCard({Key key, this.fare, this.group, this.updateGroup}): super(key: key);

    @override
    _PassengersGroupCardState createState() => _PassengersGroupCardState();
}

class _PassengersGroupCardState extends State<PassengersGroupCard> {
    double remainder;

    void _numberOfPassengersChanged (text) {
        final int newNumberOfPassengers = text.isEmpty ? 0 : int.parse(text);
        widget.updateGroup(
            numberOfPassengers: newNumberOfPassengers
        );
        _calculateGroupRemainder();
    }

    void _paidMoneyChanged (text) {
        final double newPaidMoney = text.isEmpty ? 0 : double.parse(text);
        widget.updateGroup(
            paidMoney: newPaidMoney
        );
        _calculateGroupRemainder();
    }

    void _calculateGroupRemainder() {
        setState(() {
            remainder = widget.group.paidMoney - widget.fare * widget.group.numberOfPassengers;
        });
    }

    @override
    Widget build(BuildContext context) {
        _calculateGroupRemainder();

        return Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        children: <Widget>[
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: TextFormField(
                                            decoration: InputDecoration(labelText: "كام نفر؟"),
                                            initialValue: widget.group.numberOfPassengers.toString(),
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                            ], // Only numbers can be entered
                                            onChanged: _numberOfPassengersChanged,
                                        ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: TextFormField(
                                            decoration: InputDecoration(labelText: "الفلوس"),
                                            initialValue: widget.group.paidMoney.toString(),
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
                            Row(
                                children: <Widget>[
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child:Text(
                                            "الباقي",
                                            style: TextStyle(fontSize: 20),
                                        ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        child: Center(
                                            child:Text(
                                                remainder.toString(),
                                                style: TextStyle(fontSize: 20),
                                            ),
                                        )
                                    ),
                                ],
                            )
                        ],
                    ),
                )
            )
        );
    }
}
