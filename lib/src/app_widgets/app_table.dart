import 'package:flutter/material.dart';
import '../src.dart';

class AppTable extends StatelessWidget {
  final List<String> headings;
  final List<List<dynamic>> records;
  final List<double>? cellWidths;
  final String? icon;
  final String? titleIcon;
  final double horizontalPadding;
  final bool filled;
  final Function(int)? iconCallback;
  final bool isTouchable;
  final Function(String id, int index)? onRowTouch;

  const AppTable({
    super.key,
    required this.headings,
    required this.records,
    this.cellWidths,
    this.icon,
    this.titleIcon,
    this.horizontalPadding = 16,
    this.filled = true,
    this.iconCallback,
    this.isTouchable = false,
    this.onRowTouch,
  });

  Widget _buildIcon() {
    return Column(
      children: List.generate(records.length + 1, (index) {
        var color = LCColors.white;
        if (index != 0 && index % 2 != 0) {
          color = LCColors.grayBG;
        }
        return LCInkwell.base(
          onTap: () {
            if (index > 0) {
              iconCallback!.call(index - 1);
            }
          },
          child: Container(
            alignment: Alignment.centerLeft,
            height: 40,
            color: color,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: LCImage.asset(
              name: index == 0 ? titleIcon! : icon!,
              width: 20,
              height: 20,
            ),
          ),
        );
      }).toList(),
    );
  }

  List<Widget> _buildCells(
    BuildContext context,
    List<dynamic> cells, {
    bool isHeader = false,
  }) {
    double? cellWidth;
    if (filled) {
      final screenWidth = context.screenWidth;
      double horizontalPadding = this.horizontalPadding;
      double iconWidth = 0;
      if (titleIcon != null) {
        iconWidth = 16 * 2 + 20;
        horizontalPadding = 0;
      }
      cellWidth =
          (screenWidth - horizontalPadding * 2 - iconWidth) / cells.length;
    }
    return cells.mapIndexed((index, cell) {
      final correctWidth = cellWidth ?? cellWidths![index];
      return Container(
        alignment: Alignment.centerLeft,
        width: correctWidth,
        height: 40,
        padding: const EdgeInsets.only(
          right: 8,
        ),
        child: isHeader
            ? LCText.regular(
                cell,
                fontSize: FontSizes.small,
                color: LCColors.blurTextColor,
              )
            : LCText.regular(
                getText(cell),
                fontSize: FontSizes.medium,
              ),
      );
    }).toList();
  }

  String getText(dynamic text) {
    if (text == null) {
      return "-";
    }

    if (text is String) {
      if (text == "false") {
        return "-";
      }
      return text.isNotEmpty ? text : "-";
    }

    return "$text";
  }

  List<Widget> _buildRows(
    BuildContext context,
    List<List<dynamic>> records, {
    bool isHeader = false,
  }) {
    return records.mapIndexed((index, record) {
      var color = LCColors.white;

      if (index % 2 == 0 && records.length != 1) {
        color = LCColors.grayBG;
      }

      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: titleIcon != null ? 0 : horizontalPadding,
        ),
        color: color,
        child: LCInkwell.base(
          onTap: () {
            if (!isTouchable) {
              return;
            }

            if (onRowTouch != null) {
              onRowTouch!.call(record[0], index);
            }
          },
          opacity: isTouchable ? 0.4 : 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildCells(
              context,
              record,
              isHeader: isHeader,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (titleIcon != null) _buildIcon(),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._buildRows(
                    context,
                    [headings],
                    isHeader: true,
                  ),
                  ..._buildRows(context, records),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
