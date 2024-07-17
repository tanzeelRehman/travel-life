import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSetup {
  static const String _supabaseUrl = 'https://evimsreigandkjuinogy.supabase.co';
  static const String _supabaseAnonKey =
      'YOUR-SUPABASE-KEY';

  static Future<void> init() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
  }
}
