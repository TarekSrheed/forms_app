import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questions_app/core/config/service_locator.dart';
import 'package:questions_app/features/view/provider/immutabel_data.dart';
import 'package:shared_preferences/shared_preferences.dart';



final formsStreamProvider = StreamProvider((ref) {
  String housing = core.get<SharedPreferences>().getString('type of housing')!;
  String marital = core.get<SharedPreferences>().getString('marital status')!;
  String financial =
      core.get<SharedPreferences>().getString('financial situation')!;
  String study = core.get<SharedPreferences>().getString('study')!;
  String health = core.get<SharedPreferences>().getString('health condition')!;

  final supabase = ref.watch(supabaseClientProvider);
  final stream = supabase.from('Forms').stream(primaryKey: ['id']).inFilter(
      'form type', [housing, marital, financial, study, health]);
  return stream;
});

