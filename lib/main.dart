import 'dart:convert';

import 'package:api_api/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Api()));
}

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List l = [];

  @override
  initState() {
    super.initState();
    get_api();
  }

  get_api() async {
    var url = Uri.parse('https://dummyjson.com/todos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map m = jsonDecode(response.body);
    l = m['todos'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightGreen.shade700,
        title: Text("Todos Dummyjson"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.lightGreen,
            thickness: 2,
          );
        },
        itemCount: l.length,
        itemBuilder: (context, index) {
          Todos To = Todos.fromJson(l[index]);

          return Card(
            child: ListTile(
                leading: Text(
                  "${To.id}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                title: Text(
                  "${To.todo}",
                  style: TextStyle(wordSpacing: 0.5,
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
                trailing: Text(
                  "${To.userId}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                )),
          );
        },
      ),
    );
  }
}
