import 'package:ogralator/models/passengersGroup.model.dart';

class AddPassengersGroupAction {
    final PassengersGroup group;

    AddPassengersGroupAction(this.group);
}

class EditPassengersGroupAction {
    final PassengersGroup group;
    final int numberOfPassengers;
    final double paidMoney;


    EditPassengersGroupAction(this.group, {
        this.numberOfPassengers,
        this.paidMoney});
}

class DeletePassengersGroupAction {
    final PassengersGroup group;

    DeletePassengersGroupAction(this.group);
}
