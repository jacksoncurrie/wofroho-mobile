import 'package:flutter/material.dart';
import 'package:wofroho_mobile/components/input_field.dart';
import 'package:wofroho_mobile/components/link_button.dart';
import 'package:wofroho_mobile/components/primary_button.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'components/secondary_button.dart';
import 'theme.dart' as MyTheme;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.companyThemeData,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
