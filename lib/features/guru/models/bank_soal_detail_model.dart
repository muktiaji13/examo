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