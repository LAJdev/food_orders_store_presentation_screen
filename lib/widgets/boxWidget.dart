import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../class/class.dart';
import 'timerWidget.dart';
import '../models/ui_model.dart';

class BoxWidget extends StatefulWidget {
  const BoxWidget(
      {required this.index,
      required this.duration,
      required this.delay,
      super.key});

  final int index;
  final Duration duration;
  final int delay;
  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget>
    with SingleTickerProviderStateMixin {
  late Map<String, Duration> data;
  late Animation<double> animation;
  late AnimationController controller;
  late bool _isboxempty;

  @override
  void initState() {
    // Timer(Duration(seconds: widget.delay), () {
    _isboxempty = true;
    controller = AnimationController(
      duration: widget.duration,
      // duration: Duration(seconds: 10),
      vsync: this,
    );
    animation = Tween<double>(
            begin: widget.duration.inSeconds.toDouble(), end: 0)
        // Tween<double>(begin: Duration(seconds: 10).inSeconds.toDouble(), end: 0)
        .animate(controller)
      ..addListener(() {
        _isboxempty = false;

        setState(() {});
      })
      ..addStatusListener((status) {
        setState(() {
          if (status == AnimationStatus.completed) {
            _isboxempty = true;
          } else if (status == AnimationStatus.dismissed) {}
        });
      });
    // if (mounted) {
    // controller.forward();
    // }
    // Timer(Duration(milliseconds: widget.delay), () {
    //   if (mounted) {
    controller.forward();
    //   }
    // });
    // });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<UiProvider, List<PickupBox>?, MapEntry<String, Duration>>(
        builder: (context, uiprovider, pickboxsnap, mapentry, child) {
      var fullHdRatio = uiprovider.fullHdRatio.fullHdRatio;
      if (pickboxsnap != null) {
        data = {
          pickboxsnap[widget.index].dish!.orderid:
              Duration(seconds: pickboxsnap[widget.index].dish!.availableTime)
        };
      }
      return pickboxsnap == null
          ? Container()
          : Consumer<MapEntry<String, Duration>>(
              builder: (context, snapmapentry, child) {
              // print('Value: ${snapmapentry.value.inSeconds}');
              print('Rebuilt');
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10 * fullHdRatio),
                              child: (snapmapentry.value.inSeconds == 0.0 ||
                                      _isboxempty)
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "OrderId: ${pickboxsnap[widget.index].dish!.orderid}",
                                            style: TextStyle(
                                                fontSize: 15 * fullHdRatio),
                                          ),
                                        ),
                                      ],
                                    )),
                        ),
                        Expanded(
                            child: (_isboxempty)
                                ? Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.black,
                                        Colors.white,
                                      ],
                                    )),
                                  )
                                : Container(
                                    decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0XFFeedd82),
                                        Colors.white,
                                      ],
                                    )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //////Comments////////
                                        /// To avoid copyright issues for the test, the icon chosen
                                        /// are just emoticones provided by the device used.
                                        /// For production, let's store hd images/icons to have a better
                                        /// rendering on the screen, if showing something to the customer
                                        /// is advised.
                                        Text(
                                            pickboxsnap[widget.index]
                                                .dish!
                                                .icon,
                                            style: TextStyle(
                                                fontSize: 60 * fullHdRatio)),
                                      ],
                                    ),
                                  )),
                        Container(
                          height: 20 * fullHdRatio,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(36, 121, 85, 72),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5 * fullHdRatio),
                                  bottomRight:
                                      Radius.circular(5 * fullHdRatio))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10 * fullHdRatio),
                            child: (snapmapentry.value.inSeconds == 0.0 ||
                                    _isboxempty)
                                ? Container()
                                : Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Box N°${widget.index}",
                                          style: TextStyle(
                                              fontSize: 15 * fullHdRatio),
                                        ),
                                      ),
                                      TimerWidget(
                                        duration: Duration(
                                            seconds: snapmapentry
                                                .value.inSeconds
                                                .truncate()),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),

                    /////////////
                    
                  ],
                ),
              );
            });
    });
  }
}

//////////