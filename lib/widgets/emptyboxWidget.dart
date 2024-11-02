import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/ui_model.dart';

class Emptybox extends StatelessWidget {
  const Emptybox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
        builder: (context, uiprovider, child) {
      var fullHdRatio = uiprovider.fullHdRatio.fullHdRatio;
      return Container(
        margin: EdgeInsets.fromLTRB(10 * fullHdRatio, 20 * fullHdRatio,
            10 * fullHdRatio, 20 * fullHdRatio),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: 0.5 * fullHdRatio,
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: BorderRadius.circular(5 * fullHdRatio)),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 20 * fullHdRatio,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(36, 121, 85, 72),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5 * fullHdRatio),
                          topRight: Radius.circular(5 * fullHdRatio))),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10 * fullHdRatio),
                      child: Container()),
                ),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black,
                      Colors.white,
                    ],
                  )),
                )),
                Container(
                  height: 20 * fullHdRatio,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(36, 121, 85, 72),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5 * fullHdRatio),
                          bottomRight: Radius.circular(5 * fullHdRatio))),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10 * fullHdRatio),
                      child: Container()),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
