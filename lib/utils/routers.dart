import 'package:flutter/material.dart';
import 'package:injection_schedule/screens/booking_screen/booking_screen.dart';
import 'package:injection_schedule/screens/home_screen/home_screen.dart';
import 'package:injection_schedule/screens/login/login_screen.dart';
import 'package:injection_schedule/screens/profile_screen/profile_screen.dart';
import 'package:injection_schedule/utils/tab_bar.dart';

final Map<String, WidgetBuilder> routes = {
  LoginPage.routerName: (context) => const LoginPage(),
  BookingScreen.routerName: (context) => const BookingScreen(),
  HomeScreen.routerName: (context) => const HomeScreen(),
  ProfileScreen.routerName: (context) => const ProfileScreen(),
  TabMainScreen.routerName: (context) => const TabMainScreen(),
};
