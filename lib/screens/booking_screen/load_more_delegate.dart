import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

const double LOADMORE_INDICATOR_SIZE = 24;
const double HEIGHT_LOADMORE_WIDGET = 80;

class LoadMoreDelegateCustom extends LoadMoreDelegate {
  const LoadMoreDelegateCustom({this.color});
  final Color? color;
  double widgetHeight(LoadMoreStatus status) =>
      status == LoadMoreStatus.loading ? HEIGHT_LOADMORE_WIDGET : 0;

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.chinese}) {
    if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: LOADMORE_INDICATOR_SIZE,
              height: LOADMORE_INDICATOR_SIZE,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
              ),
            ),
          ],
        ),
      );
    }

    return Container();
  }
}
