enum SubscriptionStatus { payNow, pending, active, expired }

class PackageDetail {
  final String name;
  final DateTime start;
  final DateTime end;
  final List<String> features;
  final int price;
  final int adminFee;

  const PackageDetail({
    required this.name,
    required this.start,
    required this.end,
    required this.features,
    required this.price,
    required this.adminFee,
  });

  int get total => price + adminFee;
}
