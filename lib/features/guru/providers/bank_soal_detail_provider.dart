import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bank_soal_detail_model.dart';

// Dummy data
final List<Question> dummyQuestions = [
  Question(
    id: 'q1',
    text: 'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
    type: QuestionType.single,
    options: [
      OptionItem(id: 'o1', text: 'Memori'),
      OptionItem(id: 'o2', text: 'CPU', isCorrect: true),
      OptionItem(id: 'o3', text: 'Monitor'),
      OptionItem(id: 'o4', text: 'Harddisk'),
    ],
  ),
  Question(
    id: 'q2',
    text: 'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
    type: QuestionType.multiple,
    options: [
      OptionItem(id: 'o1', text: 'Memori'),
      OptionItem(id: 'o2', text: 'CPU', isCorrect: true),
      OptionItem(id: 'o3', text: 'Monitor', isCorrect: true),
      OptionItem(id: 'o4', text: 'Harddisk'),
    ],
  ),
  Question(
    id: 'q3',
    text: 'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
    type: QuestionType.single,
    options: [
      OptionItem(id: 'o1', text: 'Memori'),
      OptionItem(id: 'o2', text: 'CPU', isCorrect: true),
      OptionItem(id: 'o3', text: 'Monitor'),
      OptionItem(id: 'o4', text: 'Harddisk'),
    ],
  ),
  Question(
    id: 'q4',
    text: 'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
    type: QuestionType.imageSingle,
    options: [
      OptionItem(id: 'o1', imageAsset: 'assets/images/ram.png', isCorrect: true),
      OptionItem(id: 'o2', imageAsset: 'assets/images/monitor.png'),
      OptionItem(id: 'o3', imageAsset: 'assets/images/casing.png'),
      OptionItem(id: 'o4', imageAsset: 'assets/images/harddisk.png'),
    ],
  ),
  Question(
    id: 'q5',
    text: 'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut....',
    type: QuestionType.essay,
  ),
];

class BankSoalState {
  final bool showAnswers;
  final Map<String, String?> singleAnswers;
  final Map<String, Set<String>> multipleAnswers;
  final Map<String, String> essayAnswers;
  
  BankSoalState({
    this.showAnswers = false,
    Map<String, String?>? singleAnswers,
    Map<String, Set<String>>? multipleAnswers,
    Map<String, String>? essayAnswers,
  }) : singleAnswers = singleAnswers ?? {},
       multipleAnswers = multipleAnswers ?? {},
       essayAnswers = essayAnswers ?? {};
  
  BankSoalState copyWith({
    bool? showAnswers,
    Map<String, String?>? singleAnswers,
    Map<String, Set<String>>? multipleAnswers,
    Map<String, String>? essayAnswers,
  }) {
    return BankSoalState(
      showAnswers: showAnswers ?? this.showAnswers,
      singleAnswers: singleAnswers ?? Map.from(this.singleAnswers),
      multipleAnswers: multipleAnswers ?? Map.from(this.multipleAnswers),
      essayAnswers: essayAnswers ?? Map.from(this.essayAnswers),
    );
  }
}

class BankSoalNotifier extends StateNotifier<BankSoalState> {
  BankSoalNotifier() : super(BankSoalState()) {
    final essayMap = <String, String>{};
    essayMap['q5'] = 'CPU adalah pusat pengolahan data pada komputer.';
    state = state.copyWith(essayAnswers: essayMap);
  }
  
  void toggleShowAnswers() {
    state = state.copyWith(showAnswers: !state.showAnswers);
  }
}

final bankSoalProvider = StateNotifierProvider<BankSoalNotifier, BankSoalState>(
  (ref) => BankSoalNotifier(),
);