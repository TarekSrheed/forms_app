import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questions_app/core/config/service_locator.dart';
import 'package:questions_app/features/data/remote/answers_service.dart';
import 'package:questions_app/features/data/remote/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

final addToUserProvider = Provider<AddToUserService>((ref) {
  final supabaseClient = Supabase.instance.client;
  return AddToUserService(supabaseClient);
});

final addToAnswersProvider = Provider<AddToAnswersService>((ref) {
  final supabaseClient = Supabase.instance.client;
  return AddToAnswersService(supabaseClient);
});


final questionProvider = Provider.autoDispose
    .family<Future<Map<String, dynamic>?>, int>((ref, id) async {
  try {
    final supabase = ref.watch(supabaseClientProvider);

    final response =
        await supabase.from('Forms').select().eq('id', id).single();
    if (response.isEmpty) {
      print('Error loding note: $response');
    }else{
    return response;
    }
  } catch (e) {
    print('Exception inserting note: $e');
  }
});

final getuserId = Provider((ref) async {
  final supabase = ref.read(supabaseClientProvider);

  final response = await supabase
      .from('users')
      .select('id')
      .eq(
        'email',
        core.get<SharedPreferences>().getString('email').toString(),
      )
      .maybeSingle();

  core.get<SharedPreferences>().setInt('id', response!['id'] as int);

  return response['id'] as int;
});