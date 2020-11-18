import 'package:fake_reviews/providers/log_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'instruction_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.of(context);
      context.read<LogProvider>().sendScreenDetails(ScreenDetails(
            width: mediaQuery.size.width,
            height: mediaQuery.size.height,
            details: mediaQuery.toString(),
          ));
      context.read<LogProvider>().sendDeviceInfo();
    });

    return Scaffold(
      body: SafeArea(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => InstructionScreen(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 500),
                ),
              );
            },
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: Center(
                      child: Image.asset(
                        'images/logo.png',
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Benvenuto in FakeReview',
                        textScaleFactor: 2,
                        softWrap: true,
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Center(
                        child: Text(
                      'Tocca per continuare',
                      textScaleFactor: 1,
                    ))),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          )),
    );
  }
}
