import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questions_app/core/res/app_imges.dart';
import 'package:questions_app/core/res/app_string.dart';
import 'package:questions_app/core/res/app_style.dart';
import 'package:questions_app/features/data/local/login_lists.dart';
import 'package:questions_app/features/view/widgets/widgets.dart';

class LoginPageTwo extends StatelessWidget {
  const LoginPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  regesterImage,
                  height: 200,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    REGISTRATION,
                    style: titleLoginStyle,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  TYPEOFHOUSING,
                  style: loginQuestionStyle,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: housing,
                    decoration: textInputDecoration(''),
                    items: typeOfHousing
                        .map((type) => DropdownMenuItem<String>(
                              value: type,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(type, style: dropDounTextStyle),
                              ),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => housing = val!),
                  ),
                ),
                Text(
                  TYPEOFMARITAL,
                  style: loginQuestionStyle,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: marital,
                    decoration: textInputDecoration(''),
                    items: maritalStatus
                        .map((status) => DropdownMenuItem<String>(
                              value: status,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(status, style: dropDounTextStyle),
                              ),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => marital = val!),
                  ),
                ),
                Text(
                  STUDYCONDITION,
                  style: loginQuestionStyle,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: study,
                    decoration: textInputDecoration(''),
                    items: studyConditon
                        .map((condition) => DropdownMenuItem<String>(
                              value: condition,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
                                    Text(condition, style: dropDounTextStyle),
                              ),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => study = val!),
                  ),
                ),
                Text(
                  FINANCILACONDITION,
                  style: loginQuestionStyle,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: financial,
                    decoration: textInputDecoration(''),
                    items: financialCondition
                        .map((condition) => DropdownMenuItem<String>(
                              value: condition,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
                                    Text(condition, style: dropDounTextStyle),
                              ),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => financial = val!),
                  ),
                ),
                Text(
                  HEALTHCONDITION,
                  style: loginQuestionStyle,
                ),
                const SizedBox(height: 10),
                 SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: health,
                    decoration: textInputDecoration(''),
                    items: healthConditon
                        .map((condition) => DropdownMenuItem<String>(
                              value: condition,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
                                    Text(condition, style: dropDounTextStyle),
                              ),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => health = val!),
                  ),
                ),
              
              ],
            ),
          );
        });
      }),
    );
  }
}
