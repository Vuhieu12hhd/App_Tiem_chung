import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injection_schedule/screens/login/login_screen.dart';
import 'package:injection_schedule/simple_bloc_observer.dart';
import 'package:injection_schedule/utils/routers.dart';
import 'package:injection_schedule/utils/tab_bar.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light) // Or Brightness.dark
      );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  await Hive.openBox('injection');
  Bloc.observer = const SimpleBlocObserver();
  runApp(RestartWidget(child: const MyApp(),
    
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: TabMainScreen.routerName,
      debugShowCheckedModeBanner: false,
       home: const LoginPage(),
    );
  }
}


class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    print('restart-app');
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('render-restartApp()');
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
    // return GestureDetector(
    //     child: KeyedSubtree(
    //         key: key,
    //         child: MaterialApp(10
    //           home: widget.child,
    //           navigatorKey: navigatorKey,
    //           debugShowCheckedModeBanner: false,
    //         )));
  }
}