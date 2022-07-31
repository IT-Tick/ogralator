import 'package:ogralator/actions/passengersMoney.actions.dart';
import 'package:ogralator/models/passengersGroup.model.dart';

List<PassengersGroup> passengersGroupsReducer(List<PassengersGroup> state, action) {
  if (action is AddPassengersGroupAction) {
    return []
      ..addAll(state)
      ..add(action.group);
  }

  if (action is EditPassengersGroupAction) {
    final itemIndex = state.indexOf(action.group),
        newGroup = PassengersGroup(
            numberOfPassengers: action.numberOfPassengers ?? action.group.numberOfPassengers,
            paidMoney: action.paidMoney ?? action.group.paidMoney);

    return []
      ..addAll(state)
      ..replaceRange(itemIndex, itemIndex + 1, [newGroup]);
  }

  if (action is DeletePassengersGroupAction) {
    return []
      ..addAll(state)
      ..remove(action.group);
  }

  return state;
}
