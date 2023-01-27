import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nginepyuk/theme.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signInHandler() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: Text('Wrong password provided for that user.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: alertColor,
          content: Text(e.toString()),
        ),
      );
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login",
            style: primaryTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "Sign In to Countinue",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xff504F5E),
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

    Widget loginButton() {
      return Container(
        width: double.infinity,
        height: 50,
        child: TextButton(
          onPressed: signInHandler,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            "Sign In",
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
            "Don't have an account?",
            style: primaryTextStyle.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          GestureDetector(
            onTap: widget.showRegisterPage,
            child: Text(
              "Sign Up",
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
              emailInput(),
              SizedBox(
                height: 20,
              ),
              passwordInput(),
              SizedBox(
                height: 30,
              ),
              loginButton(),
              Spacer(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }
}
