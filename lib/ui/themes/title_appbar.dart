import 'package:flutter/material.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

class TitleAppbar extends StatelessWidget {
  const TitleAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text: title,
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: ColorsCustom.secondary,
      isTitle: true,
    );
  }
}
