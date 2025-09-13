import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers untuk state
final passwordProvider = StateProvider<String>((ref) => '');
final confirmPasswordProvider = StateProvider<String>((ref) => '');
final obscurePasswordProvider = StateProvider<bool>((ref) => true);
final obscureConfirmPasswordProvider = StateProvider<bool>((ref) => true);
final passwordErrorProvider = StateProvider<String?>((ref) => null);
final confirmPasswordErrorProvider = StateProvider<String?>((ref) => null);