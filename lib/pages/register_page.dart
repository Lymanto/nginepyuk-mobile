import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nginepyuk/theme.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Future signUpHandler() async {
    try {
      if (passwordConfirmed()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        User? user = userCredential.user;
        if (user != null) {
          addUserDetails(
            user.uid,
            _fullNameController.text.trim(),
            _emailController.text.trim(),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text("Password is too weak"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text("Email already in use"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: alertColor,
          content: Text("Gagal Register"),
        ),
      );
    }
  }

  Future addUserDetails(String uid, String fullName, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      "uid": uid,
      'fullName': fullName,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign Up",
            style: primaryTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "Register and Happy Shoping",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xff504F5E),
            ),
          )
        ],
      );
    }

    Widget fullNameInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Full Name",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                icon: Image.asset(
                  "assets/ICFullName.png",
                  width: 20,
                ),
                hintText: "Your Full Name",
                hintStyle: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      );
    }

    Widget emailInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email Address",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                icon: Image.asset(
                  "assets/ICEmail.png",
                  width: 20,
                ),
                hintText: "Your Email Address",
                hintStyle: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      );
    }

    Widget passwordInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                icon: Image.asset(
                  "assets/ICPassword.png",
                  width: 18,
                ),
                hintText: "Your Password",
                hintStyle: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              obscureText: true,
            ),
          )
        ],
      );
    }

    Widget confirmPasswordInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Confirm Password",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                icon: Image.asset(
                  "assets/ICPassword.png",
                  width: 18,
                ),
                hintText: "Confirm Password",
                hintStyle: secondaryTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              obscureText: true,
            ),
          )
        ],
      );
    }

    Widget registerButton() {
      return Container(
        width: double.infinity,
        height: 50,
        child: TextButton(
          onPressed: signUpHandler,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Sign Up",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: medium,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: primaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          GestureDetector(
            onTap: widget.showLoginPage,
            child: Text(
              "Sign In",
              style: priceTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              SizedBox(
                height: 70,
              ),
              fullNameInput(),
              SizedBox(
                height: 20,
              ),
              emailInput(),
              SizedBox(
                height: 20,
              ),
              passwordInput(),
              SizedBox(
                height: 30,
              ),
              confirmPasswordInput(),
              SizedBox(
                height: 30,
              ),
              registerButton(),
              Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
