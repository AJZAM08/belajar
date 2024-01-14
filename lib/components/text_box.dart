import 'package:firebase_app/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  final IconData? customIcon;

  const MyTextBox(
      {super.key,
      required this.sectionName,
      required this.text,
      required this.onPressed,
      this.customIcon});

  @override
  Widget build(BuildContext context) {
    Color cekBackground() {
      Color backgroundColor;
      var currentTheme = Theme.of(context);
      if (currentTheme.brightness == Brightness.dark) {
        backgroundColor = secondaryColor;
      } else {
        backgroundColor = primaryColor;
      }
      return backgroundColor;
    }

    Color componentColor() {
      Color backgroundColor;
      var currentTheme = Theme.of(context);
      if (currentTheme.brightness == Brightness.light) {
        backgroundColor = secondaryColor;
      } else {
        backgroundColor = primaryColor;
      }
      return backgroundColor;
    }

    return Container(
      decoration: BoxDecoration(
        color: cekBackground(),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, right: 5, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //name
              Text(
                sectionName,
                style: GoogleFonts.montserrat(
                  color: componentColor(),
                  fontWeight: FontWeight.w600
                ),
              ),
              //edit
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    customIcon,
                    color: componentColor(),
                  ))
            ],
          ),
          //teks
          Text(
            text,
            style: GoogleFonts.montserrat(color: componentColor()),
          ),
        ],
      ),
    );
  }
}
