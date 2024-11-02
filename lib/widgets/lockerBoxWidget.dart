import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'boxWidget.dart';
import '../class/class.dart';
import '../models/dishes_model.dart';
import '../models/ui_model.dart';
import 'emptyboxWidget.dart';


class LockerBox extends StatefulWidget {
  const LockerBox({
    super.key,
  });
  
  @override
  State<LockerBox> createState() => _LockerBoxState();
}

class _LockerBoxState extends State<LockerBox> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Consumer2<UiProvider, List<PickupBox>?>(
        builder: (context, uiprovider, snaplistpickupbox, child) {
      var fullHdRatio = uiprovider.fullHdRatio.fullHdRatio;
      var fullHdHeight = uiprovider.fullHdheight;
      var fullHdWidth = uiprovider.fullHdwidth;
      Map<String, dynamic> timers = {};

      return Container(
          margin: EdgeInsets.symmetric(
              vertical: fullHdRatio * 90, horizontal: fullHdRatio * 70),
          padding: EdgeInsets.all(fullHdRatio * 5),
          width: fullHdWidth,
          height: fullHdHeight,
          decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 30)],
              color: Colors.black,
              borderRadius: BorderRadius.circular(20 * fullHdRatio)),
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5 * fullHdRatio),
              padding: EdgeInsets.all(20 * fullHdRatio),
              width: fullHdWidth,
              height: fullHdHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20 * fullHdRatio)),
              child: snaplistpickupbox == null
                  ? Container()
                  : GridView.builder(
                    //////Comments////////
                    /// Depending on the point of sale frequentation,
                    /// how to display all the dishes ready to pickup from lockerbox in the screen during rush hours?
                    /// without affecting the visibility on the screen? (not making the "virtual box" too small for the user to read)
                    /// 
                    /// First solution: Making the lockerbox on the screen scrollable? but if the countdown is close to zero, the user won't see the countdown...
                    /// 
                    /// Second solution: More than one screen in the point of sale ?
                    /// 
                    /// Third solution: once the countdown is zero, indicate to the consumer that the dish 
                    /// is not available anymore in the lockerbox with a simple message that dissapear 
                    /// after 30 seconds?
                    /// 
                    /// Fourth solution: A combination of previous solutions?
                    ///
                      physics: const NeverScrollableScrollPhysics(),
                      // itemCount: snaplistpickupbox.length,
                      itemCount: snaplistpickupbox.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // crossAxisCount: nbBoxPerRow,
                          crossAxisCount: uiprovider.nbBoxPerRow,
                          childAspectRatio: 1 / fullHdRatio),
                      itemBuilder: ((context, index) {
                        final data = {
                          snaplistpickupbox[index].dish!.orderid: Duration(
                              seconds:
                                  snaplistpickupbox[index].dish!.availableTime)
                        };
                        timers.addEntries(data.entries);
                        int delay =
                            snaplistpickupbox[index].dish!.cookingdelay +
                                snaplistpickupbox[index].dish!.orderedtime;
                        return StreamProvider<MapEntry<String, Duration>>.value(
                          value: DishesStreamProvider().getStreamMapDuration(
                              delay,
                              data,
                              snaplistpickupbox[index].dish!.orderid),
                          initialData: const MapEntry("waiting", Duration.zero),
                          updateShouldNotify:
                              (MapEntry<String, Duration> previous,
                                  MapEntry<String, Duration> current) {
                            return (current != previous);
                          },
                          catchError: (_, error) =>
                              const MapEntry("Error", Duration.zero),
                          child: Consumer<MapEntry<String, Duration>>(
                              builder: (context, snapmapentry, child) {
                            return snapmapentry.key == "waiting"
                                 ? const Emptybox()
                                : BoxWidget(
                                    index: index,
                                    duration: Duration(
                                        seconds: snapmapentry.value.inSeconds
                                            .truncate()),
                                    delay: delay,
                                  );
                          }),
                        );
                      }))));
    });
  }
}