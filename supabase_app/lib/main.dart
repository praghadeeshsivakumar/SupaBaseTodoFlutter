import 'package:flutter/material.dart';
import 'package:supabase_app/supamanager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'ToDo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SupaBaseManager manager = SupaBaseManager();
  List<dynamic> entries;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String newAddValue;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none &&
              projectSnap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');

          }

          return ListView.builder(
            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {
              return Container(
                  color: projectSnap.data[index]['status']
                      ? Colors.white
                      : Colors.red,
                  height: 150,
                  child: Row(
                    children: [
                      Center(child: Text(projectSnap.data[index]['name'])),
                      IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            manager.updateData(
                                true, projectSnap.data[index]['id']);
                            setState(() {});
                          }),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            manager.deleteData(projectSnap.data[index]['name']);
                            setState(() {});
                          }),
                    ],
                  ));
            },
          );
        },
        future: manager.readData(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: TextField(
                onChanged: (value) {
                  newAddValue = value;
                },
                decoration: InputDecoration(hintText: "Add new ToDo"),
              )),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  print(newAddValue);
                  manager.addData(newAddValue, false);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  SupaBaseManager manager = SupaBaseManager();
  String newText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => newText,
            ),
            RaisedButton(onPressed: () {})
          ],
        ),
      ),
    );
  }
}
