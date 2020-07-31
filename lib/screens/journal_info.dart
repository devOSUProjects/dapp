import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import '../models/journal_entry.dart';

class JournalInfo extends StatelessWidget {
  final void Function(ThisTheme) nextTheme;
  final ThisTheme themeObj;
  JournalInfo({this.nextTheme, this.themeObj});
  @override
  Widget build(BuildContext context) {
    final JournalEntryFields received = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('Welcome'))
      ),
      endDrawer: Drawer(
          child: Container(
              alignment: Alignment.center,
              child: Column(
                  children: [
                    SizedBox(height:30),
                    Text("Dark Mode"),
                    Switch(
                      value: themeObj.darkState,
                      onChanged: (newState) {
                        nextTheme(themeObj);
                      },
                    ),
                  ]
              )

          )
      ),
      body:

          ListView(

            children: <Widget>[
              Text(received.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
              Text(received.body,style: TextStyle(fontSize: 20))
            ],


      ),
    );
  }
}

void pushForm(BuildContext context) {
  Navigator.of(context).pushNamed('form');
}
