import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Color primaryColor = Color.fromRGBO(12, 15, 39, 1);
final Color secondaryColor = Color.fromRGBO(255, 255, 255, 1);
final Color ternaryColor = Color.fromRGBO(255, 171, 17, 1);
final Color? textFieldColor = Colors.grey[200];
final List<TextInputFormatter> formatInput = [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
final TextInputType typeInput = TextInputType.numberWithOptions(decimal: false);