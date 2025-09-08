import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeMenuProvider = StateProvider<String>((ref) => 'kredensial');
final sidebarVisibleProvider = StateProvider<bool>((ref) => false);