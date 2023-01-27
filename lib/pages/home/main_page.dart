import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nginepyuk/pages/home/home_page.dart';
import 'package:nginepyuk/pages/home/order_page.dart';
import 'package:nginepyuk/pages/home/profile_page.dart';
import 'package:nginepyuk/pages/home/search_page.dart';
import 'package:nginepyuk/theme.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser!;
  int currentIndex = 0;

  Widget customButtonNav() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(
              top: 12,
              bottom: 12,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/ICHome.png',
                  width: 24,
                  color: currentIndex == 0 ? primaryColor : secondaryColor,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Home',
                  style: currentIndex == 0
                      ? priceTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        )
                      : secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                )
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(
              top: 12,
              bottom: 12,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/ICSearchBN.png',
                  width: 24,
                  color: currentIndex == 1 ? primaryColor : secondaryColor,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Search',
                  style: currentIndex == 1
                      ? priceTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        )
                      : secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                )
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(
              top: 12,
              bottom: 12,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/ICOrder.png',
                  width: 24,
                  color: currentIndex == 2 ? primaryColor : secondaryColor,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Order',
                  style: currentIndex == 2
                      ? priceTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        )
                      : secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                )
              ],
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(
              top: 12,
              bottom: 12,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/ICProfile.png',
                  width: 24,
                  color: currentIndex == 3 ? primaryColor : secondaryColor,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Profile',
                  style: currentIndex == 3
                      ? priceTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        )
                      : secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                ),
              ],
            ),
          ),
          label: '',
        ),
      ],
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return SearchPage();
      case 2:
        return OrderPage(user: user.uid);
      case 3:
        return ProfilePage(user: user.email!);

      default:
        return HomePage();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentIndex == 3 ? primaryColor : Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: currentIndex == 3 ? primaryColor : Colors.white,
        ),
      ),
      backgroundColor: currentIndex == 3 ? primaryColor : backgroundColor1,
      bottomNavigationBar: customButtonNav(),
      body: SafeArea(
        child: body(),
      ),
    );
  }
}
