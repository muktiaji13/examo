import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bank_soal_model.dart';

class BankSoalState {
  final List<BankSoalItem> all;
  final String query;
  final String sort;
  
  const BankSoalState({
    required this.all,
    this.query = '',
    this.sort = 'Terbaru',
  });
  
  BankSoalState copyWith({
    List<BankSoalItem>? all,
    String? query,
    String? sort,
  }) {
    return BankSoalState(
      all: all ?? this.all,
      query: query ?? this.query,
      sort: sort ?? this.sort,
    );
  }
  
  List<BankSoalItem> get filtered {
    final q = query.toLowerCase();
    var list = all.where((e) {
      if (q.isEmpty) return true;
      return e.title.toLowerCase().contains(q) ||
          e.subtitle.toLowerCase().contains(q);
    }).toList();
    
    list.sort((a, b) {
      if (sort == 'Terbaru') {
        return b.createdAt.compareTo(a.createdAt);
      }
      return a.createdAt.compareTo(b.createdAt);
    });
    
    return list;
  }
}

class BankSoalNotifier extends StateNotifier<BankSoalState> {
  BankSoalNotifier() : super(BankSoalState(all: _dummy));
  
  static final List<BankSoalItem> _dummy = [
    BankSoalItem(
      id: '1',
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    BankSoalItem(
      id: '2',
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    BankSoalItem(
      id: '3',
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
  ];
  
  void setQuery(String q) {
    state = state.copyWith(query: q);
  }
  
  void setSort(String s) {
    state = state.copyWith(sort: s);
  }
  
  void addDummy() {
    final now = DateTime.now();
    final newItem = BankSoalItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Informatika Komputer d..',
      subtitle: 'Sistem operasi dan sistem kom..',
      createdAt: now,
    );
    state = state.copyWith(all: [newItem, ...state.all]);
  }
  
  void remove(String id) {
    state = state.copyWith(all: state.all.where((e) => e.id != id).toList());
  }
}

final bankSoalProvider = StateNotifierProvider<BankSoalNotifier, BankSoalState>(
  (ref) => BankSoalNotifier(),
);