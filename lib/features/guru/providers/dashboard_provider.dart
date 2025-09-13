import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardSearchProvider = StateProvider<String>((ref) => '');
final ujianAktifProvider = StateProvider<List<Map<String, String>>>((ref) => []);
final bankSoalProvider = StateProvider<List<Map<String, String>>>((ref) => []);