import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nginepyuk/theme.dart';
import 'package:nginepyuk/widget/card_item.dart';
import 'package:nginepyuk/widget/recommend_item.dart';

import '../../widget/card_item_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 40, left: defaultMargin),
        width: 240,
        child: Text(
          "Nginep Dengan Harga Murah",
          style: primaryTextStyle.copyWith(
            fontSize: 30,
            fontWeight: semiBold,
            height: 1.3,
          ),
        ),
      );
    }

    Widget cardList() {
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hotels')
            .where('rating', isGreaterThanOrEqualTo: 4.8)
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? SingleChildScrollView(
                  padding: EdgeInsets.only(top: 12, bottom: defaultMargin),
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.only(left: defaultMargin),
                    height: 356,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                      child: CardItemShimmer(),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.only(top: 12, bottom: defaultMargin),
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.only(left: defaultMargin),
                    height: 356,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot hotel = snapshot.data!.docs[index];

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                          child: CardItem(
                            docId: snapshot.data!.docs[index].id,
                            title: hotel['title'],
                            city: hotel['city'],
                            country: hotel['country'],
                            rating: hotel['rating'],
                            price: hotel['price'],
                            photo: hotel['photo'][0],
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      );
    }

    Widget mostPopular() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Most Popular",
                  style: primaryTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                    height: 1.2,
                  ),
                ),
                Text(
                  "View all",
                  style: priceTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('hotels')
                  .where('isPopular', isEqualTo: true)
                  .limit(3)
                  .snapshots(),
              builder: ((context, snapshot) {
                return !snapshot.hasData
                    ? Text("waiting")
                    : Column(
                        children: [
                          ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot hotel =
                                    snapshot.data!.docs[index];

                                return RecommendItem(
                                  docId: snapshot.data!.docs[index].id,
                                  title: hotel['title'],
                                  city: hotel['city'],
                                  rating: hotel['rating'],
                                  photo: hotel['photo'][0],
                                );
                              })
                        ],
                      );
              }),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommended For You",
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: semiBold,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      "View all",
                      style: priceTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                    )
                  ],
                ),
              ),
              cardList(),
            ],
          ),
          mostPopular(),
        ],
      ),
    );
  }
}
