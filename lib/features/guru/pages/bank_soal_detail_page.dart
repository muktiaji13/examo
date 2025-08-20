import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/styles.dart';

// -------------------- Models --------------------
enum QuestionType { single, multiple, imageSingle, essay }

class OptionItem {
  final String id;
  final String? text;
  final String? imageAsset;
  final bool isCorrect;
  OptionItem({
    required this.id,
    this.text,
    this.imageAsset,
    this.isCorrect = false,
  });
}

class Question {
  final String id;
  final String text;
  final QuestionType type;
  final List<OptionItem> options;

  Question({
    required this.id,
    required this.text,
    required this.type,
    this.options = const [],
  });
}

// -------------------- Dummy data --------------------
final List<Question> dummyQuestions = [
  Question(
    id: 'q1',
    text:
        'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
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
    text:
        'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
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
    text:
        'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
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
    text:
        'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut...',
    type: QuestionType.imageSingle,
    options: [
      OptionItem(
        id: 'o1',
        imageAsset: 'assets/images/ram.png',
        isCorrect: true,
      ),
      OptionItem(id: 'o2', imageAsset: 'assets/images/monitor.png'),
      OptionItem(id: 'o3', imageAsset: 'assets/images/casing.png'),
      OptionItem(id: 'o4', imageAsset: 'assets/images/harddisk.png'),
    ],
  ),
  Question(
    id: 'q5',
    text:
        'Komponen utama dalam sistem komputer yang berfungsi untuk mengolah data disebut....',
    type: QuestionType.essay,
  ),
];

// -------------------- State Management (Riverpod) --------------------
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
  (ref) {
    return BankSoalNotifier();
  },
);

// -------------------- Widgets --------------------

class BankSoalDetailPage extends ConsumerWidget {
  const BankSoalDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bankSoalProvider);

    final daftarSoalStyle = AppTextStyle.cardTitle.copyWith(
      fontWeight: FontWeight.w500,
    );
    final kembaliStyle = AppTextStyle.inputText.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 18 / 13,
    );
    final labelStyle = AppTextStyle.inputText.copyWith(
      fontSize: 14,
      color: AppColors.textGrey2,
    );

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Daftar Soal', style: daftarSoalStyle),
                          ),
                          _BackButtonWidget(style: kembaliStyle),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CourseCard(),
                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Tampilkan Jawaban',
                                      style: labelStyle,
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () => ref
                                          .read(bankSoalProvider.notifier)
                                          .toggleShowAnswers(),
                                      child: Container(
                                        width: 46,
                                        height: 26,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: state.showAnswers
                                              ? Color(0xFF2ECC71)
                                              : Color(0xFFD5D5D5),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Align(
                                          alignment: state.showAnswers
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 66,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    color: Color(0x1AF39C12),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit',
                                      style: AppTextStyle.menuItem.copyWith(
                                        fontSize: 14,
                                        color: Color(0xFFF39C12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Divider(color: Color(0xFFDCDCDC), thickness: 1),

                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dummyQuestions.length,
                              separatorBuilder: (_, __) => SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final q = dummyQuestions[index];
                                return QuestionCard(
                                  number: index + 1,
                                  question: q,
                                  showAnswers: state.showAnswers,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Row(
          children: [
            Image.asset(
              'assets/images/sidebar_icon.png',
              width: 26,
              height: 26,
            ),
            const Spacer(),
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/profile_pic.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButtonWidget extends StatelessWidget {
  final TextStyle? style;
  const _BackButtonWidget({this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).maybePop(),
      child: Container(
        width: 101,
        height: 31,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Image.asset('assets/images/arrow-back.png', width: 16, height: 16),
            const SizedBox(width: 6),
            Text(
              'Kembali',
              style: style ?? AppTextStyle.inputText.copyWith(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0x1A0081FF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.roleButtonSelected,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/book.png',
                width: 14,
                height: 16,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Informatika',
                    style: AppTextStyle.cardTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sistem operasi dan cara kerja komp...',
                    style: AppTextStyle.cardSubtitle.copyWith(
                      color: Color(0xFF373737),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Jumlah Soal: 30',
                    style: AppTextStyle.cardSubtitle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.roleButtonSelected,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends ConsumerWidget {
  final int number;
  final Question question;
  final bool showAnswers;

  const QuestionCard({
    super.key,
    required this.number,
    required this.question,
    required this.showAnswers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final green = Color(0xFF2ECC71);
    final midGrey = Color(0xFFD9D9D9);
    final borderGrey = Color(0xFFCACACA);

    Widget buildOption(OptionItem o) {
      if (question.type == QuestionType.single ||
          question.type == QuestionType.imageSingle) {
        final centerColor = showAnswers
            ? (o.isCorrect ? green : midGrey)
            : midGrey;
        final borderColor = (showAnswers && o.isCorrect) ? green : borderGrey;

        final radioWidget = Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: centerColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );

        final optionContent =
            question.type == QuestionType.imageSingle && o.imageAsset != null
            ? Image.asset(
                o.imageAsset!,
                width: 120,
                height: 80,
                fit: BoxFit.contain,
              )
            : Text(
                o.text ?? '',
                style: AppTextStyle.inputText.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            radioWidget,
            const SizedBox(width: 12),
            Expanded(child: optionContent),
          ],
        );
      } else {
        final isCorrect = o.isCorrect;
        final backgroundColor = (showAnswers && isCorrect)
            ? green
            : AppColors.white;
        final borderColor = (showAnswers && isCorrect) ? green : borderGrey;

        final checkboxWidget = Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: borderColor),
          ),
          child: (showAnswers && isCorrect)
              ? Center(
                  child: Image.asset(
                    'assets/images/tick.png',
                    width: 16,
                    height: 16,
                  ),
                )
              : SizedBox.shrink(),
        );

        final optionContent = Text(
          o.text ?? '',
          style: AppTextStyle.inputText.copyWith(
            fontSize: 14,
            color: AppColors.black,
          ),
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            checkboxWidget,
            const SizedBox(width: 12),
            Expanded(child: optionContent),
          ],
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number.',
              style: AppTextStyle.inputText.copyWith(
                fontSize: 14,
                color: AppColors.black,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                question.text,
                style: AppTextStyle.inputText.copyWith(
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (question.type == QuestionType.single ||
            question.type == QuestionType.imageSingle)
          Column(
            children: question.options
                .map(
                  (o) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: buildOption(o),
                  ),
                )
                .toList(),
          ),
        if (question.type == QuestionType.multiple)
          Column(
            children: question.options
                .map(
                  (o) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: buildOption(o),
                  ),
                )
                .toList(),
          ),
        if (question.type == QuestionType.essay) ...[
          const SizedBox(height: 8),
          if (showAnswers)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: green, width: 1),
                ),
              ),
              child: Text(
                ref.read(bankSoalProvider).essayAnswers[question.id] ?? '-',
                style: AppTextStyle.inputText.copyWith(
                  fontSize: 14,
                  color: Color(0xFF505050),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
