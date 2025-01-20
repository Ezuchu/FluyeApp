import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 189, 25, 13)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  String _data = "";
  String _accion = "";
  Timer? _timer;

  @override
  void initState(){
    super.initState();
    _getdata();
  }

  /*@override  
  void dispose()
  {
    _timer!.cancel();
    super.dispose();
  }*/

  _iniciarTimer()
  {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer)
    {
      _getdata();
    });
  }

  _getdata() async
  {
    var url = Uri.parse("http://localhost/fluye/consultas.php?id=1");
    var response = await http.get(url);
    if(response.statusCode == 200)
    {
      setState(() {
        _data = jsonDecode(response.body);
      });
      String acc = "1";
      if(_data == "1")
      {
        acc = "0";
      }
      setState(() {
        _accion = acc;
      });
    }
  }

  _postdata() async
  {
    var url = Uri.parse("http://localhost/fluye/consultas.php");
    var response = await http.post(url,body : jsonEncode(<String,Object>{'id' : 1, 'N' : int.parse(_accion)}));
    if(response.statusCode == 200)
    {
      _getdata();
    }
  }

  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_data',
            ),
            Text(
              '$_accion',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _postdata,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
