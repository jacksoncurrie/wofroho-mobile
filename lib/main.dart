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

  AuthStatus _getUserState() {
    final auth = Auth();
    final user = auth.getCurrentUser();
    return user?.uid != null ? AuthStatus.LOGGED_IN : AuthStatus.NOT_LOGGED_IN;
  }

  @override
  void initState() {
    super.initState();

    authStatus = _getUserState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wofroho',
      theme: MyTheme.companyThemeData,
      home: _buildMainPage(),
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
