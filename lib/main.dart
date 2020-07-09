import 'package:flutter/material.dart';
import './ToDoTask.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>{

  var isLoading = false;
  List<ToDoTask> tasks = List();

  @override
    void initState() {
      super.initState();
      _fetchData();
    }

    _fetchData() async {
    setState(() {
      isLoading = true;
    });

    try{
      final response =
          await http.get("https://jsonplaceholder.typicode.com/todos");
      if (response.statusCode == 200) {
        tasks = (json.decode(response.body) as List)
            .map((data) => new ToDoTask.fromJson(data))
            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load photos');
      }
    }
    catch(e){
        setState(() {
          isLoading = false;
        });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: isLoading ? Center(
                child: CircularProgressIndicator(),
              )
      : (tasks.length <= 0 ? Center(
                child :Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Something went wrong',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child :Text(
                      'Give it another try',
                      style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      ),
                    ),
                  ),
                   Container(
                    child : 
                    FlatButton(
                      child: Text('Reload'),
                      textColor: Colors.blue,
                      onPressed: () {
                        _fetchData();
                      },
                    ),
                  ),
              ],
            ),
      )
      : SafeArea(
        child : Container(
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 3),
                    child: Text(
                      '${tasks[index].title}',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 3, 10, 5),
                    child :Text(
                      'Completed : ${tasks[index].completed}',
                      style: TextStyle(
                      color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
        itemCount: tasks.length,
      ),
    ),
  )
    )
    );
  }
}
