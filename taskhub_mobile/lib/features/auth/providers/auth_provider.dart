import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskhub_mobile/data/services/auth_service.dart';
import 'package:taskhub_mobile/data/services/storage_service.dart';
import 'package:taskhub_mobile/data/models/auth_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<bool>>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AsyncValue<bool>> {
  AuthNotifier() : super(const AsyncValue.data(false));

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      final result = await AuthService.login(
        LoginPayload(email: email, password: password),
      );

      await StorageService.saveLoginData(result.data);

      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();

    try {
      await AuthService.register(
        RegisterPayload(email: email, password: password),
      );

      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await StorageService.logout();
    state = const AsyncValue.data(false);
  }
}
