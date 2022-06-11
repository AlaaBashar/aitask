import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<dynamic> openNewPage(BuildContext context, Widget widget,
    {bool popPreviousPages = false}) {
  return Future<dynamic>.delayed(Duration.zero, () {
    if (!popPreviousPages) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => widget,
          settings: RouteSettings(arguments: widget),
        ),
      );
    } else {
      return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => widget,
              settings: RouteSettings(
                arguments: widget,
              )),
          (Route<dynamic> route) => false);
    }
  });
}

String dataFormat({DateTime? date}){
  return DateFormat('hh:mm a,  MMM.d.yyyy').format(date!);
}