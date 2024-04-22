import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injection_schedule/main.dart';
import 'package:injection_schedule/network/dio_exception.dart';
import 'package:injection_schedule/network/dio_restfu.dart';
import 'package:injection_schedule/screens/booking_screen/models/user.dart';
import 'package:injection_schedule/screens/login/login_screen.dart';
import 'package:injection_schedule/utils/tab_bar.dart';
import 'package:intl/intl.dart';

import '../../secure_storage.dart';

class SignInPage extends StatefulWidget {
  static String routerName = 'LoginPage';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idPesonController = TextEditingController();
  bool _loadFirst = false;
  DateTime? selectedDate;
  String? selectedDatePost;
  String? _selectedGennder = 'MALE';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _optionsAddress = [
    'MALE',
    'FEMALE',
  ];

  void validateAndSave() {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  double getWidthDevice(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeightDevice(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  bool checkLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  bool _seePass = false;

  @override
  void initState() {
    super.initState();
    hideKeyboard();
  }

  Future<int?> onPressSignUp() async {
    String error = DioExceptions.DEFAULT;
    try {
      final response =
          await DioRestFull.instance.dio.post(DioRestFull().signIn, data: {
        // 'id': 0,
        'name': _usernameController.text,
        'address': _addressController.text,
        'phone_number': _phoneController.text,
        'email': _emailController.text,
        'dob': selectedDatePost,
        'gender': _selectedGennder,
        // 'Cccd': _idPesonController.text,
        'password': _passwordController.text,
      }).catchError((onError) {
        error = DioExceptions.messageError(onError);
        throw Exception();
      });
      final user = User.fromMap(response.data['result']['user']);
      await Future.wait([
        MyApp.of(context)
            .localStorage
            .storeToken(response.data['result']['accessToken']),
        MyApp.of(context).localStorage.storeId(user.id ?? -1)
      ]);
      MyApp.of(context).myAccount = user;
      return user.id;
    } catch (error) {
      return null;
    }

    // await SercureStorageApp().SaveValue('id', response.data['id'].toString());
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
        selectedDatePost = _formatDatePost(pickedDate);
      });
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            hideKeyboard();
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: getWidthDevice(context),
                    margin: const EdgeInsets.only(top: 100, left: 8, right: 8),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const Text('Đăng ký tài khoản',
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              label: Text(
                                'Họ và tên*',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: Icon(Icons.person)),
                          validator: (String? value) {
                            return value!.isEmpty
                                ? 'Bạn chưa nhập Họ và tên'
                                : null;
                          },
                          onChanged: (content) {},
                        ),
                        TextFormField(
                          controller: _addressController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              label: Text(
                                'Địa chỉ*',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: Icon(Icons.add_business_outlined)),
                          validator: (String? value) {
                            return value!.isEmpty
                                ? 'Bạn chưa nhập địa chỉ'
                                : null;
                          },
                          onChanged: (content) {},
                        ),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                            FilteringTextInputFormatter.deny(RegExp(r' ')),
                          ],
                          decoration: const InputDecoration(
                              label: Text(
                                'Số điện thoại*',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: Icon(Icons.add_call)),
                          validator: (String? value) {
                            return value!.isEmpty
                                ? 'Bạn chưa nhập số điện thoại'
                                : null;
                          },
                          onChanged: (content) {},
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              label: Text(
                                'Email*',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: Icon(Icons.attach_email_outlined)),
                          validator: (String? value) {
                            return value!.isEmpty
                                ? !isEmail(value)
                                    ? 'Email không chính xác'
                                    : 'Bạn chưa nhập email'
                                : null;
                          },
                          onChanged: (content) {},
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.table_view_rounded,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            const Text(
                              'Ngày sinh*',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              selectedDate != null
                                  ? _formatDate(selectedDate!)
                                  : '01/01/2000',
                              style: selectedDate != null
                                  ? const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    )
                                  : const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                            ),
                            IconButton(
                                onPressed: () => _selectDate(context),
                                icon: const Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.table_view_rounded,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            const Text(
                              'Giới tính*',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              value: _selectedGennder,
                              items: _optionsAddress.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedGennder = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _idPesonController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              label: Text(
                                ' Số chứng minh *',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: Icon(Icons.person)),
                          validator: (String? value) {
                            return value!.isEmpty
                                ? 'Bạn chưa nhập số chứng minh'
                                : null;
                          },
                          onChanged: (content) {},
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r' ')),
                            LengthLimitingTextInputFormatter(16),
                          ],
                          decoration: InputDecoration(
                              label: const Text(
                                'Password*',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                icon: Icon(_seePass
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () =>
                                    setState(() => _seePass = !_seePass),
                              )),
                          onChanged: (value) {},
                          validator: (value) {
                            return value!.isEmpty
                                ? '\u26A0 Bạn chưa nhập mật khẩu'
                                : null;
                          },
                          obscureText: !_seePass,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: getWidthDevice(context) - 16,
                          child: ElevatedButton(
                            onPressed: () async {
                              validateAndSave();
                              if (_usernameController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  _addressController.text.isNotEmpty &&
                                  _phoneController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty &&
                                  _idPesonController.text.isNotEmpty) {
                                _ShowDialog();

                                final result = await onPressSignUp();
                                Navigator.of(context).pop();

                                if (result != null) {
                                  print("onPressSignUp sucess");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Đăng ký thành công"),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const TabBarMain()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Thất bại! Vui lòng thử lại"),
                                  ));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                            ),
                            child: const Text('Đăng ký',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(
                          width: getWidthDevice(context) - 16,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              // primary: Colors.grey,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                            ),
                            child: const Text('Back',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _ShowDialog() {
    AlertDialog alert = AlertDialog(
      content: Row(children: [
        // const CircularProgressIndicator(
        //   backgroundColor: Colors.red,
        // ),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ]),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

String _formatDate(DateTime date) {
  return DateFormat('dd-MM-yy').format(date);
}

String _formatDatePost(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
