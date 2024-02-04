abstract class SupabaseDataSource {
  Future<void> login(String email, String password);
  Future<void> signIn(String name, String email, String password);
  Future<void> logout();
}
