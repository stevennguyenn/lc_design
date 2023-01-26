import 'package:flutter/cupertino.dart';
import 'package:lc_design/src/app_widgets/items/selection_item.dart';

import '../constants/colors.dart';

class AppSelection extends StatefulWidget {
  const AppSelection({
    super.key,
    required this.titles,
    required this.callback,
    this.actions,
  });

  final List<String> titles;
  final Function(int) callback;
  final List<Widget>? actions;

  @override
  State<StatefulWidget> createState() {
    return AppSelectionState();
  }
}

class AppSelectionState extends State<AppSelection>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  bool _available = true;

  void updateState() {
    setState(() {
      _available = !_available;
    });
  }

  void updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: !_available
          ? const SizedBox()
          : Container(
              color: UIColors.white,
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SelectionItem(
                            title: widget.titles[index],
                            isSelected: _currentIndex == index,
                            callback: () {
                              setState(() {
                                _currentIndex = index;
                              });
                              widget.callback(index);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 16,
                          );
                        },
                        itemCount: widget.titles.length,
                      ),
                    ),
                  ),
                  if (widget.actions != null) ...widget.actions!,
                  if (widget.actions != null)
                    const SizedBox(
                      width: 16,
                    ),
                ],
              ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
