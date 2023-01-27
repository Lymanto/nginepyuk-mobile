import 'package:flutter/material.dart';
import 'package:nginepyuk/theme.dart';

class LastestButton extends StatelessWidget {
  const LastestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Color(0xffF1F1F1),
        ),
      ),
      child: Text(
        "Mason",
        style: primaryTextStyle.copyWith(
          fontSize: 14,
        ),
      ),
    );
  }
}
