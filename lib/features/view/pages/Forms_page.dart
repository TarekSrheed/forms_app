import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questions_app/core/config/service_locator.dart';
import 'package:questions_app/core/res/app_colors.dart';
import 'package:questions_app/core/res/app_string.dart';
import 'package:questions_app/core/res/app_style.dart';
import 'package:questions_app/features/view/pages/login_pages.dart/page_view.dart';
import 'package:questions_app/features/view/pages/question_page.dart';
import 'package:questions_app/features/view/provider/useful_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormsPage extends StatelessWidget {
  const FormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        elevation: 1,
        title: Text(
          FORMS,
          style: titleAppbarStyle,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 100),
              child: ListTile(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(LOGOUT, style: titleAppbarStyle),
                          content: Text(SURE),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                core.get<SharedPreferences>().clear();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainLoginPage()));
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        );
                      });
                },
                title: Text(LOGOUT),
                leading: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
      body: Consumer(builder: (context, ref, _) {
        return ref.watch(formsStreamProvider).when(data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Text(NOFORMS),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    if (core
                            .get<SharedPreferences>()
                            .getBool('isSubmeted_${data[index]['id']}') ==
                        true) {
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuestionPage(
                            id: data[index]['id'],
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor,
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index]['form title'],
                          style: formTitleStyle,
                        ),
                        (core.get<SharedPreferences>().getBool(
                                    'isSubmeted_${data[index]['id']}') ==
                                true)
                            ? Text(
                                YOUWIN,
                                style: winPrizeStyle,
                              )
                            : Text(
                                WINTHEPRIZE,
                                style: prizeStyle,
                              )
                      ],
                    ),
                  ),
                );
              }),
            );
          }
        }, error: (error, stackTrace) {
          return Center(child: Text(NOINTERNET));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        });
      }),
    );
  }
}
