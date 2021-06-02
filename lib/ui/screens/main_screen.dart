import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_todo_database/models/task_model.dart';
import 'package:login_todo_database/providers/db_provider.dart';
import 'package:login_todo_database/ui/screens/tasbs_screens/all_tasks_tab.dart';
import 'package:login_todo_database/ui/screens/tasbs_screens/complete_task_tab.dart';
import 'package:login_todo_database/ui/screens/tasbs_screens/in_complete_tasks_tab.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String title;
  String description;
  setTitle(String value) {
    this.title = value;
  }

  setDescription(String value) {
    this.description = value;
  }

  submitTask(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      try {
        Task task = Task(title: title, isComplete: false);
        Provider.of<DbProvider>(context, listen: false).insertTask(task);
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('ok'))
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('TODO'),
            bottom: TabBar(tabs: [
              Tab(
                text: 'All Tasks',
              ),
              Tab(
                text: 'complete Tasks',
              ),
              Tab(
                text: 'inComplete Tasks',
              )
            ]),
          ),
          body: TabBarView(children: [
            AllTasksTab(),
            CompleteTasksTab(),
            InCompleteTasksTab(),
          ]),
          floatingActionButton: FloatingActionButton(onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Form(
                      key: formKey,
                      child: CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            onPressed: () {},
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0.0,
                              child: TextFormField(
                                validator: (value) {
                                  // ignore: missing_return
                                  if (value.isEmpty) {
                                    return 'text title is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onSaved: (value) {
                                  setTitle(value);
                                },
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              submitTask(context);
                            },
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0.0,
                              child: TextFormField(
                                validator: (value) {
                                  // ignore: missing_return
                                  if (value.isEmpty) {
                                    return 'text description is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onSaved: (value) {
                                  setDescription(value);
                                },
                              ),
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            submitTask(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text('Submit'),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                context: context);
          }),
        ));
  }
}
