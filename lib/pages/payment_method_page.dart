import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nginepyuk/pages/payment_page.dart';
import 'package:nginepyuk/theme.dart';
import 'package:nginepyuk/widget/stepper.dart';

enum PaymentOption { BCA, Mandiri, BNI }

class PaymentMethod extends StatefulWidget {
  final String checkIn;
  final String checkOut;
  final int night;
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String fullNameTamu;
  final String title;
  final String photo;
  final int price;
  final String hotelDocId;
  const PaymentMethod({
    Key? key,
    required this.checkIn,
    required this.checkOut,
    required this.night,
    required this.fullName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.fullNameTamu,
    required this.title,
    required this.photo,
    required this.price,
    required this.hotelDocId,
  }) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  PaymentOption? paymentValue = PaymentOption.BCA;
  @override
  Widget build(BuildContext context) {
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
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/ICArrowLeft.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
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
                      currectStep: "1",
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

    Future handleBooking() async {
      try {
        await FirebaseFirestore.instance.collection('orders').add({
          "userId": FirebaseAuth.instance.currentUser!.uid,
          "hotelDocId": widget.hotelDocId,
          'title': widget.title,
          'photo': widget.photo,
          'fullName': widget.fullName,
          'email': widget.emailAddress,
          'phoneNumber': widget.phoneNumber,
          'fullNameTamu': widget.fullNameTamu,
          "paymentMethod": paymentValue.toString(),
          'totalPrice': widget.price * widget.night,
          'checkIn': widget.checkIn,
          'checkOut': widget.checkOut,
          'night': widget.night,
          'isPaid': true,
          'isCancel': false,
          'isCheckIn': false,
          'isCheckOut': false,
        });
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => PaymentPage(
              checkIn: widget.checkIn,
              checkOut: widget.checkOut,
              night: widget.night,
              title: widget.title,
              photo: widget.photo,
              price: widget.price,
              hotelDocId: widget.hotelDocId,
              paymentOption: paymentValue.toString(),
            ),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      } catch (e) {
        print(e);
      }
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.all(24),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Price",
                  style: thirdTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  "\$${widget.price * widget.night}",
                  style: priceTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              height: 50,
              child: TextButton(
                onPressed: handleBooking,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 56),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  "Book Now",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
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
              "Pilih Metode Pembayaran",
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio<PaymentOption>(
                            activeColor: primaryColor,
                            value: PaymentOption.BCA,
                            groupValue: paymentValue,
                            onChanged: (PaymentOption? value) {
                              setState(() {
                                paymentValue = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            'assets/BCA.png',
                            width: 55,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "BCA Virtual Account",
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<PaymentOption>(
                            activeColor: primaryColor,
                            value: PaymentOption.Mandiri,
                            groupValue: paymentValue,
                            onChanged: (PaymentOption? value) {
                              setState(() {
                                paymentValue = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            'assets/mandiri.png',
                            width: 55,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Mandiri Virtual Account",
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<PaymentOption>(
                            activeColor: primaryColor,
                            value: PaymentOption.BNI,
                            groupValue: paymentValue,
                            onChanged: (PaymentOption? value) {
                              setState(() {
                                paymentValue = value;
                              });
                            },
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Image.asset(
                            'assets/BNI.png',
                            width: 55,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "BNI Virtual Account",
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: regular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
              ],
            ),
          ),
          footer(),
        ],
      ),
    );
  }
}
