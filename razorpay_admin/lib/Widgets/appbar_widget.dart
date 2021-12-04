import 'package:flutter/material.dart';

@immutable
class AppBarWidget {
  static AppBar appBar({
    final String? title,
    Icon? icon,
    VoidCallback? iconOnPressed,
    bool backIcon = false,
    List<Widget>? actions,
    @required final context,
  }) {
    final width = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title != null
          ? Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.041,
                fontWeight: FontWeight.w700,
                fontFamily: 'Nunito',
              ),
            )
          : Text(''),
      centerTitle: true,
      bottom: PreferredSize(
        child: Container(
          color: Colors.grey,
          height: width * 0.002,
        ),
        preferredSize: Size.fromHeight(width * 0.002),
      ),
      automaticallyImplyLeading: false,
      leadingWidth: width * 0.185,
      leading: backIcon
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )
          : icon != null
              ? IconButton(
                  onPressed: iconOnPressed,
                  icon: icon,
                )
              : Container(),
      actions: actions,
    );
  }
}
