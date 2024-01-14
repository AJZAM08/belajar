import 'package:firebase_app/components/constant.dart';
import 'package:firebase_app/components/custom_button.dart';
import 'package:firebase_app/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_icons/line_icons.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nomorhpController = TextEditingController();

  //user sign up
  void signUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      //create user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      //after creating the user, create a new document in cloud firestore called Users
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'Username': _usernameController.text, //initial username
        'Bio': 'Empty bio..', // initially empty bio
        'uid': userCredential.user!.uid, 
        'Email': _emailController.text,
        'Nomor Hp' : _nomorhpController.text,
        'profileRef' : null
      });

      //pop loading
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading
      Navigator.pop(context);
      //show error
      displayMessage(e.code);
    }
  }

  //masih pengembangan.....
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  //menyesuaikan logo sesuai tema
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

  //menentukan warna text sesuai tema
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

  //menentukan background sesuai tema
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

  // buat konfirmasi password
  bool passwordConfirm() {
    if (_passwordController.text == _confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _nomorhpController.dispose();
    super.dispose();
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
                          prefixIcon: Icon(LineIcons.user, color: primaryColor,),
                          hintText: 'Username',
                          textController: _usernameController,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

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
                          prefixIcon: Icon(LineIcons.phone, color: primaryColor,),
                          hintText: 'Nomor Hp',
                          textController: _nomorhpController,
                          keyboardType: typeInput,
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

                // Input Ulang Password
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
                        prefixIcon: Icon(LineIcons.check, color: primaryColor,),
                        hintText: 'Confirm Password',
                        textController: _confirmPasswordController,
                        keyboardType: typeInput,
                        isObscureText: true,
                        inputFormat: formatInput,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MyButton(fungsi: signUp, textButton: 'Sign Up'),
                ),
                SizedBox(
                  height: 10,
                ),

                // Belum punya akun
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: GoogleFonts.montserrat(),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text(
                        'Masuk Sekarang',
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
