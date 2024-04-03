import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_schedule/screens/booking_screen/bloc/booking_bloc.dart';
import 'package:intl/intl.dart';

import '../../utils/helpers.dart';

class BookingScreen extends StatefulWidget {
  static const String routerName = 'BookingScreen';

  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  @override
  void initState() {
    BlocProvider.of<BookingBloc>(context).add(BookingStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử lịch tiêm'),
        backgroundColor: const Color(0xff1a4b6c),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(builder: (context, state) {
        if (state is BookingError) {
          return const Center(child: Text('Không có dữ liệu'));
        } else if (state is BookingLoading) {
          return const Center(child: Text('Loading'));
        } else if (state is BookingLoaded) {
          print(state);
          return BookingLoadedList(context, state);
        }
        return Container();
      }),
    );
  }
  Widget BookingLoadedList(BuildContext context, BookingLoaded state) {
    final textTheme = Theme.of(context).textTheme.titleLarge;
    return ListView.separated(
        itemBuilder: (context, index)=>Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('Địa điểm tiêm: ${state.history[index].diaDiemTiem??''}',
                    style: textTheme),
                Text('Ngày tiêm: ${convert(state.history[index].ngayTiem??'')}',
                    style: textTheme),
                Text('Trạng thái: ${state.history[index].status??''}',
                    style: textTheme),
              ],
            )),
        separatorBuilder: (context, index)=>const Divider(), itemCount: state.history.length);
  }

  DateTime convert(String date){
    DateTime dateTime = DateTime.parse(date);
    return dateTime;
  }
}


