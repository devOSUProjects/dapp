import 'package:flutter/material.dart';


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}
class _WelcomeState extends State<Welcome> {
  bool switchState = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'main',
      theme: Theme.of(context),
      home: Scaffold(
        appBar: AppBar(
            title: Center(child: Text('Welcome'))
        ),
        endDrawer: Drawer(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                    children: [
                      SizedBox(height:30),
                      Text("Change Theme"),
                      Switch(
                        value: switchState,
                        onChanged: (newState) {
                          setState(() {
                            switchState = newState;
                          });
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
          onPressed: () {},
        ),
      )
    );
  }
}
