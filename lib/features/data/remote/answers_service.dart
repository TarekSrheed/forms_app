import 'package:supabase_flutter/supabase_flutter.dart';

class AddToAnswersService {
  final SupabaseClient client;

  AddToAnswersService(this.client);

  Future<bool> insert(Map<String, dynamic> answers) async {
    try {
      final response = await client.from("answers").insert(answers);
      if (response == null) {
        return true;
      } else {
        print('Error inserting answer: $response');
        return false;
      }
    } catch (e) {
      print('Exception inserting answer: $e');
      return false;
    }
  }
}