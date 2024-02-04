abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> signUp(String name, String email, String password);
  Future<void> logout();
}
