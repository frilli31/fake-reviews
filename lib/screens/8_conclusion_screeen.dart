import 'package:fake_reviews/providers/log_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConclusionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            'L’esperimento è concluso, grazie per la collaborazione.',
                            textScaleFactor: 1.5,
                            softWrap: true,
                          ),
                        ))),
                Spacer(
                  flex: 3,
                )
              ],
            ),
          ),
        ));
  }
}
