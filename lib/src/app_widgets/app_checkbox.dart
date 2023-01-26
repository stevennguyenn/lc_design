import 'package:flutter/cupertino.dart';
import 'package:lc_design/src/app_widgets/items/checkbox_item.dart';

///if you use horizontal direction, you just add into SizeBox, Container => set height
///if you yse vertical direction, you don't need to add it.

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    super.key,
    this.currentIndex = 0,
    required this.titles,
    this.axis = Axis.vertical,
    this.callback,
    this.allowEditing = true,
  });

  final int currentIndex;
  final List<String> titles;
  final Axis axis;
  final Function(int)? callback;
  final bool allowEditing;

  @override
  State<StatefulWidget> createState() {
    return AppCheckBoxState();
  }
}

class AppCheckBoxState extends State<AppCheckBox> {
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: widget.axis,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CheckBoxItem(
          title: widget.titles[index],
          isSelected: index == currentIndex,
          callback: widget.allowEditing
              ? () {
                  setState(() {
                    currentIndex = index;
                  });
                  widget.callback?.call(index);
                }
              : null,
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8,
          width: widget.axis == Axis.horizontal ? 24 : 0,
        );
      },
      itemCount: widget.titles.length,
    );
  }
}
