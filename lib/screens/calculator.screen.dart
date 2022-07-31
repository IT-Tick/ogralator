import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ogralator/actions/fare.actions.dart';
import 'package:ogralator/actions/passengersMoney.actions.dart';
import 'package:ogralator/components/passengersGroupCard.component.dart';
import 'package:ogralator/models/appState.model.dart';
import 'package:ogralator/models/passengersGroup.model.dart';
import 'package:ogralator/selectors/totalRemainder.selector.dart';
import 'package:ogralator/utils/regExp.dart';
import 'package:redux/redux.dart';

class Calculator extends StatelessWidget {
  final Store<AppState> store;
  final statusBarColor = HexColor("#F7BD42");

  Calculator({Key key, @required this.store}) : super(key: key);

  void _fareChanged(text) {
    final double newFare = text.isEmpty ? 0 : double.parse(text);
    store.dispatch(EditFareAction(newFare));
  }

  void _newPassengersGroup() {
    store.dispatch(AddPassengersGroupAction(PassengersGroup.initialState()));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: statusBarColor, // status bar color

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(child: Text('أجرةلاتور')),
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/assets/wallpaper.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'lib/assets/bus.png',
                              width: store.state.passengersGroups.length == 0
                                  ? MediaQuery.of(context).size.width
                                  : 0,
                              height: store.state.passengersGroups.length == 0
                                  ? MediaQuery.of(context).size.height / 2.5
                                  : 0,
                              fit: BoxFit.cover,
                            ),
                            TextField(
                                cursorColor: Colors.black,
                                decoration:
                                    InputDecoration(labelText: "الأجرة كام"),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      doubleRegExp)
                                ], // Only numbers can be entered
                                onChanged: _fareChanged,
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            SizedBox(height: 20),
                            Column(
                                key: Key(store.state.passengersGroups.length
                                    .toString()),
                                children: store.state.passengersGroups
                                    .map((group) => Container(
                                          child: PassengersGroupCard(
                                            fare: store.state.fare ?? 0,
                                            group: group,
                                            updateGroup: (
                                                    {int numberOfPassengers,
                                                    double paidMoney}) =>
                                                store.dispatch(
                                                    EditPassengersGroupAction(group,
                                                        numberOfPassengers:
                                                            numberOfPassengers,
                                                        paidMoney: paidMoney)),
                                            removeCard: () => store.dispatch(
                                                DeletePassengersGroupAction(
                                                    group)),
                                          ),
                                        ))
                                    .toList()),
                            ButtonTheme(
                                height: 50,
                                minWidth: double.infinity,
                                buttonColor: statusBarColor,
                                child: RaisedButton.icon(
                                    onPressed: () {
                                      _newPassengersGroup();
                                      FocusScope.of(context).unfocus();
                                    },
                                    textColor: Colors.black,
                                    label: Text(
                                      "اضافة أجرة",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    icon: Icon(Icons.add)))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          border: Border(
                              top: BorderSide(width: 1, color: Colors.white))),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "اجمالي الباقي",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Text(
                              totalRemainder(store.state).toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            )));
  }
}
