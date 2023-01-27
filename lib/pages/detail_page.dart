import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nginepyuk/pages/booking_detail_page.dart';
import 'package:nginepyuk/theme.dart';
import 'package:nginepyuk/widget/facilities_card.dart';

class DetailPage extends StatefulWidget {
  final String docId;
  DetailPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var collection = FirebaseFirestore.instance.collection('hotels');

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
        ),
      );
    }

    Widget header(List images) {
      int index = -1;
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 310,
        child: Stack(
          children: [
            CarouselSlider(
              items: images
                  .map(
                    (image) => Image.network(
                      image,
                      width: MediaQuery.of(context).size.width,
                      height: 310,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 310,
                initialPage: 0,
                onPageChanged: ((index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 50,
                left: 20,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(
                    left: 2,
                    top: 3,
                    bottom: 3,
                    right: 4,
                  ),
                  child: Image.asset('assets/ICArrowLeft.png', width: 30),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 45),
                width: 40,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.map((e) {
                    index++;
                    return indicator(index);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content(
      String title,
      String city,
      String country,
      String description,
      int price,
      List images,
      double rating,
      String photo,
    ) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 275),
        height: MediaQuery.of(context).size.height - 275,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                    vertical: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: primaryTextStyle.copyWith(
                                  fontSize: 18, fontWeight: semiBold),
                            ),
                            Text(
                              '$city, $country',
                              style: secondaryTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
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
                Padding(
                  padding: EdgeInsets.only(
                    left: defaultMargin,
                  ),
                  child: Text(
                    "Hotel Facilities",
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 137,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: defaultMargin,
                      bottom: 24,
                    ),
                    scrollDirection: Axis.horizontal,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 20,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: images.length,
                      itemBuilder: (context, index) => FacilitiesCard(
                        title: images[index]['title'],
                        image: images[index]['photo'],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: defaultMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: semiBold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        description,
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: secondaryTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "\$$price",
                            style: priceTextStyle.copyWith(
                              fontWeight: bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "/night",
                            style: secondaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BookingDetail(
                            docId: widget.docId,
                            title: title,
                            price: price,
                            photo: photo,
                          );
                        },
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(27.5),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 58,
                        vertical: 16,
                      ),
                      child: Text(
                        "Book Now",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: semiBold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: collection.doc(widget.docId).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');
              if (snapshot.hasData) {
                var data = snapshot.data!.data();
                return Stack(
                  children: [
                    header(data!['photo']),
                    content(
                      data['title'],
                      data['city'],
                      data['country'],
                      data['description'],
                      data['price'],
                      data['facilities'],
                      data['rating'],
                      data['photo'][0],
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}
