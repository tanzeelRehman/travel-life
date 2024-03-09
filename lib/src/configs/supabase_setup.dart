import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSetup {
  static const String _supabaseUrl = 'https://evimsreigandkjuinogy.supabase.co';
  static const String _supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV2aW1zcmVpZ2FuZGtqdWlub2d5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTcxMDgxMTksImV4cCI6MjAxMjY4NDExOX0.I1o3VtJ8nBUAUHvee-mtDd3AoNxzrMxDkZ9Vm4l9-uA';

  static Future<void> init() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
  }
}
