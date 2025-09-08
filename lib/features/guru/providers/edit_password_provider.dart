import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordValidationState {
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLengthValid;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool hasSymbol;

  PasswordValidationState({
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isLengthValid = false,
    this.hasUppercase = false,
    this.hasLowercase = false,
    this.hasNumber = false,
    this.hasSymbol = false,
  });

  PasswordValidationState copyWith({
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLengthValid,
    bool? hasUppercase,
    bool? hasLowercase,
    bool? hasNumber,
    bool? hasSymbol,
  }) {
    return PasswordValidationState(
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLengthValid: isLengthValid ?? this.isLengthValid,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasLowercase: hasLowercase ?? this.hasLowercase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSymbol: hasSymbol ?? this.hasSymbol,
    );
  }
}

class PasswordValidationNotifier extends StateNotifier<PasswordValidationState> {
  PasswordValidationNotifier() : super(PasswordValidationState());

  void toggleNewPasswordVisibility() {
    state = state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
  }

  void validatePassword(String password) {
    state = state.copyWith(
      isLengthValid: password.length >= 8,
      hasUppercase: password.contains(RegExp(r'[A-Z]')),
      hasLowercase: password.contains(RegExp(r'[a-z]')),
      hasNumber: password.contains(RegExp(r'[0-9]')),
      hasSymbol: password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    );
  }
}

final passwordValidationProvider = StateNotifierProvider<PasswordValidationNotifier, PasswordValidationState>(
  (ref) => PasswordValidationNotifier(),
);