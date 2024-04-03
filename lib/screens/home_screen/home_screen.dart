import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_schedule/network/dio_exception.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:injection_schedule/screens/home_screen/bloc/home_bloc.dart';
import 'package:injection_schedule/screens/home_screen/models/Booking_model.dart';
import 'package:injection_schedule/utils/helpers.dart';
import 'package:intl/intl.dart';
import '../../secure_storage.dart';

class HomeScreen extends StatefulWidget {
  static const String routerName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeVacxin());
  }

  String? _selectedOption = 'Option 1';
  List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

  String? _selectedAddress;
  late BookingModel booking;
  bool loadFirst = false;

  DateTime? selectedDate;
  List<String> _optionsAddress = [
    'CS1 - Hà Nội',
    'CS2 - Huế',
    'CS3 - Đà Nắng',
    'CS4 - Hồ Chí Minh',
  ];
  void datLich() async {
    String error = DioExceptions.DEFAULT;
    Response? response;
    print('selectedDate${getFormattedDateTime(selectedDate.toString())}}');
    print('_selectedAddress${_selectedAddress.toString()}');
    try {
      response = await Dio(DioRestFull().baseOptions())
          .post(DioRestFull().PostBooking, data: {
        'idKh': SercureStorageApp().GetValueData('id'),
        'thoiGian':
            '${getFormattedDateTime(selectedDate.toString())}T13:49:24.981Z',
        'diaDiem': _selectedAddress,
        'idVacXin': booking.id
      }).catchError((onError) {
        error = DioExceptions.messageError(onError);
        print(error);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Lỗi đặt lịch"),
      ));
    }
    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Đặt thành công!"),
      ));
      // var data = response.data;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Loại vacxin:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 10,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeError) {
                    return const Center(child: Text('Error'));
                  } else if (state is BookingLoading) {
                    return const Center(child: Text('Loading'));
                  } else if (state is BookingLoaded) {
                    print(state);
                    if (!loadFirst) {
                      booking = state.vacxin.first;
                      loadFirst = true;
                    }
                    return DropdownButton(
                      value: booking,
                      items: state.vacxin.map((BookingModel option) {
                        return DropdownMenuItem<BookingModel>(
                          value: option,
                          child: Text(option.ten ?? ''),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          booking = newValue!;
                        });
                      },
                    );
                  }

                  return Container();
                },
              ),
              // DropdownButton<String>(
              //   value: _selectedOption,
              //   items: _options.map((String option) {
              //     return DropdownMenuItem<String>(
              //       value: option,
              //       child: Text(option),
              //     );
              //   }).toList(),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       _selectedOption = newValue!;
              //     });
              //   },
              // ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ngày đến:',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      selectedDate != null
                          ? _formatDate(selectedDate!)
                          : 'No date selected',
                      style: selectedDate != null
                          ? const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)
                          : const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    IconButton(
                        onPressed: () => _selectDate(context),
                        icon: const Icon(Icons.arrow_drop_down_outlined)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    'Chọn cơ sở :',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    value: _selectedAddress,
                    items: _optionsAddress.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedAddress = newValue!;
                      });
                    },
                  ),
                ]),
                ElevatedButton(
                  onPressed: datLich,
                  child: const Text('Đăt lịch'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yy').format(date);
  }
}
