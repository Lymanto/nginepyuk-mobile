import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nginepyuk/theme.dart';
import 'package:nginepyuk/widget/order_item.dart';

class OrderPage extends StatefulWidget {
  final String? user;
  const OrderPage({Key? key, this.user}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget header() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: 24,
              left: defaultMargin,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
            child: Text(
              "Orders",
              style: primaryTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget orderButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 6,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.symmetric(horizontal: 5),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primaryColor,
            labelStyle: TextStyle(
              fontWeight: semiBold,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: regular,
            ),
            tabs: [
              Container(
                width: 82,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    "Ongoing",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                width: 82,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    "History",
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(),
        orderButton(),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('userId', isEqualTo: widget.user)
                    .where('isCheckOut', isEqualTo: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      children: snapshot.data!.docs.map((e) {
                        return OrderItem(
                          hotelDocId: e['hotelDocId'],
                          title: e['title'],
                          photo: e['photo'],
                          night: e['night'],
                          price: e['totalPrice'],
                          checkIn: e['checkIn'],
                          checkOut: e['checkOut'],
                          isCanceled: e['isCancel'],
                          isCheckOut: e['isCheckOut'],
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('userId', isEqualTo: widget.user)
                    .where('isCancel', isEqualTo: true)
                    .where('isCheckOut', isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      children: snapshot.data!.docs.map((e) {
                        return OrderItem(
                          hotelDocId: e['hotelDocId'],
                          title: e['title'],
                          photo: e['photo'],
                          night: e['night'],
                          price: e['totalPrice'],
                          checkIn: e['checkIn'],
                          checkOut: e['checkOut'],
                          isCanceled: e['isCancel'],
                          isCheckOut: e['isCheckOut'],
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
