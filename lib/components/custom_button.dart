import 'package:firebase_app/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function() fungsi;
  final String textButton;
  final IconData? icon;
  MyButton(
      {Key? key, required this.fungsi, required this.textButton, this.icon = null});

  @override
  Widget build(BuildContext context) {
    Color textButtonTheme() {
      Color backgroundColor;
      var currentTheme = Theme.of(context);
      if (currentTheme.brightness == Brightness.light) {
        backgroundColor = secondaryColor;
      } else {
        backgroundColor = primaryColor;
      }
      return backgroundColor;
    }

    Color buttonBackground() {
      Color backgroundColor;
      var currentTheme = Theme.of(context);
      if (currentTheme.brightness == Brightness.dark) {
        backgroundColor = secondaryColor;
      } else {
        backgroundColor = primaryColor;
      }
      return backgroundColor;
    }

    return GestureDetector(
      onTap: fungsi,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: buttonBackground(), borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? Row(
                    children: [
                      Center(
                        child: Text(
                          textButton,
                          style: GoogleFonts.montserrat(
                              color: textButtonTheme(),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        icon,
                        color: textButtonTheme(),
                      )
                    ],
                  )
                : Center(
                    child: Text(
                      textButton,
                      style: GoogleFonts.montserrat(
                          color: textButtonTheme(),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class InsideButton extends StatelessWidget {
  final Function() fungsi;
  final String textButton;
  final IconData? icon;
  InsideButton(
      {Key? key, required this.fungsi, required this.textButton, this.icon});

  @override
  Widget build(BuildContext context) {
    Color textButtonTheme() {
      Color backgroundColor;
      var currentTheme = Theme.of(context);
      if (currentTheme.brightness == Brightness.dark) {
        backgroundColor = secondaryColor;
      } else {
        backgroundColor = primaryColor;
      }
      return backgroundColor;
    }

    Color buttonBackground() {
      Color backgroundColor;
      var currentTheme = Theme.of(context);
      if (currentTheme.brightness == Brightness.light) {
        backgroundColor = secondaryColor;
      } else {
        backgroundColor = primaryColor;
      }
      return backgroundColor;
    }

    return GestureDetector(
      onTap: fungsi,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: buttonBackground(), borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            Text(
              textButton,
              style: GoogleFonts.montserrat(
                  color: textButtonTheme(), fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              icon,
              color: textButtonTheme(),
            )
          ],
        ),
      ),
    );
  }
}
