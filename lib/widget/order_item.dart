import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nginepyuk/theme.dart';

import '../pages/order_detail.dart';

class OrderItem extends StatelessWidget {
  final String hotelDocId;
  final String title;
  final String photo;

  final int night;
  final int price;
  final String checkIn;
  final String checkOut;

  final bool isCanceled;
  final bool isCheckOut;
  const OrderItem({
    Key? key,
    required this.hotelDocId,
    required this.title,
    required this.photo,
    required this.night,
    required this.price,
    required this.checkIn,
    required this.checkOut,
    required this.isCanceled,
    required this.isCheckOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailPage(
                    hotelDocId: hotelDocId,
                    title: title,
                    photo: photo,
                    night: night,
                    price: price,
                    checkIn: checkIn,
                    checkOut: checkOut,
                    isCanceled: isCanceled,
                    isCheckOut: isCheckOut,
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16,
        ),
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
                              "$night Night",
                              style: secondaryTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "\$$price",
                          style: priceTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              isCanceled
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: alertColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'Canceled',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: semiBold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : !isCanceled && isCheckOut
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff1FAB89),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Done',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: semiBold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffF3ECB0),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Ongoing',
                            style: primaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
