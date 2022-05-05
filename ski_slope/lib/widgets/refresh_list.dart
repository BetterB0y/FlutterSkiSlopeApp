import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ski_slope/resources/colors.dart';
import 'package:ski_slope/resources/dimensions.dart';
import 'package:ski_slope/widgets/conditional_builder.dart';

class RefreshList extends StatefulWidget {
  final Widget child;
  final bool? isRefreshing;
  final VoidCallback? onRefresh;

  const RefreshList({
    Key? key,
    required this.child,
    required this.isRefreshing,
    required this.onRefresh,
  }) : super(key: key);

  @override
  _RefreshListState createState() => _RefreshListState();
}

class _RefreshListState extends State<RefreshList> {
  final refreshController = RefreshController();

  @override
  void didUpdateWidget(covariant RefreshList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRefreshing != oldWidget.isRefreshing) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        if (widget.isRefreshing != null && widget.isRefreshing!) {
          refreshController.requestRefresh(needCallback: true);
        } else {
          refreshController.refreshCompleted();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: widget.onRefresh,
      header: CustomHeader(
        height: Dimensions.refreshHeaderHeight,
        refreshStyle: RefreshStyle.UnFollow,
        builder: (c, mode) {
          return Container(
            margin: const EdgeInsets.all(Dimensions.refreshHeaderMargin),
            alignment: Alignment.center,
            child: ConditionalBuilder(
              condition: mode == RefreshStatus.refreshing,
              positiveBuilder: (context) => const RefreshProgressIndicator(
                color: SkiColors.mainColor,
              ),
            ),
          );
        },
      ),
      child: widget.child,
    );
  }
}
