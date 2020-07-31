import 'Dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import '../models/journal.dart';
import '../models/journal_entry.dart';
import 'package:sqflite/sqflite.dart';

class JournalScreen extends StatefulWidget {
  final void Function(ThisTheme) nextTheme;
  final ThisTheme themeObj;
  void Function(Journal) hasEntries;

  JournalScreen({this.nextTheme, this.themeObj, this.hasEntries});

  @override
  _JournalScreen createState() => _JournalScreen();
}

class _JournalScreen extends State<JournalScreen> {
  Journal journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final Database database = await openDatabase('journal.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS journal_entries (id INTEGER PRIMARY KEY AUTOINCREMENT, title Text, body Text, rating Double, date Text)');
    });
    List<Map> journalRecords =
        await database.rawQuery('Select * From journal_entries');
    final journalEntries = journalRecords.map((record) {
      return JournalEntryFields(
          title: record['title'],
          body: record['body'],
          rating: record['rating'],
          dateTime: DateTime.parse(record['date']));
    }).toList();
    setState(() {
      journal = Journal(myJournal: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(journal == null || journal.myJournal == null) {
      return Scaffold(
        body: Center(
          child:
            CircularProgressIndicator()
        )
      );
    }else {
      return Scaffold(
        appBar: AppBar(title: Center(child: Text('Journal Entries'))),
        endDrawer: Drawer(
            child: Container(
                alignment: Alignment.center,
                child: Column(children: [
                  SizedBox(height: 30),
                  Text("Dark Mode"),
                  Switch(
                    value: widget.themeObj.darkState,
                    onChanged: (newState) {
                      widget.nextTheme(widget.themeObj);
                    },
                  ),
                ]))),
        body: ListView(
            children:
            journal.myJournal.map((item) {
              return ListTile(
                leading: FlutterLogo(),
                trailing: Icon(Icons.more_horiz),
                title: Text(item.title),
                subtitle: Text(DateFormat('yyyy-MM-dd - kk:mm').format(item.dateTime).toString()),
                onTap: () {
                  Navigator.of(context).pushNamed('jinfo', arguments: item);

                }
              );
            }).toList()

        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            pushForm(context);
          },
        ),
      );
    }
  }
}
void pushForm(BuildContext context) {
  Navigator.of(context).pushNamed('form');
}
