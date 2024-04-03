import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_schedule/screens/booking_screen/bloc/booking_bloc.dart';
import 'package:injection_schedule/screens/booking_screen/booking_screen.dart';
import 'package:injection_schedule/screens/home_screen/bloc/home_bloc.dart';
import 'package:injection_schedule/screens/home_screen/home_screen.dart';
import 'package:injection_schedule/screens/profile_screen/bloc/profile_bloc.dart';
import 'package:injection_schedule/screens/profile_screen/profile_screen.dart';

class TabMainScreen extends StatefulWidget {
  static const String routerName = 'TabMainScreen';

  const TabMainScreen({Key? key}) : super(key: key);

  @override
  State<TabMainScreen> createState() => _TabMainScreen();
}

class _TabMainScreen extends State<TabMainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TabBarMain(),
    );
  }
}

class TabBarMain extends StatefulWidget {
  const TabBarMain({Key? key}) : super(key: key);

  @override
  State<TabBarMain> createState() => _TabBarMainState();
}

class _TabBarMainState extends State<TabBarMain> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget renderScreen() {
    switch (_selectedIndex) {
      case 0:
        {
          return BlocProvider(
            create: (context) => HomeBloc(),
            child: HomeScreen(),
          );
        }
      case 1:
        {
          return BlocProvider(
            create: (context) => BookingBloc(),
            child: BookingScreen(),
          );
        }
      case 2:
        {
          return BlocProvider(
            create: (context) => ProfileBloc(),
            child: const ProfileScreen(),
          );
        }
      default:
        {
          return HomeScreen();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: renderScreen(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Đặt Lịch',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Xem lịch tiêm'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Thông tin cá nhân '),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff1a4b6c),
        onTap: _onItemTapped,
        selectedFontSize: 11,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }
}
