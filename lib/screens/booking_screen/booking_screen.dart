import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_schedule/network/dio_exception.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:injection_schedule/screens/booking_screen/bloc/booking_bloc.dart';
import 'package:injection_schedule/screens/booking_screen/load_more_delegate.dart';
import 'package:injection_schedule/screens/booking_screen/models/vaccine_booking.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/helpers.dart';

class BookingScreen extends StatefulWidget {
  static const String routerName = 'BookingScreen';

  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  int limit = 5;
  int page = 1;
  bool isLoading = false;
  List<VaccineBooking> vaccineBookings = <VaccineBooking>[];

  @override
  void initState() {
    BlocProvider.of<BookingBloc>(context).add(BookingStarted());
    onRefresh();
  }

  Future<void> onRefresh() async {
    String error = DioExceptions.DEFAULT;
    try {
      isLoading = true;
      setState(() {});
      page = 1;
      final response = await DioRestFull.instance.dio.get(
          DioRestFull().vaccinationSchedule,
          queryParameters: {'limit': limit, 'pageNum': page});
      final items = response.data['result']['items'] as List;
      final bookings = items.map((e) => VaccineBooking.fromJson(e)).toList();
      vaccineBookings = bookings;
    } catch (error) {}
    isLoading = false;
    setState(() {});
  }

  Future<bool> onLoadMore() async {
    if (vaccineBookings.length < page * limit) return false;
    page += 1;
    final response = await DioRestFull.instance.dio.get(
        DioRestFull().vaccinationSchedule,
        queryParameters: {'limit': limit, 'pageNum': page});
    final items = response.data['result']['items'] as List;
    final bookings = items.map((e) => VaccineBooking.fromJson(e)).toList();
    vaccineBookings.addAll(bookings);
    setState(() {});
    if (bookings.length < limit) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử lịch tiêm'),
        backgroundColor: const Color(0xff1a4b6c),
      ),
      body: RefreshIndicator(
          onRefresh: onRefresh,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : vaccineBookings.isEmpty
                  ? const Center(child: Text('Không có dữ liệu'))
                  : LoadMore(
                      // isFinish: vaccineBookings.length < limit * page,
                      delegate: LoadMoreDelegateCustom(),
                      onLoadMore: onLoadMore,
                      child: BookingLoadedList(context))),
      // body: BlocBuilder<BookingBloc, BookingState>(builder: (context, state) {
      //   if (state is BookingError) {
      //     return const Center(child: Text('Không có dữ liệu'));
      //   } else if (state is BookingLoading) {
      //     return const Center(child: Text('Loading'));
      //   } else if (state is BookingLoaded) {
      //     return BookingLoadedList(context, state);
      //   }
      //   return Container();
      // }),
    );
  }

  Widget BookingLoadedList(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleLarge;
    return ListView.separated(
        itemBuilder: (context, index) => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Địa điểm tiêm: ${state.history[index].diaDiemTiem ?? ''}',
                      //     style: textTheme),
                      // Text(
                      //     'Ngày tiêm: ${convert(state.history[index].ngayTiem ?? '')}',
                      //     style: textTheme),
                      // Text('Trạng thái: ${state.history[index].status ?? ''}',
                      //     style: textTheme),
                      Text(
                          'Địa điểm tiêm: ${vaccineBookings[index].address ?? ''}',
                          style: textTheme),
                      Text(
                          'Người bệnh: ${vaccineBookings[index].injectorInfo?.name ?? ''}',
                          style: textTheme),
                      Text(
                          'Vaccine: ${vaccineBookings[index].vaccine?.name ?? ''}',
                          style: textTheme),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: QrImageView(
                                  padding: const EdgeInsets.all(0),
                                  data: DioRestFull().getVaccineQrCode(
                                      vaccineBookings[index].id ?? 1),
                                  size: 240,
                                ),
                              ),
                            ));
                  },
                  child: QrImageView(
                    data: DioRestFull()
                        .getVaccineQrCode(vaccineBookings[index].id ?? 1),
                    size: 120,
                  ),
                )
              ],
            )),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: vaccineBookings.length);
  }

  DateTime convert(String date) {
    DateTime dateTime = DateTime.parse(date);
    return dateTime;
  }
}
