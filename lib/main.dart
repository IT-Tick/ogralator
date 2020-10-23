import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:ogralator/models/appState.model.dart';
import 'package:ogralator/reducers/appState.reducer.dart';

import 'package:ogralator/screens/calculator.screen.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  final store =
      Store<AppState>(appStateReducer, initialState: AppState.initialState());
  runApp(OgralatorApp(store: store));
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

class OgralatorApp extends StatelessWidget {
  final Store<AppState> store;
  final generalColor = HexColor("#F7BD42");
  final MaterialColor colorCustom = MaterialColor(0xFFF7BD42, color);

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
              primarySwatch: colorCustom,
              inputDecorationTheme: InputDecorationTheme(
                  fillColor: Colors.white, filled: true,
                enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: generalColor),
                ),
                focusedBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: generalColor),
                ),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(fontSize: 20.0),
              ),
              primaryTextTheme: TextTheme(
                  headline6: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ))),
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => StoreConnector<AppState, Store<AppState>>(
                  converter: (store) => store,
                  builder: (context, store) {
                    return Calculator(store: store);
                  },
                )
          },
        ));
  }
}
