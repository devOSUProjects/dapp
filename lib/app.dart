import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome.dart';
import 'theme.dart';
import 'screens/form.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}
class _AppState extends State<App> {
  ThisTheme t = ThisTheme(darkState: false);
  void initState() {
    super.initState();
    //t = ThisTheme(darkState: false);
    initTheme();
  }

  void initTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      t = ThisTheme(darkState: prefs.getBool('theme') ?? false);
    });
  }

  void nextTheme(ThisTheme t) async {
    setState( () {
      t.switchTheme();
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', t.darkState);
  }

  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => Welcome(nextTheme: nextTheme, themeObj: t),
      'form': (context) => JournalEntryForm(nextTheme: nextTheme, themeObj: t)
    };

    return MaterialApp(
      title: 'journal',
      theme: t.getTheme(),
      routes: routes,

      //home: JournalEntryForm()
      //home: Welcome(nextTheme: nextTheme, themeObj: t,)
    );
  }
}

