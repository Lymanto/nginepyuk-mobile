import 'package:flutter/material.dart';
import 'package:nginepyuk/theme.dart';

class FacilitiesCard extends StatelessWidget {
  final String title;
  final String image;
  const FacilitiesCard({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(
              0,
              2.0,
            ),
            blurRadius: 15.0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 9,
            ),
            child: Text(
              title,
              style: primaryTextStyle.copyWith(
                fontSize: 10,
                fontWeight: medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
