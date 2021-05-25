import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback showInfo;

  const MyAppBar({Key key, this.showInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0.0,
      actions: [
        TextButton(onPressed: showInfo, child: Text('ກ່ຽວກັບແອັບຯ'))
        // Container(
        //   padding: EdgeInsets.all(16),
        //   child: Text('ກ່ຽວກັບແອັບຯ'),
        // )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
