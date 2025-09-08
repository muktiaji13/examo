import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeMenuProvider = StateProvider<String>((ref) => 'profil');
final sidebarVisibleProvider = StateProvider<bool>((ref) => false);
final showLogoutConfirmProvider = StateProvider<bool>((ref) => false);
final isLoggingOutProvider = StateProvider<bool>((ref) => false);