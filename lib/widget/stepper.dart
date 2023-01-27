import 'package:flutter/material.dart';
import 'package:nginepyuk/theme.dart';

class StepperBooking extends StatelessWidget {
  final String title;
  final String number;
  final String currectStep;
  const StepperBooking(
      {Key? key,
      required this.title,
      required this.number,
      required this.currectStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: currectStep == number ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: currectStep == number ? primaryColor : thirdTextColor,
            ),
          ),
          child: Center(
            child: Text(
              number,
              style: primaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: currectStep == number ? semiBold : medium,
                color: currectStep == number ? Colors.white : thirdTextColor,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: priceTextStyle.copyWith(
            fontSize: 12,
            fontWeight: currectStep == number ? semiBold : medium,
            color: currectStep == number ? primaryColor : thirdTextColor,
          ),
        ),
      ],
    );
  }
}
