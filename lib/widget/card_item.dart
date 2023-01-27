import 'package:flutter/material.dart';
import 'package:nginepyuk/pages/detail_page.dart';
import 'package:nginepyuk/theme.dart';

class CardItem extends StatelessWidget {
  final String docId;
  final String title;
  final String city;
  final String country;
  final double rating;
  final int price;
  final String photo;
  const CardItem({
    Key? key,
    required this.docId,
    required this.title,
    required this.city,
    required this.country,
    required this.rating,
    required this.price,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DetailPage(docId: docId);
          },
        ),
      ),
      child: Container(
        width: 280,
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
          padding: const EdgeInsets.only(
            top: 12.0,
            bottom: 18,
          ),
          child: Column(
            children: [
              Container(
                width: 256,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(photo),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          '$city, $country',
                          style: secondaryTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          rating.toString(),
                          style: secondaryTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          'assets/ICStar.png',
                          width: 18,
                          height: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                color: borderColor,
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${price.toString()}",
                          style: priceTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "/night",
                          style: secondaryTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    )
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
