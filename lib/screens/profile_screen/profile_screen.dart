import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_schedule/screens/login/login_screen.dart';
import 'package:injection_schedule/secure_storage.dart';
import 'package:injection_schedule/utils/helpers.dart';

import '../../main.dart';
import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routerName = 'ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(ProfileStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin cá nhân'),
        backgroundColor: const Color(0xff1a4b6c),
        actions: [
          IconButton(
              onPressed: () async {
                MyApp.of(context)..clearAll();

                Navigator.of(context).popAndPushNamed(LoginPage.routerName);
                // await SercureStorageApp().ClearCacheApp();
                // RestartWidget.restartApp(context);
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: InforLoaded(context),
      // body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      //   if (state is ProfileError) {
      //     return Center(child: Text('Error'));
      //   } else if (state is ProfileLoading) {
      //     return Center(child: Text('Loading'));
      //   } else if (state is ProfileLoaded) {
      //     print(state.personInfo.id ?? '');
      //     return InforLoaded(context, state);
      //   }
      //   return Container();
      // }),
    );
  }
}

Widget InforLoaded(BuildContext context) {
  final account = MyApp.of(context).myAccount;
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'lib/res/images/personicon.jpg',
                width: 200,
                height: 200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: new EdgeInsets.only(right: 13.0),
                      child: Text(
                        'Tên:${account?.name ?? ''}',
                        overflow: TextOverflow.ellipsis,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Giới tính: ${account?.gender ?? ''}'),
                  SizedBox(
                    height: 5,
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(right: 13.0),
                  //     child: Text(
                  //       'Ngày sinh:${getFormattedDate(account?.dob ?? '') ?? ''}',
                  //       overflow: TextOverflow.ellipsis,
                  //     )),
                ],
              )
            ],
          ),
          Text('Số điện thoại :${account?.phoneNumber ?? ''}'),
          SizedBox(
            height: 5,
          ),
          Text('Địa chỉ: ${account?.address ?? ''}'),
          SizedBox(
            height: 5,
          ),
          Text('Email: ${account?.email ?? ''}'),
        ],
      ),
    ),
  );
}
// Scaffold(
// appBar: AppBar(
// title: Text('Thông tin cá nhân'),
// backgroundColor: const Color(0xff1a4b6c),
// ),
// body:
