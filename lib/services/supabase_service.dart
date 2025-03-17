import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static late final SupabaseClient supabaseClient;

  static Future<void> init() async {
    await Supabase.initialize(url: '', anonKey: ''); //!TODO - de pus
    supabaseClient = Supabase.instance.client;
  }
}
