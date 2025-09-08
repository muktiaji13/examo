import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/detail_paket_model.dart';

final packageDetailProvider = Provider<PackageDetail>((ref) {
  return PackageDetail(
    name: 'Paket Premium',
    start: DateTime(2025, 6, 1),
    end: DateTime(2025, 6, 30),
    features: const [
      'Paket aktif mulai 01 Juni 2025',
      'Buat soal sesuai kebutuhan',
      'Download Template',
    ],
    price: 250000,
    adminFee: 2000,
  );
});

final subscriptionStatusProvider = StateProvider<SubscriptionStatus>((ref) {
  return SubscriptionStatus.active;
});