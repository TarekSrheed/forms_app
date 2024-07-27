import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questions_app/core/config/service_locator.dart';
import 'package:questions_app/core/res/app_colors.dart';
import 'package:questions_app/core/res/app_string.dart';
import 'package:questions_app/core/res/app_style.dart';
import 'package:questions_app/features/data/local/notification_service.dart';
import 'package:questions_app/features/view/pages/Forms_page.dart';
import 'package:questions_app/features/view/provider/immutabel_data.dart';
import 'package:questions_app/features/view/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionPage extends ConsumerStatefulWidget {
  final int id;

  const QuestionPage({Key? key, required this.id}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {
  List<dynamic> questions = [];
  List<TextEditingController> controllers = [];
  bool isLoading = true;
  bool isSubmeted = false;

  @override
  void initState() {
    super.initState();
    loadSubmissionState();
    loadNote();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getuserId);
    });
  }

  Future<void> loadNote() async {
    final response = await ref.read(questionProvider(widget.id));
    if (response != null) {
      setState(() {
        questions = response['questions'];
        controllers = questions.map((_) => TextEditingController()).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackbar(context, Colors.red, NOQUESTION);
    }
  }

  Future<void> loadSubmissionState() async {
    setState(() {
      isSubmeted =
          core.get<SharedPreferences>().getBool('isSubmeted_${widget.id}') ??
              false;
    });
  }

  Future<void> saveSubmissionState() async {
    await core
        .get<SharedPreferences>()
        .setBool('isSubmeted_${widget.id}', true);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        elevation: 1,
        title: Text(
          QUESTION,
          style: titleAppbarStyle,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                              labelText: questions[index],
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              labelStyle: labelQuestionStyle,
                              floatingLabelStyle: labelQuestionStyle,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: InkWell(
        onTap: () async {
          bool iscompleat = false;
          final answers = controllers.map((c) => c.text).toList();
          for (var i = 0; i < 10; i++) {
            if (controllers[i].text.isNotEmpty) {
              iscompleat = true;
            } else {
              iscompleat = false;
            }
          }
          if (iscompleat == true) {
            final result = await ref.read(addToAnswersProvider).insert({
              'user_id': core.get<SharedPreferences>().getInt('id'),
              'form_id': widget.id,
              'answers': answers,
            });
            if (result == true) {
              await saveSubmissionState();
              setState(() {
                isSubmeted = true;
              });

              NotificationService().showNotification(
                title: NOTIFICATIONTITLE,
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const FormsPage()));
            } else {
              showSnackbar(context, Colors.red, NOINTERNET);
            }
          } else {
            showSnackbar(context, Colors.red, ENTERANSWERS);
          }
        },
        child: Container(
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
            child: Text(
              SUBMIT,
              style: submitStyle,
            )),
      ),
    );
  }
}
