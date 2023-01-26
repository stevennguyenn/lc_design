import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'loading_widget.dart';

class _LCListRender extends StatefulWidget {
  final List<Widget> children;
  final Function(Function(), Function())? onLoadMore;
  final Function(Function())? onRefreshData;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final EdgeInsets? padding;
  final bool isBuilder;
  final bool isSeparated;
  final bool hasMax;
  final Widget? childWidget;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final bool primary;
  final Axis scrollDirection;

  const _LCListRender({
    Key? key,
    required this.children,
    this.onLoadMore,
    this.onRefreshData,
    this.separatorBuilder,
    this.padding,
    this.isBuilder = false,
    this.isSeparated = false,
    this.hasMax = false,
    this.childWidget,
    this.scrollPhysics,
    this.scrollController,
    this.primary = true,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LCListState();
  }
}

class LCListState extends State<_LCListRender> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void refreshList() {
    _refreshController.requestRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: widget.onRefreshData != null,
      enablePullUp: widget.onLoadMore != null,
      physics: widget.scrollPhysics,
      onRefresh: () async {
        if (widget.onRefreshData != null) {
          widget.onRefreshData!(() {
            _refreshController.refreshCompleted(resetFooterState: true);
          });
        }
      },
      primary: widget.scrollController != null ? false : true,
      scrollController: widget.scrollController,
      onLoading: () async {
        if (widget.hasMax) {
          _refreshController.loadNoData();
        } else if (widget.onLoadMore != null) {
          widget.onLoadMore!(() {
            _refreshController.loadComplete();
          }, () {
            _refreshController.loadNoData();
          });
        }
      },
      header: CustomHeader(
        builder: (context, RefreshStatus? mode) {
          return const SizedBox(
            width: 60,
            height: 60,
            child: Center(
              child: Center(
                child: LoadingWidget(
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
      footer: CustomFooter(
        height: widget.hasMax ? 0 : 60,
        builder: (context, LoadStatus? mode) {
          if (mode == LoadStatus.loading && !widget.hasMax) {
            return _LoadMore();
          }
          return const SizedBox();
        },
      ),
      controller: _refreshController,
      child: widget.isBuilder
          ? ListView.builder(
              physics: widget.scrollPhysics,
              padding: widget.padding,
              itemCount: widget.children.length,
              scrollDirection: widget.scrollDirection,
              itemBuilder: (context, index) {
                return widget.children[index];
              })
          : widget.isSeparated
              ? ListView.separated(
                  physics: widget.scrollPhysics,
                  padding: widget.padding,
                  itemBuilder: (context, index) {
                    return widget.children[index];
                  },
                  separatorBuilder: widget.separatorBuilder!,
                  itemCount: widget.children.length,
                  scrollDirection: widget.scrollDirection,
                )
              : widget.childWidget != null
                  ? widget.childWidget!
                  : ListView(
                      physics: widget.scrollPhysics,
                      scrollDirection: widget.scrollDirection,
                      children: widget.children,
                    ),
    );
  }
}

class _LoadMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: Center(
          child: LoadingWidget(
            size: 20,
          ),
        ),
      ),
    );
  }
}

class LCList extends _LCListRender {
  const LCList.builder({
    required List<Widget> children,
    EdgeInsets? padding,
    bool hasMax = false,
    Function(Function(), Function())? onLoadMore,
    Function(Function())? onRefreshData,
    ScrollPhysics scrollPhysics = const BouncingScrollPhysics(),
    ScrollController? scrollController,
    bool primary = true,
    Key? key,
  }) : super(
          children: children,
          padding: padding,
          hasMax: hasMax,
          onLoadMore: onLoadMore,
          onRefreshData: onRefreshData,
          scrollController: scrollController,
          primary: primary,
          isBuilder: true,
          scrollPhysics: scrollPhysics,
          key: key,
        );

  const LCList.separated({
    Key? key,
    required List<Widget> children,
    EdgeInsets? padding,
    bool hasMax = false,
    Function(Function(), Function())? onLoadMore,
    Function(Function())? onRefreshData,
    required Widget Function(BuildContext, int)? separatorBuilder,
    ScrollPhysics scrollPhysics = const BouncingScrollPhysics(),
    ScrollController? scrollController,
    bool primary = true,
    Axis scrollDirection = Axis.vertical,
  }) : super(
          children: children,
          padding: padding,
          hasMax: hasMax,
          scrollController: scrollController,
          onLoadMore: onLoadMore,
          onRefreshData: onRefreshData,
          isSeparated: true,
          primary: primary,
          separatorBuilder: separatorBuilder,
          scrollPhysics: scrollPhysics,
          scrollDirection: scrollDirection,
          key: key,
        );

  LCList.child({
    Key? key,
    Function(Function(), Function())? onLoadMore,
    Function(Function())? onRefreshData,
    Widget? childWidget,
    ScrollController? scrollController,
    bool primary = true,
  }) : super(
          onRefreshData: onRefreshData,
          childWidget: childWidget,
          onLoadMore: onLoadMore,
          children: [],
          scrollController: scrollController,
          primary: primary,
          key: key,
        );
}
