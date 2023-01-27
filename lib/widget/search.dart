import 'package:flutter/material.dart';
import 'package:nginepyuk/theme.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, '/detail');
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
}
