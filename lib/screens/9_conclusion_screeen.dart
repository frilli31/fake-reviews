import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pencil_reviews/utils/app_color.dart';

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
                    flex: 4,
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
                Flexible(
                    child: Container(
                  width: 200,
                  height: 46,
                  child: ElevatedButton(
                    child: Text(
                      'CHIUDI',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: AppColors.buttonText),
                    ),
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');

                      if (Platform.isIOS) exit(0);
                    },
                  ),
                )),
                Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ));
  }
}
