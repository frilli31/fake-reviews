import 'package:fake_reviews/utils/app_color.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BottomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: double.infinity,
      child: ElevatedButton(
        child: new Text(
          text.toUpperCase(),
          style: TextStyle(color: AppColors.buttonText),
        ),
        onPressed: onPressed,
      ),
    );
  }
}