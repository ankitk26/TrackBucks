import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackbucks/features/auth/business/repositories/auth_repository_impl.dart';

final authStateProvider = StreamProvider((ref) {
  return AuthRepositoryImpl().getAuthChanges();
});
