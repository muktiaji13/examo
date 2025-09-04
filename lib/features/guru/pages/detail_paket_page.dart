import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/app_header.dart';
import '../../../config/styles.dart';
import '../models/detail_paket_model.dart';
import '../providers/detail_paket_provider.dart';
import '../widgets/detail_paket_widget.dart';

class DetailPaketPage extends ConsumerStatefulWidget {
  final SubscriptionStatus initialStatus;
  
  const DetailPaketPage({super.key, required this.initialStatus});

  static Future<void> go(BuildContext context, {required SubscriptionStatus status}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DetailPaketPage(initialStatus: status)),
    );
  }

  @override
  ConsumerState<DetailPaketPage> createState() => _DetailPaketPageState();
}

class _DetailPaketPageState extends ConsumerState<DetailPaketPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subscriptionStatusProvider.notifier).state = widget.initialStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pkg = ref.watch(packageDetailProvider);
    final status = ref.watch(subscriptionStatusProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Detail Paket', style: AppTextStyle.title),
                  const KembaliButton(),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DetailPemesananCard(pkg: pkg),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DetailPembayaranCard(
                  pkg: pkg,
                  status: status,
                  onPay: () => debugPrint('Go to Pay Now'),
                  onResumePayment: () => debugPrint('Resume Payment'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}