import 'package:flutter/material.dart';
import 'signupcustomer.dart';
import 'logincustomer.dart';
import 'loginadmin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'COURTS',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key : key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://youtube.com/watch?v=VQOJaYUPZR8&si=sZpqAPqkmAS9a4BT',
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COURTS'),
      ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('COURTS'),
            ),

            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
            ),

            ListTile(
              title: const Text('Sign Up as Customer'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpCustomer()),
                );
              },
            ),
            ListTile(
              title: const Text('Login as Customer'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginCustomer()),
                );
              },
            ),
            ListTile(
              title: const Text('Login as Admin'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginAdmin()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 100,
                  width: 250,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'Welcome to COURTS Malaysia',
                        textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      ScaleAnimatedText(
                        'Welcome to COURTS Malaysia',
                        textStyle: TextStyle(fontSize: 30.0, fontFamily: 'Canterbury'),
                      ),
                    ],
                    totalRepeatCount: 10,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: 16/9,
                  child: _controller.value.isInitialized
                      ? VideoPlayer(_controller)
                      : CircularProgressIndicator(),
                ),
              ),
              Container(
                height: 100,
                width: 250,
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      'Click on sidebar to explore..',
                      textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    ScaleAnimatedText(
                      'Click on sidebar to explore..',
                      textStyle: TextStyle(fontSize: 15.0, fontFamily: 'Canterbury'),
                    ),
                  ],
                  totalRepeatCount: 10,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

