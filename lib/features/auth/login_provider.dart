import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api_service.dart';
import '../../core/providers/auth_provider.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  LoginNotifier(this.ref) : super(const AsyncData(null));

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    try {
      await ApiService.loginUser(email: email, password: password);
      await ref.read(authProvider.notifier).login(email, password);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>((
  ref,
) {
  return LoginNotifier(ref);
});
