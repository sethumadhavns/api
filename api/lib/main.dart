import 'dart:convert';
import 'dart:core';
import 'dart:ffi';


import 'package:api/users.dart';


import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isloading = true;
  Users _users = Users();
  Future getdata() async {
    String url =
        'https://datausa.io/api/data?drilldowns=Nation&measures=Population';
    final response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);

    setState(() {
      _users = Users.fromJson(json);
      isloading = false;
    });
  }

  @override
  void initState() {
    
    super.initState();
    getdata();
  }
 int prin=0;
 String? heading='ENTER THE BUTTON';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isloading
            ? const CircularProgressIndicator()
            : Card(
                child: Align(
                    alignment: const Alignment(-3, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blueAccent,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: const Alignment(0, -2),
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  child:  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        '$heading',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      
                                    ],
                                  ))),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: _users.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.teal,
                                  elevation: 30,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                        child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[  prin==1 ? Text(_users.data![index].idYear.toString()): (prin==2) ? Text(_users.data![index].population!.toString()): Text('')
                                            
                                          ],
                                        ),
                                      ],
                                    )),
                                  ),
                                );
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                                  onPressed: () {setState(() {
                                    prin=1;showcustom(context,'years');heading='YEAR';
                                  });},
                                  child: const Text(
                                    'FIND YEARS',
                                    style: TextStyle(fontSize: 15),
                                  )),
                              TextButton(style:ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                                  onPressed: () {setState(() { prin=2;
                                    showcustom(context,'population');heading='POPULATION';
                                  }); },
                                  child: const Text(
                                    'FIND POPULATION',
                                    style: TextStyle(fontSize: 15),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )),
              ));
  }

  showcustom(BuildContext context,String message) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.green),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.check,
            color: Colors.white,
          ),
          Text(
            '$message IS DISPLAYED',
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 1),
        gravity: ToastGravity.BOTTOM);
  }
}
