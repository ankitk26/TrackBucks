import 'package:supabase/supabase.dart';
import 'package:trackbucks/features/auth/business/data_sources/supabase_data_source.dart';
import 'package:trackbucks/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _supabaseDataSource = SupabaseDataSourceImpl();

  @override
  Stream<AuthState> getAuthChanges() async* {
    yield* _supabaseDataSource.getAuthChanges();
  }

  @override
  Future<String> login(String email, String password) async {
    try {
      await _supabaseDataSource.login(email, password);
      return "ok";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Something went wrong";
    }
  }

  @override
  Future<void> logout() async {
    await _supabaseDataSource.logout();
  }

  @override
  Future<String> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      await _supabaseDataSource.signUp(name, email, password);
      return "ok";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Something went wrong";
    }
  }
}
