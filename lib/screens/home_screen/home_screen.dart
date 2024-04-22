import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_schedule/network/dio_exception.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:injection_schedule/screens/booking_screen/models/vaccine_booking.dart';
import 'package:injection_schedule/screens/home_screen/bloc/home_bloc.dart';
import 'package:injection_schedule/screens/home_screen/models/Booking_model.dart';
import 'package:injection_schedule/utils/helpers.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String routerName = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  bool isHo = false;
  bool isSot = false;

  final vaccines = <Vaccine>[];
  Vaccine? vaccine = null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeVacxin());
    onGetVaccines();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  Future<void> onGetVaccines() async {
    final response = await DioRestFull.instance.dio.get(DioRestFull().vaccines);
    final items = response.data['result']['items'] as List;
    vaccines.addAll(items.map((json) => Vaccine.fromJson(json)).toList());
    setState(() {});
  }

  void onChangeHo() {
    setState(() {
      isHo = !isHo;
    });
  }

  void onChangeSot() {
    isSot = !isSot;
    setState(() {});
  }

  String? _selectedOption = 'Option 1';
  List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

  String? _selectedAddress;
  late BookingModel booking;
  bool loadFirst = false;

  DateTime? selectedDate;
  DateTime? dob;
  final name = TextEditingController();
  bool isMale = true;
  List<String> _optionsAddress = [
    'CS1 - Hà Nội',
    'CS2 - Huế',
    'CS3 - Đà Nắng',
    'CS4 - Hồ Chí Minh',
  ];
  void datLich() async {
    if (selectedDate == null || vaccine == null || _selectedAddress == null) {
      return;
    }
    String error = DioExceptions.DEFAULT;
    Response? response;
    print('selectedDate${getFormattedDateTime(selectedDate.toString())}}');
    print('_selectedAddress${_selectedAddress.toString()}');
    try {
      response = await DioRestFull.instance.dio
          .post(DioRestFull().vaccinationSchedule, data: {
        "date": getFormattedDateTime(selectedDate.toString()),
        "vaccine_id": vaccine?.id,
        "address": _selectedAddress,
        "healthSurveyAnswers": [
          {"healthSurveyTemplateId": 1, "choice": isHo ? 1 : 0},
          {"healthSurveyTemplateId": 2, "choice": isSot ? 1 : 0}
        ],
        "injector_info": {
          'name': name.text,
          'dob': getFormattedDateTime(dob.toString()),
          'gender': isMale ? 'MALE' : 'FEMALE'
        }
        // 'idKh': SercureStorageApp().GetValueData('id'),
        // 'thoiGian':
        //     '${getFormattedDateTime(selectedDate.toString())}T13:49:24.981Z',
        // 'diaDiem': _selectedAddress,
        // 'idVacXin': booking.id
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

  Future<void> _selectDob(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != dob) {
      setState(() {
        dob = pickedDate;
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
            Row(
              children: [
                Text('Tên'),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                      controller: name,
                      decoration: InputDecoration(hintText: 'Nhập tên')),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Ngày sinh:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  dob != null ? _formatDate(dob!) : 'No date selected',
                  style: dob != null
                      ? const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)
                      : const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                ),
                IconButton(
                    onPressed: () => _selectDob(context),
                    icon: const Icon(Icons.arrow_drop_down_outlined)),
              ],
            ),
            Row(
              children: [
                Text('Giới tính'),
                SizedBox(width: 12),
                Checkbox(
                    value: isMale,
                    onChanged: (value) => setState(() {
                          isMale = true;
                        })),
                Text('Nam'),
                SizedBox(width: 12),
                Checkbox(
                    value: !isMale,
                    onChanged: (value) => setState(() {
                          isMale = false;
                        })),
                Text('Nữ'),
                SizedBox(width: 12),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Loại vacxin:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 10,
              ),
              DropdownButton(
                value: vaccine,
                items: vaccines.map((Vaccine option) {
                  return DropdownMenuItem<Vaccine>(
                    value: option,
                    child: Text(option.name ?? ''),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    vaccine = newValue!;
                  });
                },
              )
              // BlocBuilder<HomeBloc, HomeState>(
              //   builder: (context, state) {
              //     if (state is HomeError) {
              //       return const Center(child: Text('Error'));
              //     } else if (state is BookingLoading) {
              //       return const Center(child: Text('Loading'));
              //     } else if (state is BookingLoaded) {
              //       print(state);
              //       if (!loadFirst) {
              //         booking = state.vacxin.first;
              //         loadFirst = true;
              //       }
              //       return DropdownButton(
              //         value: booking,
              //         items: state.vacxin.map((BookingModel option) {
              //           return DropdownMenuItem<BookingModel>(
              //             value: option,
              //             child: Text(option.ten ?? ''),
              //           );
              //         }).toList(),
              //         onChanged: (newValue) {
              //           setState(() {
              //             booking = newValue!;
              //           });
              //         },
              //       );
              //     }

              //     return Container();
              //   },
              // ),
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
                _buildCheckBoxText(isHo, 'Ho', onChangeHo),
                _buildCheckBoxText(isSot, 'Sốt', onChangeSot),
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

  Widget _buildCheckBoxText(
      bool value, String text, void Function() onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(value: value, onChanged: (val) => onChanged()),
        SizedBox(width: 12),
        Text(text)
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yy').format(date);
  }
}
