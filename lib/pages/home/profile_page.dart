import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nginepyuk/utils/string_extension.dart';
import 'package:nginepyuk/theme.dart';

class ProfilePage extends StatelessWidget {
  final String? user;
  const ProfilePage({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        color: primaryColor,
        padding: EdgeInsets.all(30),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('email', isEqualTo: user)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Error = ${snapshot.error}');
                } else {
                  var data = snapshot.data!.docs[0];
                  return Text(
                    data['fullName'].toString().toTitleCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: semiBold,
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ICExit.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget menuItem(String title) {
      return Row(
        children: [
          Text(
            title,
            style: secondaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          Spacer(),
          Icon(
            Icons.chevron_right,
            size: 28,
            color: Color(0xff8D92A3),
          ),
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        margin: EdgeInsets.only(top: 124),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            menuItem('Edit Profile'),
            SizedBox(
              height: 12,
            ),
            menuItem('Your Orders'),
            SizedBox(
              height: 12,
            ),
            menuItem('Help'),
            SizedBox(
              height: 30,
            ),
            Text(
              'Account',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            menuItem('Privacy & Policy'),
            SizedBox(
              height: 16,
            ),
            menuItem('Term of Service'),
            SizedBox(
              height: 16,
            ),
            menuItem('Rate App'),
          ],
        ),
      );
    }

    return Stack(
      children: [
        header(),
        content(),
      ],
    );
  }
}
