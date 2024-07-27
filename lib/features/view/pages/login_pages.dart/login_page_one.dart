import 'package:flutter/material.dart';
import 'package:questions_app/core/res/app_imges.dart';
import 'package:questions_app/core/res/app_string.dart';
import 'package:questions_app/core/res/app_style.dart';
import 'package:questions_app/features/view/widgets/widgets.dart';

class LoginPageOne extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  final TextEditingController address;
  final TextEditingController fullName;
  final TextEditingController yearController;

  LoginPageOne({
    super.key,
    required this.email,
    required this.address,
    required this.fullName,
    required this.password,
    required this.yearController,
  });
  final formKey = GlobalKey<FormState>();
  String? _validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return YEAROFBIRTH;
    }
    final intYear = int.tryParse(value);
    if (intYear == null) {
      return VALIDYEAR;
    }
    final currentYear = DateTime.now().year;
    if (intYear < 1900 || intYear > currentYear) {
      return 'Please enter a year between 1900 and $currentYear';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              regesterImage,
              height: 160,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                REGISTRATION,
                style: titleLoginStyle,
              ),
            ),
            TextFormField(
              controller: fullName,
              decoration: textInputDecoration(FULLNAME),
            ),
            TextFormField(
                controller: email,
                validator: (value) {
                  if (value!.length < 4) {
                    return VALIDEMAIL;
                  } else {
                    return null;
                  }
                },
                decoration: textInputDecoration(EMAIL)),
            TextFormField(
                controller: password,
                obscureText: true,
                validator: (value) {
                  if (value!.length < 6) {
                    return THEPASSWORDWEEK;
                  } else {
                    return null;
                  }
                },
                decoration: textInputDecoration(PASSWORD)),
            TextFormField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: textInputDecoration(BIRTH),
              validator: _validateYear,
            ),
            TextFormField(
              controller: address,
              decoration: textInputDecoration(ADDRESS),
            ),
          ],
        ),
      ),
    );
  }
}
