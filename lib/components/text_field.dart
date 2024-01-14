import 'package:firebase_app/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final TextEditingController? textController;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isObscureText;
  final Widget? prefixIcon;
  final Widget? sufficIcon;
  final List<TextInputFormatter>? inputFormat;

  CustomTextField(
      {Key? key,
      required this.hintText,
      this.textController,
      this.inputFormat = null,
      this.isObscureText = false,
      this.keyboardType,
      this.prefixIcon,
      this.sufficIcon})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _TextInputState();
}

class _TextInputState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    
    return TextField(
      style: TextStyle(
        color: primaryColor
      ),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormat,
      obscureText: widget.isObscureText,
      controller: widget.textController,
      decoration: InputDecoration(
        suffixIcon: widget.sufficIcon,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        border: InputBorder.none,
        hintStyle: GoogleFonts.montserrat(
          color: primaryColor
        )
      ),
    );
  }
}
