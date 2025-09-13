import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/syarat_ketentuan_model.dart';

final syaratKetentuanProvider = Provider<List<SyaratSection>>((ref) {
  return syaratKetentuanData;
});