import 'package:ogralator/models/appState.model.dart';

double totalRemainder(AppState state) {
    double totalRemainder = 0;
    state.passengersGroups.forEach( (group) {
        double groupRemainder = group.paidMoney - state.fare * group.numberOfPassengers;
        totalRemainder += groupRemainder > 0 ? groupRemainder : 0;
    });
    return totalRemainder;
}
