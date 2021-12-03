import 'package:flutter/material.dart';

class Dialogs {
  Future<void> loading(context, {String? content}) {
    final width = MediaQuery.of(context).size.width / 100;

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 2)),
          backgroundColor: Colors.white.withOpacity(0.7),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(width * 4),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: width * 4),
                Text(content ?? 'Please Wait...'),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> error({@required context, String? title, String? content}) {
    return showDialog(
      context: context,
      builder: (context) {
        final width = MediaQuery.of(context).size.width;

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.02)),
          title: Text(title ?? 'Oops!'),
          content: Text(content ?? 'Something went wrong. Please try later.'),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> display(context, String title, String content,
      {bool dismissable = true}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissable,
      builder: (context) {
        final width = MediaQuery.of(context).size.width;

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.02)),
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('Okay'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> yesNoDialog(
    context, {
    String title = 'Are you sure',
    @required String? content,
    String leftBtn = 'No',
    String rightBtn = 'Yes',
    @required VoidCallback? yesFn,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        final width = MediaQuery.of(context).size.width;

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.02)),
          title: Text(title),
          content: Text(content ?? ''),
          actions: [
            TextButton(
              child: Text(leftBtn),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(rightBtn),
              onPressed: yesFn,
            ),
          ],
        );
      },
    );
  }

  dismiss(context) => Navigator.of(context, rootNavigator: true).pop();
}
