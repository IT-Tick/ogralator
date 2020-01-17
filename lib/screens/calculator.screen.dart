
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';

import 'package:ogralator/models/appState.model.dart';
import 'package:ogralator/utils/regExp.dart';

import 'package:ogralator/actions/fare.actions.dart';

class Calculator extends StatelessWidget {

    final Store<AppState> store;
    Calculator({Key key, @required this.store}) : super(key: key);

    void _fareChanged (text) {
        final double newFare = text.isEmpty ? 0 : double.parse(text);
        store.dispatch(EditFareAction(newFare));
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
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Center(child: Text('أجرة لاتور')),
            ),
            body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        TextField(
                            decoration: InputDecoration(labelText: "الأجرة"),
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter(doubleRegExp)
                            ], // Only numbers can be entered
                            onChanged: _fareChanged
                        ),
                    ],
                ),
            )
        );
    }
}
