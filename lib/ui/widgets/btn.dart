part of 'widgets.dart';

class Btn extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double border;
  final Color colorText;
  final Color backgroundColor;
  final double fontSize;
  final VoidCallback? onPressed;

  const Btn(
      {Key? key,
      required this.text,
      required this.width,
      this.onPressed,
      this.height = 50,
      this.border = 8.0,
      this.colorText = Colors.white,
      this.fontSize = 21,
      this.backgroundColor = ColorsCustom.secondary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          gradient: LinearGradient(
            colors: [
              ColorsCustom.primary,
              ColorsCustom.primary.withOpacity(0.5),
            ],
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
              // backgroundColor: backgroundColor,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(border))),
          child: TextCustom(text: text, color: colorText, fontSize: fontSize),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
