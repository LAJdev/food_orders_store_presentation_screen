import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'class.dart';


class DishesStreamProvider extends ChangeNotifier {
  late Dishes queuedorders;
  late Orders ordersready;
  late List<PickupBox> pickupBoxes;
  StreamController<List<PickupBox>?> streamControllerPickupBoxes =
      StreamController();

  Future<Orders?> readjsonorders() async {
    try {
      final String response = await rootBundle.loadString("assets/orders.json");

      final data = json.decode(response);
      Orders orders = Orders.fromJson(data["orders"]);
      return orders;
    } catch (e) {
      return null;
    }
  }

  Stream<List<PickupBox>?> getpickupbox() {
     pickupBoxes = List<PickupBox>.empty(growable: true);
    Stream<List<PickupBox>> streamPickupBoxes = readjsonorders().then((orders) {
      if (orders != null) {
        ///// sort elements by ordered time : first ordered, first on the list.
        orders.orders.sort((a, b) => a.orderedTime.compareTo(b.orderedTime));

        Dishes queueddishes = Dishes(dishes: List<Dish>.empty(growable: true));

        /// retrieve all dishes from all orders
        /// and put them in new list queueddishes.
        for (var element in orders.orders) {
          for (var subelement in element.dishes.dishes) {
            queueddishes.dishes.add(subelement);
          }
        }
        ///// assign dishes to pickupboxes list

        int queueddisheslength = queueddishes.dishes.length;
        for (var index = 0; index < queueddisheslength; index++) {
          pickupBoxes.add(PickupBox(
              id: index.toString(),
              dish: queueddishes.dishes[index],
              isempty: true,
              timer: null,
              duration:
                  Duration(seconds: queueddishes.dishes[index].availableTime)));
        }
      }
      return pickupBoxes;
    }).asStream();
    return streamPickupBoxes;
  }

  Stream<MapEntry<String, Duration>> getStreamMapDuration(
      int delay, Map<String, Duration> data, String orderid) {
    MapEntry<String, Duration> x;
    Stream<MapEntry<String, Duration>> streamMapEntry =
        Future.delayed(Duration(seconds: delay), () {
          //  Future.delayed(Duration.zero, () {
      x = data.entries.firstWhere((element) => element.key == orderid);
      return x;
    }).asStream();
    return streamMapEntry;
  }

}