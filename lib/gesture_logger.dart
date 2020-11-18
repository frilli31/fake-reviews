import 'package:fake_reviews/providers/log_provider.dart';
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
        context.read<LogProvider>().addStartTraceEvent(event);
      },
      onPointerUp: (PointerUpEvent event) {
        context.read<LogProvider>().addPointerEvent(event);
      },
      onPointerMove: (PointerMoveEvent event) {
        context.read<LogProvider>().addPointerEvent(event);
      },
      onPointerCancel: (PointerCancelEvent event) {
        context.read<LogProvider>().addPointerEvent(event);
      },
    );
  }
}
