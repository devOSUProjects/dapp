import 'package:call_me_maybe/models/journal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome.dart';
import 'theme.dart';
import 'screens/form.dart';
import 'screens/journal_entry_screen.dart';
import 'screens/journal_info.dart';

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}
class _AppState extends State<App> {
  bool empty = true;
  ThisTheme t = ThisTheme(darkState: false);
  void initState() {
    super.initState();
    initBool();
    initTheme();
  }
  void changeBool() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isEmpty', false);
    });
  }
  void initBool() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      empty = prefs.getBool('isEmpty') ?? true;
    });

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
  void hasEntries(Journal j) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(j.isEmpty()) {
      setState(() {
        prefs.setBool('isEmpty', true);
      });
    } else {
      setState(() {
        prefs.setBool('isEmpty', false);
      });
    }
  }
  Widget build(BuildContext context) {
    final routes = {
      'jinfo': (context) => JournalInfo(nextTheme: nextTheme, themeObj: t),
      'welcome': (context) => Welcome(nextTheme: nextTheme, themeObj: t),
      'form': (context) => JournalEntryForm(nextTheme: nextTheme, themeObj: t, changeBool: changeBool),
      'entry:': (context) => JournalScreen(nextTheme: nextTheme, themeObj: t, hasEntries: hasEntries),
      'app': (context) => App()
    };
    return MaterialApp(
      title: 'journal',
      theme: t.getTheme(),
      routes: routes,
      home: empty ? Welcome(nextTheme: nextTheme, themeObj: t) : JournalScreen(nextTheme: nextTheme, themeObj: t, hasEntries: hasEntries)
    );
  }
}

