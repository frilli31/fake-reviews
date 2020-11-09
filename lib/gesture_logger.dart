import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class GestureLogger extends StatelessWidget {
  const GestureLogger({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
        gestures: {
          AllowMultipleTapHandler:
              GestureRecognizerFactoryWithHandlers<AllowMultipleTapHandler>(
            () => AllowMultipleTapHandler(),
            (AllowMultipleTapHandler instance) {
              // instance
              //   ..onTapDown = (TapDownDetails details) {
              //     print(details);
              //   };
              // TODO: convert to pressure?? Pan 
            },
          )
        },
        behavior: HitTestBehavior.opaque,
        //Parent Container
        child: RawGestureDetector(
            gestures: {
              AllowMultiplePanHandler:
              GestureRecognizerFactoryWithHandlers<AllowMultiplePanHandler>(
                    () => AllowMultiplePanHandler(),
                    (AllowMultiplePanHandler instance) {
                  instance
                    ..onStart = (DragStartDetails details) {
                      //print(details);
                    }
                    ..onUpdate = (DragUpdateDetails details) {
                      //print(details);
                    }
                    ..onEnd = (DragEndDetails details) {
                      //print(details);
                    };
                },
              )
            },
            behavior: HitTestBehavior.opaque,
            //Parent Container
            child: child
        )
    );
  }
}

class AllowMultipleTapHandler extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //acceptGesture(pointer);
  }
}

class AllowMultiplePanHandler extends PanGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //acceptGesture(pointer);
  }
}
