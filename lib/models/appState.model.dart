import 'package:flutter/cupertino.dart';
import 'package:ogralator/models/passengersGroup.model.dart';

class AppState {
  final double fare;
  final List<PassengersGroup> passengersGroups;

  AppState({@required this.fare, @required this.passengersGroups});

  AppState.initialState()
      : fare = 0,
        passengersGroups = <PassengersGroup>[];
}
