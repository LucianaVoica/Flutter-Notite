import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static late final SupabaseClient supabaseClient;

  static Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANONKEY']!,
    );
    supabaseClient = Supabase.instance.client;

    await _ensureDefaultCategories();
  }

  static Future<void> _ensureDefaultCategories() async {
    final List<Map<String, dynamic>> existingCategories =
        await supabaseClient.from('categories').select();

    if (existingCategories.isEmpty) {
      await supabaseClient.from('categories').insert(<Map<String, Object>>[
        <String, Object>{
          'id': '00000000-0000-0000-0000-000000000001',
          'name': 'All',
          'is_default': true,
        },
        <String, Object>{
          'id': '00000000-0000-0000-0000-000000000002',
          'name': 'Work',
          'is_default': true,
        },
        <String, Object>{
          'id': '00000000-0000-0000-0000-000000000003',
          'name': 'Personal',
          'is_default': true,
        },
      ]);
    }
  }
}
