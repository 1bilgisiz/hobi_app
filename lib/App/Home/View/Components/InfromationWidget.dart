import 'package:flutter/material.dart';
import 'package:hobiapp/Utils/Palette.dart';
import 'package:hobiapp/Utils/StringMethodHelper.dart';

class InformationWidget extends StatelessWidget {
  final String information;
  const InformationWidget({super.key, required this.information});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Palette.lightGrey2.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        information.toCapitalized(),
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      ),
    );
  }
}
