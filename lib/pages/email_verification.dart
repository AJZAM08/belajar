import 'package:firebase_app/components/constant.dart';
import 'package:firebase_app/components/custom_button.dart';
import 'package:firebase_app/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
      .sendPasswordResetEmail(email: _emailController.text);
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Email terkonfimasi!, Silahkan cek email anda'
            ),
          );
        }
      );
    } on FirebaseAuthException catch (error) {
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text(
              error.message.toString(),
              style: GoogleFonts.montserrat(
                fontSize: 12
              ),
            ),
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Lupa Password',
          style: GoogleFonts.montserrat(
            color: secondaryColor, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(LineIcons.angleLeft, color: secondaryColor,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Masukan Email',
            style: GoogleFonts.montserrat(
                color: primaryColor, fontWeight: FontWeight.w600, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: textFieldColor,
                border: Border.all(color: secondaryColor),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomTextField(
                  prefixIcon: Icon(LineIcons.envelope, color: primaryColor,),
                  hintText: 'Email',
                  textController: _emailController,
                )),
          ),
          SizedBox(
            height: 20,
          ),
          MyButton(
            fungsi: resetPassword, 
            textButton: 'Confirm'
          )
        ]),
      ),
    );
  }
}
