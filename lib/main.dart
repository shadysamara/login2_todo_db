import 'package:flutter/material.dart';
import 'package:login_todo_database/providers/db_provider.dart';
import 'package:login_todo_database/test_provider.dart';
import 'package:login_todo_database/ui/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbProvider>(
      create: (context) => DbProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MainScreen(),
      ),
    );
  }
}

class TestProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Selector<MyProvider, String>(builder: (context, value, y) {
          return Text(value);
        }, selector: (context, myprovider) {
          return myprovider.name;
        }),
        ElevatedButton(
            onPressed: () {
              Provider.of<MyProvider>(context, listen: false)
                  .changeName('hello world');
            },
            child: Text('press'))
      ],
    ));
  }
}
