import 'dart:async';

class Order {
  String orderid;
  Dishes dishes;
  // List<dynamic> dishes;
  // List<Dish> dishes;
  int orderedTime;
  int orderedDate;

  Order(
      {required this.orderid,
      required this.dishes,
      required this.orderedTime,
      required this.orderedDate});

  Order.fromJson(Map<String, dynamic> json)
      : this(
          orderid: json['orderid'] as String,
          // dishes: json['dishes'] ?? [],
          dishes: Dishes.fromJson(json['dishes'] ?? []),
          orderedTime: json['orderedtime'] ?? 0,
          // reply: json['reply'] ?? [],
          orderedDate: json['ordereddate'] ?? 0,
        );
}

class Orders {
  List<Order> orders;

  Orders({required this.orders});

  factory Orders.fromJson(List<dynamic> json) {
    // factory Orders.fromJson(Map<String, dynamic> json) {
    List<Order> orders =
        json.map((ordersjson) => Order.fromJson(ordersjson)).toList();
    return Orders(orders: orders);
  }
}

class Dish {
  String dishid;
  String orderid;
  String content;
  String icon;
  bool isready;
  bool isdelivered;
  int availableTime;
  int cookingdelay;
  int orderedtime;

  Dish(
      {required this.dishid,
      required this.orderid,
      required this.content,
      required this.icon,
      required this.isready,
      required this.isdelivered,
      required this.availableTime,
      required this.cookingdelay,
      required this.orderedtime});

  Dish.fromJson(Map<String, dynamic> json)
      : this(
            dishid: json['dishid'] as String,
            orderid: json['orderid'] as String,
            icon: json['icon'] ?? "",
            content: json['content'] ?? '',
            isready: json['isready'] ?? false,
            isdelivered: json['isdelivered'] ?? false,
            availableTime: json['availabletime'] ?? 0,
            cookingdelay: json['cookingdelay'] ?? 0,
            orderedtime: json['orderedtime'] ?? 0);
}

class Dishes {
  List<Dish> dishes;
  Dishes({required this.dishes});

  factory Dishes.fromJson(List<dynamic> json) {
    // factory Orders.fromJson(Map<String, dynamic> json) {
    List<Dish> dishes =
        json.map((dishesjson) => Dish.fromJson(dishesjson)).toList();
    return Dishes(dishes: dishes);
  }
}

class DishesStream {
  List<Dish> dishes;
  DishesStream({required this.dishes});
}

class PickupBox {
  String id;
  Dish? dish;
  bool isempty;
  Timer? timer;
  Duration? duration;

  PickupBox(
      {required this.id,
      required this.dish,
      required this.isempty,
      required this.timer,
      required this.duration});
}

class PickupBoxes {
  List<PickupBox> pickupboxes;

  PickupBoxes(this.pickupboxes);
}

class FullHdRatio {
  double fullHdRatio;

  FullHdRatio(this.fullHdRatio);
}
