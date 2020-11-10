import 'package:fake_reviews/models/log_recipient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class GestureLogger extends StatelessWidget {
  const GestureLogger({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: child,
      onPointerDown: (PointerDownEvent event) {
        context.read<LogRecipient>().addPointerEvent(event);
      },
      onPointerUp: (PointerUpEvent event) {
        context.read<LogRecipient>().addPointerEvent(event);
      },
      onPointerMove: (PointerMoveEvent event) {
        context.read<LogRecipient>().addPointerEvent(event);
      },
      onPointerCancel: (PointerCancelEvent event) {
        context.read<LogRecipient>().addPointerEvent(event);
      },
    );
  }
}
