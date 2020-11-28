import 'package:fake_reviews/providers/log_provider.dart';
import 'package:fake_reviews/screens/2_survey_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                pageBuilder: (c, a1, a2) => SurveyScreen(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 500),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: Center(
                      child: Image.asset(
                        'images/logo.png',
                        height: 144,
                        fit: BoxFit.fill,
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Benvenuto in FakeReview',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
                        textAlign: TextAlign.center,
                      ),
                    )),
                    Expanded(
                        flex: 3,
                        child: Center(
                            child: Text(
                              'Tocca per continuare',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2,
                              textAlign: TextAlign.center,
                            ))),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              )),
        ));
  }
}
