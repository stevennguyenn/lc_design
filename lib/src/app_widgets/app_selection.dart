import 'package:flutter/cupertino.dart';
import 'package:lc_design/lc_design.dart';
import 'package:lc_design/src/app_widgets/items/selection_item.dart';

import '../constants/colors.dart';

class AppSelection extends StatefulWidget {
  const AppSelection({
    super.key,
    required this.titles,
    required this.callback,
    this.actions,
    this.height = 40,
    this.enableColor,
    this.paddingBottom = 16,
    this.itemKeys,
  });

  final List<Key>? itemKeys;
  final List<String> titles;
  final Function(int) callback;
  final List<Widget>? actions;
  final double height;
  final Color? enableColor;
  final double paddingBottom;

  @override
  State<StatefulWidget> createState() {
    return AppSelectionState();
  }
}

class AppSelectionState extends State<AppSelection>
    with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  bool _available = true;
  final ScrollController _controller = ScrollController();

  void updateState() {
    setState(() {
      _available = !_available;
    });
  }

  void updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
    checkVisiblePosition();
  }

  Future<void> checkVisiblePosition() async {
    final correctWidth = _currentIndex * 90 + 16 * _currentIndex;
    final offset = _controller.offset;
    //width of listview
    final lastVisiblePosition = offset + context.screenWidth / 3 * 2;
    if (correctWidth > lastVisiblePosition || correctWidth < offset) {
      _controller.animateTo(
        correctWidth - context.screenWidth / 2 + 45,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              padding: EdgeInsets.only(
                bottom: widget.paddingBottom,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: widget.height,
                      child: ListView.separated(
                        controller: _controller,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SelectionItem(
                            width: 90,
                            key: widget.itemKeys != null
                                ? widget.itemKeys![index]
                                : null,
                            title: widget.titles[index],
                            enableColor: widget.enableColor,
                            isSelected: _currentIndex == index,
                            callback: () {
                              setState(() {
                                _currentIndex = index;
                              });
                              checkVisiblePosition();
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
