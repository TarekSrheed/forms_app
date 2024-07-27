import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questions_app/core/config/service_locator.dart';
import 'package:questions_app/core/res/app_colors.dart';
import 'package:questions_app/core/res/app_string.dart';
import 'package:questions_app/features/view/pages/Forms_page.dart';
import 'package:questions_app/features/view/pages/login_pages.dart/login_page_one.dart';
import 'package:questions_app/features/view/pages/login_pages.dart/login_page_two.dart';
import 'package:questions_app/features/view/provider/immutabel_data.dart';
import 'package:questions_app/features/view/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({super.key});

  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  final PageController controller = PageController();
  final TextEditingController email = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();

  final yearController = TextEditingController();
  @override
  void dispose() {
    yearController.dispose();
    controller.dispose();
    email.dispose();
    password.dispose();
    address.dispose();
    super.dispose();
  }

  bool isOnePage() {
    if (controller.page == 1) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  LoginPageOne(
                    email: email,
                    password: password,
                    address: address,
                    yearController: yearController,
                    fullName: fullName,
                  ),
                  LoginPageTwo(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, _) {
        return InkWell(
          onTap: () async {
            if (email.text.isNotEmpty &&
                password.text.isNotEmpty &&
                fullName.text.isNotEmpty &&
                address.text.isNotEmpty &&
                yearController.text.isNotEmpty) {
              if (isOnePage() == true) {
                controller.nextPage(
                    duration: const Duration(seconds: 2), curve: Curves.ease);
              } else {
                final result = await ref.read(addToUserProvider).insert({
                  'email': email.text,
                  'password': password.text,
                  'name': fullName.text,
                  'date of birth': yearController.text,
                  'marital status': marital,
                  'financial situation': financial,
                  'address': address.text,
                  'study': study,
                  'health condition': health,
                  'type of housing': housing,
                });
                if (result == true) {
                  core.get<SharedPreferences>().setString('email', email.text);
                  core
                      .get<SharedPreferences>()
                      .setString('type of housing', housing);
                  core
                      .get<SharedPreferences>()
                      .setString('marital status', marital);
                  core
                      .get<SharedPreferences>()
                      .setString('financial situation', financial);
                  core
                      .get<SharedPreferences>()
                      .setString('address', address.text);
                  core.get<SharedPreferences>().setString('study', study);
                  core
                      .get<SharedPreferences>()
                      .setString('health condition', health);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormsPage(),
                    ),
                  );
                } else {
                  Center(child: Text(NOINTERNET));
                }
              }
            } else {
              showSnackbar(context, red, COMPLETEINFORMATION);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            height: 45,
            width: 70,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  spreadRadius: 0,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
              color: primaryColor,
              borderRadius: BorderRadius.circular(44),
            ),
            child: Icon(
              Icons.navigate_next,
              color: white,
              size: 40,
            ),
          ),
        );
      }),
    );
  }
}
