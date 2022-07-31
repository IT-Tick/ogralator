import 'package:flutter/cupertino.dart';

class PassengersGroup {
  final int numberOfPassengers;
  final double paidMoney;

  PassengersGroup({@required this.numberOfPassengers, @required this.paidMoney});

  PassengersGroup.initialState()
      : numberOfPassengers = 0,
        paidMoney = 0;
}
