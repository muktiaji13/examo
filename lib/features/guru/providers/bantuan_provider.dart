import 'package:flutter_riverpod/flutter_riverpod.dart';

final faqExpansionProvider = StateProvider<List<bool>>((ref) {
  return List.generate(5, (index) => false);
});