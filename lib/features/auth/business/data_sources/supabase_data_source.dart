import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> signUp(String name, String email, String password);
  Stream<AuthState> getAuthChanges();
  Future<void> logout();
}

class SupabaseDataSourceImpl implements SupabaseDataSource {
  final _supabase = Supabase.instance.client;

  @override
  Future<AuthResponse> login(String email, String password) async {
    final authResponse = await _supabase.auth
        .signInWithPassword(email: email, password: password);
    return authResponse;
  }

  @override
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<AuthResponse> signUp(
    String name,
    String email,
    String password,
  ) async {
    final authResponse = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        "name": name,
      },
    );
    return authResponse;
  }

  @override
  Stream<AuthState> getAuthChanges() {
    return _supabase.auth.onAuthStateChange;
  }
}
