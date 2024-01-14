import 'package:firebase_app/components/custom_button.dart';
import 'package:firebase_app/components/text_field.dart';
import 'package:firebase_app/pages/forgot_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_app/components/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:line_icons/line_icons.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {

    try {
      try {
        showDialog(
          context: context, 
          builder: (context) {
            return
              Center(
                child: CircularProgressIndicator(
                  color: textTheme(),
                ),
              );
          }
        );

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

        Navigator.of(context).pop();
      } on RecaptchaVerifierOnError catch (error) {
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              content: Text(
                "Error : Email atau password salah,\n mohon masukan data yang benar!",
                style: GoogleFonts.montserrat(
                  fontSize: 12
                ),
              ),
            );
          }
        );
        print(error.toString());
      }
    } on FirebaseAuthException catch (error) {
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Row(
                children: [
                  Icon(LineIcons.frowningFaceAlt, size: 50,),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Email atau password salah,\nmohon masukan data yang benar!",
                    style: GoogleFonts.montserrat(
                      fontSize: 15
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          );
        }
      );
      print(error.message.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Color cekBackground() {
    Color backgroundColor;
    var currentTheme = Theme.of(context);
    if (currentTheme.brightness == Brightness.light) {
      backgroundColor = Color.fromARGB(255, 177, 233, 255);
    } else {
      backgroundColor = Color.fromRGBO(12, 15, 39, 1);
    }
    return backgroundColor;
  }

  String cekLogo() {
    String logo;
    var currentTheme = Theme.of(context);
    if (currentTheme.brightness == Brightness.light) {
      logo = 'assets/logo_light.png';
    } else {
      logo = 'assets/logo_dark.png';
    }
    return logo;
  }

  Color textTheme() {
    Color backgroundColor;
    var currentTheme = Theme.of(context);
    if (currentTheme.brightness == Brightness.dark) {
      backgroundColor = secondaryColor;
    } else {
      backgroundColor = primaryColor;
    }
    return backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cekBackground(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  height: 200,
                  width: 200,
                  margin: EdgeInsets.all(20),
                  child: Image.asset(cekLogo()),
                ),
                SizedBox(
                  height: 10,
                ),

                // Sapaan
                Text(
                  'Hi There!',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: textTheme()
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // Input Username
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
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
                ),
                SizedBox(
                  height: 10,
                ),

                // Input Password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: textFieldColor,
                        border: Border.all(color: secondaryColor),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: CustomTextField(
                        prefixIcon: Icon(LineIcons.fingerprint, color: primaryColor,),
                        hintText: 'Password',
                        textController: _passwordController,
                        keyboardType: typeInput,
                        isObscureText: true,
                        inputFormat: formatInput,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => ForgotPage())
                          );
                        },
                        child: Text(
                          'Lupa Password?',
                          style: GoogleFonts.montserrat(
                              color: textTheme(), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: MyButton(fungsi: signIn, textButton: 'Sign In'),
                ),
                SizedBox(
                  height: 10,
                ),

                // Belum punya akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: GoogleFonts.montserrat(),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        'Daftar Sekarang',
                        style: GoogleFonts.montserrat(
                            color: textTheme(), fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
