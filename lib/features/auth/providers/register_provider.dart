import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api_service.dart';
import '../../../core/providers/auth_provider.dart';

class RegisterFormState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String selectedRole;
  String? emailError; 

  RegisterFormState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.selectedRole = '',
    this.emailError,
  });

  RegisterFormState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? selectedRole,
    String? emailError,
  }) {
    return RegisterFormState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      selectedRole: selectedRole ?? this.selectedRole,
      emailError: emailError ?? this.emailError,
    );
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Ref ref;

  void setEmailError(String error) {
    state = state.copyWith(emailError: error);
  }

  RegisterFormNotifier(this.ref) : super(RegisterFormState());

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  void setRole(String role) {
    state = state.copyWith(selectedRole: role);
  }

  void clearEmailError() {
    state = state.copyWith(emailError: null);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required BuildContext context, // Added context for error handling
  }) async {
    try {
      if (state.selectedRole.isEmpty) {
        throw Exception('Pilih role terlebih dahulu');
      }

      final user = await ApiService.registerUser(
        name: name,
        email: email,
        password: password,
        role: state.selectedRole.toLowerCase() == 'siswa' ? 'user' : 'guru',
      );

      // ignore: unnecessary_null_comparison
      if (user != null) {
        await ref.read(authProvider.notifier).login(email, password);
      }
    } catch (e) {
      // Tangani error email sudah terdaftar
      if (e.toString().contains('email') && e.toString().contains('taken')) {
        state = state.copyWith(
          emailError: 'Email sudah terdaftar',
        );
        throw Exception('Email sudah terdaftar');
      }
      if (e.toString().contains('Failed to fetch') ||
          e.toString().contains('ClientException')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal terhubung ke server. Coba lagi nanti.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      rethrow;
    }
  }
}

final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>(
      (ref) => RegisterFormNotifier(ref),
    );

// CONTROLLERS (remain the same)
final usernameControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final emailControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final passwordControllerProvider = Provider.autoDispose<TextEditingController>((
  ref,
) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final confirmPasswordControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      final controller = TextEditingController();
      ref.onDispose(() => controller.dispose());
      return controller;
    });