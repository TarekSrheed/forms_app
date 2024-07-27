import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questions_app/core/config/service_locator.dart';
import 'package:questions_app/features/data/local/notification_service.dart';
import 'package:questions_app/features/view/pages/Forms_page.dart';
import 'package:questions_app/features/view/pages/login_pages.dart/page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  init();
  await Supabase.initialize(
    url: 'https://qguvqaatdogpipymxgfq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFndXZxYWF0ZG9ncGlweW14Z2ZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE1ODYzNDMsImV4cCI6MjAzNzE2MjM0M30.kg3FCrPO5XIj6-7kYO10TmgbukPo30-3QHvtzTsTcls',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  bool checkAuthorized() {
    if (core.get<SharedPreferences>().getString('email') == null ||
        core.get<SharedPreferences>().getString('email') == '') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (checkAuthorized()) ? MainLoginPage() : FormsPage(),
      ),
    );
  }
}
