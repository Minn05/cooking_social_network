import 'package:flutter/material.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

void modalLoading(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white54,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                TextCustom(
                    text: 'Cook ',
                    color: ColorsCustom.primary,
                    fontWeight: FontWeight.w500),
                TextCustom(text: 'Together', fontWeight: FontWeight.w500),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const CircularProgressIndicator(color: ColorsCustom.primary),
                const SizedBox(width: 10),
                TextCustom(text: text, overflow: TextOverflow.visible)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
