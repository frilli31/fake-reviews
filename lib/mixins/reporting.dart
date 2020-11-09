import 'package:fake_reviews/models/log_recipient.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


mixin Reporting {
  void report(BuildContext c) {
    c.read<LogRecipient>().addOne({
      'type':'DISPLAYED',
      'widget': runtimeType,
      'item': toString()
    });
  }
}