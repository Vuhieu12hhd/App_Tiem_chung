import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:injection_schedule/screens/booking_screen/models/user.dart';
import 'package:injection_schedule/screens/home_screen/home_screen.dart';
import 'package:injection_schedule/screens/login/login_screen.dart';
import 'package:injection_schedule/simple_bloc_observer.dart';
import 'package:injection_schedule/utils/helpers.dart';
import 'package:injection_schedule/utils/local_storage.dart';
import 'package:injection_schedule/utils/routers.dart';
import 'package:injection_schedule/utils/tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
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
  final preference = await SharedPreferences.getInstance();
  Bloc.observer = const SimpleBlocObserver();
  runApp(
    MyApp(localStorage: LocalStorage(sharedPreferences: preference)),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({required this.localStorage, super.key});

  final LocalStorage localStorage;

  static _MyAppState of(BuildContext context) {
    final a = context.findAncestorStateOfType<_MyAppState>();

    if (a == null) {
      throw Exception("no my app");
    }

    return a;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? myAccount;
  LocalStorage get localStorage => widget.localStorage;

  void clearAll() {
    widget.localStorage.clearAll();
    myAccount = null;
  }

  @override
  void initState() {
    super.initState();
    DioRestFull.instance.localStorage = widget.localStorage;
    _onGetMyInfo();
  }

  void _onGetMyInfo() {
    if (localStorage.id != -1) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        try {
          showLoading();
          final response =
              await DioRestFull.instance.dio.get(DioRestFull().myInfo);
          myAccount = User.fromMap(response.data['result']);
        } catch (e) {
          print(e);
        } finally {
          hideLoading();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: widget.localStorage.token.isEmpty
          ? LoginPage.routerName
          : TabMainScreen.routerName,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// class RestartWidget extends StatefulWidget {
//   RestartWidget({required this.child});

//   final Widget child;

//   static void restartApp(BuildContext context) {
//     print('restart-app');
//     context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
//   }

//   @override
//   _RestartWidgetState createState() => _RestartWidgetState();
// }

// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();

//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('render-restartApp()');
//     return KeyedSubtree(
//       key: key,
//       child: widget.child,
//     );
//     // return GestureDetector(
//     //     child: KeyedSubtree(
//     //         key: key,
//     //         child: MaterialApp(10
//     //           home: widget.child,
//     //           navigatorKey: navigatorKey,
//     //           debugShowCheckedModeBanner: false,
//     //         )));
//   }
// }
