import 'package:supabase/supabase.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<String> signUp(String name, String email, String password);
  Future<void> logout();
  Stream<AuthState> getAuthChanges();
}
