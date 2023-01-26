import 'package:flutter/material.dart';
import '../../src.dart';

class AppTimePickerField extends StatelessWidget {
  final String title;
  final DateTime? date;
  final DateTimeFormat? format;
  final Function(DateTime)? callback;

  const AppTimePickerField({
    super.key,
    required this.title,
    this.date,
    this.format,
    this.callback,
    //need when you limit in picker
  });

  @override
  Widget build(BuildContext context) {
    String dateString = "-";
    if (date != null) {
      dateString = DateTimeHelper.getString(
        date!,
        format: format ?? DateTimeFormat.HHmm,
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: UIColors.textFieldBG,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LCText.bold(
            title,
            fontSize: FontSizes.small,
          ),
          const SizedBox(
            height: 8,
          ),
          LCInkwell.base(
            opacity: 1,
            onTap: () {
              DateTimePickerHelper.instance.showTimePicker(
                (newDate) {
                  callback?.call(newDate);
                },
                context: context,
              );
            },
            child: Row(
              children: [
                LCText.base(
                  dateString,
                  fontSize: FontSizes.medium,
                ),
                const Spacer(),
                LCImage.asset(
                  name: UIImages.icClock,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
