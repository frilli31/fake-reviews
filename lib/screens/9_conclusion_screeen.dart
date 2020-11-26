import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                        'L’esperimento è concluso,\ngrazie per la collaborazione.',
                        style: Theme.of(context).textTheme.headline5,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                        ))),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ));
  }
}
