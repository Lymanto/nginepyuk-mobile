import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nginepyuk/pages/payment_method_page.dart';
import 'package:nginepyuk/theme.dart';
import 'package:nginepyuk/widget/stepper.dart';

class BookingDetail extends StatefulWidget {
  final String docId;
  final String title;
  final int price;
  final String photo;
  const BookingDetail(
      {Key? key,
      required this.docId,
      required this.title,
      required this.price,
      required this.photo})
      : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _fullNameTamuController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  int night = 0;
  void initState() {
    checkInController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    checkOutController.text =
        DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1)));
    night = 1;
    super.initState();
  }

  void dispose() {
    checkInController.dispose();
    checkOutController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _fullNameTamuController.dispose();
    super.dispose();
  }

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
                      currectStep: "1",
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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
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
      );
    }

    Widget checkIn() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check-in',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: TextField(
                controller: checkInController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  icon: Image.asset(
                    "assets/ICCalendar.png",
                    width: 20,
                    color: primaryColor,
                  ),
                ),

                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(checkInController.text),
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    DateTime checkOut = DateTime.parse(checkOutController.text);
                    setState(() {
                      checkInController.text = formattedDate;
                      night = (checkOut.difference(pickedDate).inDays);
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget checkOut() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check-out',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: TextField(
                controller: checkOutController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  icon: Image.asset(
                    "assets/ICCalendar.png",
                    width: 20,
                    color: primaryColor,
                  ),
                ),

                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    DateTime checkIn = DateTime.parse(checkInController.text);
                    setState(() {
                      night = (pickedDate.difference(checkIn).inDays);
                      checkOutController.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget fullNameInput() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: TextField(
          controller: _fullNameController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            icon: Image.asset(
              "assets/ICFullName.png",
              width: 20,
            ),
            hintText: "Full Name",
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    Widget fullNameTamuInput() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: TextField(
          controller: _fullNameTamuController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            icon: Image.asset(
              "assets/ICFullName.png",
              width: 20,
            ),
            hintText: "Full Name",
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    Widget emailInput() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: TextField(
          controller: _emailController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            icon: Image.asset(
              "assets/ICEmail.png",
              width: 20,
            ),
            hintText: "Email Address",
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    Widget phoneNumberInput() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: TextField(
          controller: _phoneNumberController,
          decoration: InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none),
            icon: Image.asset(
              "assets/ICCall.png",
              width: 20,
            ),
            hintText: "Phone Number",
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      );
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
                  "\$${widget.price * night}",
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
                onPressed: () {
                  if (_fullNameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _phoneNumberController.text.isEmpty ||
                      _fullNameTamuController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: alertColor,
                        content: Text("Fill all the field"),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PaymentMethod(
                          checkIn: checkInController.text,
                          checkOut: checkOutController.text,
                          night: night,
                          fullName: _fullNameController.text,
                          emailAddress: _emailController.text,
                          phoneNumber: _phoneNumberController.text,
                          fullNameTamu: _fullNameTamuController.text,
                          title: widget.title,
                          photo: widget.photo,
                          price: widget.price,
                          hotelDocId: widget.docId,
                        );
                      },
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 56),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  "Next",
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
                  height: 24,
                ),
                checkIn(),
                SizedBox(
                  height: 12,
                ),
                checkOut(),
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Detail Pemesan",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                fullNameInput(),
                SizedBox(
                  height: 12,
                ),
                emailInput(),
                SizedBox(
                  height: 12,
                ),
                phoneNumberInput(),
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Detail Tamu",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                fullNameTamuInput(),
              ],
            ),
          ),
          footer(),
        ],
      ),
    );
  }
}
