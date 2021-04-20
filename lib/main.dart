import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/pages/loading_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wofroho_mobile/services/authentication.dart';
import 'theme.dart' as MyTheme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthStatus? authStatus;

  Future<void> _getUserState() async {
    final auth = Auth();
    final user = auth.getCurrentUser();
    setState(() {
      authStatus =
          user?.uid != null ? AuthStatus.LOGGED_IN : AuthStatus.NOT_LOGGED_IN;
    });
  }

  @override
  void initState() {
    super.initState();

    authStatus = AuthStatus.NOT_DETERMINED;
    _getUserState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wofroho',
      theme: MyTheme.companyThemeData,
      home: _buildMainPage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        DetailsPage.routeName: (context) => DetailsPage(),
      },
      builder: (BuildContext context, Widget? child) {
        if (child == null) return LoadingPage();

        // Disables text size changes - temporary UI fix
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
    );
  }

  Widget _buildMainPage() {
    switch (authStatus) {
      case AuthStatus.NOT_LOGGED_IN:
        return LoginPage();

      case AuthStatus.LOGGED_IN:
        return DetailsPage();

      case AuthStatus.NOT_DETERMINED:
      default:
        return LoadingPage();
    }
  }
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}
