import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ogralator/models/appState.model.dart';
import 'package:ogralator/reducers/appState.reducer.dart';

import 'package:ogralator/screens/calculator.screen.dart';

void main() {

    final store = Store<AppState>(appStateReducer, initialState: AppState.initialState());
    runApp(OgralatorApp(
        store: store
    ));
}

class OgralatorApp extends StatelessWidget {
  final Store<AppState> store;

  OgralatorApp({Key key, this.store}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      // Pass the store to the StoreProvider. Any ancestor `StoreConnector`
      // Widgets will find and use this value as the `Store`.
      store: store,
      child: MaterialApp(
            localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
                Locale("ar", "EG"),
            ],
            locale: Locale("ar", "EG"),
            title: 'أجرة لاتور',
            theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
                // When navigating to the "/" route, build the FirstScreen widget.
                '/': (context) => StoreConnector<AppState, Store<AppState>>(
                  converter: (store) => store,
                  builder: (context, store) {
                    return Calculator(
                        store: store
                    );
                  },
                )
            },
        )
    );
  }
}
