import 'package:flutter/material.dart';

class SmallTextRowTitle extends StatelessWidget {
  late String title;
  late Color color;

  SmallTextRowTitle({Key? key,
    required this.title,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(
        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
            ?MediaQuery.of(context).size.height>821? 13: MediaQuery.of(context).size.width<321?11:14
            :MediaQuery.of(context).size.height>551? 14:MediaQuery.of(context).size.height<321?11:14,
        fontWeight: FontWeight.w500,
        fontFamily: "NotoSans",
        color: color
    ),);
  }
}
