import 'package:flutter/material.dart';
import 'package:nginepyuk/theme.dart';

import '../pages/detail_page.dart';

class RecommendItem extends StatelessWidget {
  final String docId;
  final String title;
  final String city;
  final double rating;
  final String photo;
  const RecommendItem({
    Key? key,
    required this.docId,
    required this.title,
    required this.city,
    required this.rating,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetailPage(docId: docId);
      })),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: boxShadowColor.withOpacity(0.1),
              offset: const Offset(
                0,
                2.0,
              ),
              blurRadius: 15.0,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(photo),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          city,
                          style: secondaryTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/ICStar.png',
                              width: 18,
                              height: 18,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              rating.toString(),
                              style: secondaryTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/ICArrowRight.png',
                      width: 8,
                      height: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
