import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:nginepyuk/theme.dart';

import '../widget/stepper.dart';

class PaymentPage extends StatefulWidget {
  final String checkIn;
  final String checkOut;
  final int night;
  final String title;
  final String photo;
  final int price;
  final String hotelDocId;
  final String paymentOption;
  const PaymentPage({
    Key? key,
    required this.checkIn,
    required this.checkOut,
    required this.night,
    required this.title,
    required this.photo,
    required this.price,
    required this.hotelDocId,
    required this.paymentOption,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    String paymentOption = widget.paymentOption.replaceFirst(
      "PaymentOption.",
      "",
    );
    Widget header() {
      return Container(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'Booking Detail',
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    StepperBooking(
                      title: "Booking Detail",
                      number: '1',
                      currectStep: "1",
                    ),
                    Spacer(),
                    StepperBooking(
                      title: "Payment Method",
                      number: '2',
                      currectStep: "2",
                    ),
                    Spacer(),
                    StepperBooking(
                      title: "Payment",
                      number: '3',
                      currectStep: "3",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      );
    }

    Widget hotelDetail() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(widget.photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.title,
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '\$${widget.price}',
                        style: priceTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        '/night',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: borderColor,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check-in",
                        style: primaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        DateFormat('E, d MMM yyyy').format(
                          DateTime.parse(widget.checkIn),
                        ),
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/ICNight.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${widget.night} night',
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Check-out",
                        style: primaryTextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        DateFormat('E, d MMM yyyy').format(
                          DateTime.parse(widget.checkOut),
                        ),
                        style: primaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget metodePembayaran() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detail Pembayaran",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Virtual Account",
                          style: secondaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              paymentOption,
                              style: primaryTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              paymentOption == "BCA"
                                  ? "assets/BCA.png"
                                  : paymentOption == "BNI"
                                      ? "assets/BNI.png"
                                      : paymentOption == "Mandiri"
                                          ? "assets/mandiri.png"
                                          : "assets/BCA.png",
                              width: 66,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Nomor Virtual Account",
                          style: secondaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(text: "780 0110 1080 1794"),
                            ).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Color(0xff1FAB89),
                                  content: Text(
                                      "Nomor Virtual Account berhasil disalin"),
                                ),
                              );
                            });
                            // copied successfully
                          },
                          child: Row(
                            children: [
                              Text(
                                "780 0110 1080 1794",
                                style: primaryTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                ),
                              ),
                              Container(
                                width: 21,
                                height: 21,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/ICCopy.png"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget totalPembayaran() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              "Total Pembayaran",
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Spacer(),
            Text(
              NumberFormat.currency(
                locale: 'en_US',
                symbol: '\$',
                decimalDigits: 0,
              ).format(widget.price),
              style: priceTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
      backgroundColor: backgroundColor1,
      body: Column(
        children: [
          header(),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView(
              children: [
                hotelDetail(),
                SizedBox(
                  height: 30,
                ),
                metodePembayaran(),
                SizedBox(
                  height: 20,
                ),
                totalPembayaran(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 44,
            margin: EdgeInsets.all(24),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main',
                  (route) => false,
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Home",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
