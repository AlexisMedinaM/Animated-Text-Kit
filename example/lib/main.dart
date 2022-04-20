import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  /// This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Text Kit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Example',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText( 
                    RichText(
                      text: 
                      const TextSpan(
                        text: 'Este es otro mensaje',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal
                        ),
                        children: [
                          TextSpan(
                            text: 'https://www.google.com',
                            style: TextStyle(
                              color: Colors.black
                            )
                          ),
                          TextSpan(
                            text: 'jejejeje saludos saludos',
                            style: TextStyle(
                              color: Colors.purple
                            )
                          )
                        ]
                      ),
                    )
                  ),
                  TyperAnimatedText( 
                    RichText(
                      text: 
                      const TextSpan(
                        text: 'Este es otro mensaje extra',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal
                        ),
                        children: [
                          TextSpan(
                            text: 'mensaje final',
                            style: TextStyle(
                              color: Colors.black
                            )
                          )
                        ]
                      ),
                    )
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
