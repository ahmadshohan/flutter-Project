import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/welcome_screen.dart';
import './screens/signup_screen.dart';
import './screens/login_screen.dart';
import './screens/splash_screen.dart';
import 'package:provider/provider.dart';
import './services/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final fontDubai = 'dubai';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      child: MaterialApp(
        title: 'Flutter namaa task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(
                headline5:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                subtitle1: TextStyle(
                  color: Colors.black87,
                  fontFamily: fontDubai,
                ),
                headline6:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                subtitle2:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                headline4:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                headline3:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                headline2:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                headline1:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                bodyText2:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                bodyText1:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                button: TextStyle(color: Colors.black87, fontFamily: fontDubai),
                caption:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai),
                overline:
                    TextStyle(color: Colors.black87, fontFamily: fontDubai)),
            buttonTheme: ButtonTheme.of(context).copyWith(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ))),
        home: SplashScreen(),
        routes: {
          WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
