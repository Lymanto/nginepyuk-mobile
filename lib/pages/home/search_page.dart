import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nginepyuk/theme.dart';
import 'package:nginepyuk/utils/string_extension.dart';
import 'package:nginepyuk/widget/recommend_item.dart';

import 'package:nginepyuk/widget/lastest_button.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  Widget searchBar(context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(defaultMargin),
              child: TextField(
                readOnly: true,
                onTap: () {
                  showSearch(context: context, delegate: Searching());
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  hintText: 'Find your Favorite Hotels',
                  hintStyle: secondaryTextStyle.copyWith(fontSize: 16),
                  prefixIcon: Container(
                    padding: EdgeInsets.all(15),
                    child: Image.asset('assets/ICSearchBN.png'),
                    width: 60,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget lastestSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lastest Search",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              LastestButton(),
              LastestButton(),
              LastestButton(),
              LastestButton(),
              LastestButton(),
              LastestButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget mostPopular() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Most Popular",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        searchBar(context),
        Divider(
          color: Color(0xffE1E1E1),
        ),
        SizedBox(
          height: 30,
        ),
        lastestSearch(),
        SizedBox(
          height: 30,
        ),
        mostPopular()
      ],
    );
  }
}

class Searching extends SearchDelegate {
  void saveSearch() async {
    const storage = FlutterSecureStorage();
    String? stringOfItems = await storage.read(key: 'searchingList');
    if (stringOfItems == null) {
      await storage.write(key: 'searchingList', value: jsonEncode([]));
      stringOfItems = await storage.read(key: 'searchingList');
    }

    List<dynamic> listOfItems = jsonDecode(stringOfItems!);
    if (listOfItems.length == 6) {
      listOfItems.removeLast();
      listOfItems.insert(0, query);
    } else {
      listOfItems.insert(0, query);
    }

    await storage.write(key: 'searchingList', value: jsonEncode(listOfItems));
  }

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    saveSearch();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hotels')
            .where('titleSearch', arrayContains: query.toTitleCase())
            .snapshots(),
        builder: ((context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
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
                          DocumentSnapshot hotel = snapshot.data!.docs[index];

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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.

    if (query.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lastest Search",
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                LastestButton(),
                LastestButton(),
                LastestButton(),
                LastestButton(),
                LastestButton(),
                LastestButton(),
              ],
            )
          ],
        ),
      );
    } else {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('hotels')
              .where('titleSearch', arrayContains: query.toTitleCase())
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : (ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot hotel = snapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          showResults(context);
                          query = hotel['title'];
                        },
                        child: ListTile(
                          title: Text(hotel['title']),
                        ),
                      );
                    }));
          });
    }
  }
}
