import 'package:flutter/material.dart';
import '../../../config/styles.dart';

class BackButtonWidget extends StatelessWidget {
  final TextStyle? style;
  final VoidCallback? onTap;

  const BackButtonWidget({super.key, this.style, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Container(
        width: 101,
        height: 31,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Icon(Icons.arrow_back, size: 13, color: AppColors.black),
            const SizedBox(width: 6),
            Text(
              'Kembali',
              style: style ?? AppTextStyle.blackSubtitle.copyWith(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final void Function(String q) onChanged;
  final EdgeInsetsGeometry? padding;
  final bool showSpacing;

  const SearchBarWidget({
    required this.onChanged,
    this.padding,
    this.showSpacing = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextField(
            onChanged: onChanged,
            style: AppTextStyle.inputText.copyWith(
              fontSize: 13,
            ), 
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              filled: true,
              fillColor: AppColors.white,
              hintText: 'Telusuri',
              hintStyle: AppTextStyle.inputText.copyWith(fontSize: 13),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textGrey,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ), 
                borderSide: BorderSide.none,
              ),
            ),
          ),
          if (showSpacing) const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  final List<FilterOption> options;

  const FilterWidget({required this.options, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (int i = 0; i < options.length; i++) ...[
            _filterButton(context, options[i]),
            if (i != options.length - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _filterButton(BuildContext context, FilterOption option) {
    return GestureDetector(
      onTap: () => option.onTap(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Text(option.text, style: AppTextStyle.subtitle),
            const SizedBox(width: 8),
            const Icon(Icons.expand_more, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class FilterOption {
  final String text;
  final void Function(BuildContext) onTap;

  FilterOption({required this.text, required this.onTap});
}
