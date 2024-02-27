import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/pages/join_organisation_page.dart';
import 'package:wofroho_mobile/pages/loading_page.dart';
import 'package:wofroho_mobile/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wofroho_mobile/pages/sign_up_page.dart';
import 'package:wofroho_mobile/services/authentication.dart';
import 'firebase_options.dart';
import 'theme.dart' as MyTheme;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthStatus? _authStatus;
  String? _userId;

  Future<void> _getUserState() async {
    final auth = Auth();
    final user = auth.getCurrentUser();
    _userId = user?.uid;
    final isSignedIn = _userId != null;
    final prefs = await SharedPreferences.getInstance();
    final isSignedUp = prefs.containsKey("signedUp");
    final inOrganisation = prefs.containsKey("inOrganisation");
    setState(() {
      _authStatus = !isSignedIn
          ? AuthStatus.NOT_LOGGED_IN
          : !isSignedUp
              ? AuthStatus.NOT_SIGNED_UP
              : !inOrganisation
                  ? AuthStatus.NOT_IN_ORGANISATION
                  : AuthStatus.LOGGED_IN;
    });
  }

  @override
  void initState() {
    super.initState();

    _authStatus = AuthStatus.NOT_DETERMINED;
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
    );
  }

  Widget _buildMainPage() {
    switch (_authStatus) {
      case AuthStatus.NOT_LOGGED_IN:
        return LoginPage();

      case AuthStatus.NOT_SIGNED_UP:
        return SignUpPage(userId: _userId!);

      case AuthStatus.NOT_IN_ORGANISATION:
        return JoinOrganisationPage(userId: _userId!);

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
  NOT_SIGNED_UP,
  NOT_IN_ORGANISATION,
  LOGGED_IN,
}
