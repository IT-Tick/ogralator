import 'package:ogralator/models/appState.model.dart';
import 'package:ogralator/reducers/fare.reducer.dart';
import 'package:ogralator/reducers/passengersGroup.reducer.dart';

AppState appStateReducer(AppState state, action) {
    return AppState(
        fare: fareReducer(state.fare, action),
        passengersGroups: passengersGroupsReducer(state.passengersGroups, action)
    );
}
