import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';


class Welcome extends StatelessWidget {
  final void Function(ThisTheme) nextTheme;
  final ThisTheme themeObj;
  Welcome({this.nextTheme, this.themeObj});
  @override
  Widget build(BuildContext context) {

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
        body: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.assignment,
                  size: 44.0,
                ),
              ],

            )
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

void pushForm(BuildContext context) {
  Navigator.of(context).pushNamed('form');
}
