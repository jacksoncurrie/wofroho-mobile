import 'package:flutter/material.dart';
import 'package:wofroho_mobile/components/input_field.dart';
import 'package:wofroho_mobile/components/link_button.dart';
import 'package:wofroho_mobile/components/primary_button.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PrimaryButton(
                text: "Test",
                onPressed: () {},
              ),
              SecondaryButton(
                text: "Test",
                onPressed: () {},
              ),
              InputField(
                label: "Email",
                hint: "Please enter email",
              ),
              LinkButton(
                text: "Test",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
