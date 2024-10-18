import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    sharedPreferenceInit();
  }

  String? username;
  SharedPreferences? prefs;

  void sharedPreferenceInit() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs?.getBool("isLoggedIn") ?? false;
    username = prefs?.getString("username");
    setState(() {});
  }

  _performLogout(){
    prefs?.remove("username");
    prefs?.setBool("isLoggedIn", false);
    sharedPreferenceInit();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Persistant Storage Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              (isLoggedIn == true)?'You are logged in as: $username': 'You are Logged Out',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(isLoggedIn == true){
            _performLogout();
          }else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Login()
                )
            );
          }
        },
        tooltip: 'Increment',
        child: Icon((isLoggedIn == true)?Icons.logout: Icons.login),
      ),
    );
  }
}
