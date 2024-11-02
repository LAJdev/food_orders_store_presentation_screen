import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ui_model.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({
    super.key,
  });

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget> with TickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? controller;

  @override
  void initState() {
    // Future.doWhile(() async {
    // TODO: implement initState
    // await
    Future.delayed(const Duration(seconds: 10), () {
      controller = AnimationController(
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 1),
        vsync: this,
      );
      animation = Tween<double>(begin: 40, end: 35).animate(controller!)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          setState(() {
            if (status == AnimationStatus.completed) {
              controller!.reverse();
            } else if (status == AnimationStatus.dismissed) {}
          });
        });
      controller!.forward();
    });
    // });
    //   return true;
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (controller != null) {
      controller!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(builder: (context, uiprovider, child) {
      return Text.rich(TextSpan(
          // text: companynamepart1.toUpperCase(),
          text: uiprovider.companynamepart1.toUpperCase(),
          style: TextStyle(
              color: Colors.white,
              shadows: const [Shadow(color: Colors.white, blurRadius: 40)],
              fontSize: animation == null ? 40 * uiprovider.fullHdRatio.fullHdRatio : animation!.value * uiprovider.fullHdRatio.fullHdRatio,
              fontWeight: FontWeight.bold),
          children: <InlineSpan>[
            TextSpan(
              // text: companynamepart2.toUpperCase(),
              text: uiprovider.companynamepart2,
              style: TextStyle(
                  color: Colors.white, fontSize: animation == null ? 40 * uiprovider.fullHdRatio.fullHdRatio : animation!.value * uiprovider.fullHdRatio.fullHdRatio, fontWeight: FontWeight.normal),
            )
          ]));
    });
  }
}
