import 'package:ogralator/actions/fare.actions.dart';

double fareReducer(double state, action) {
  if (action is EditFareAction) {
    return action.fare;
  }

  return state;
}
