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
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 2),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          text.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: AppColors.buttonText),
        ),
        onPressed: onPressed,
      ),
    );
  }
}