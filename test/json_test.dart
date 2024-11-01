import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('load orders data', () async {
    final file = await rootBundle.loadString("assets/orders.json");
    final json = jsonDecode(file);
    final orders = json["orders"];
    

    final firstorder = orders.first;
    expect(firstorder["orderid"], "00000");
    expect(firstorder["orderedtime"], 10);
    expect(firstorder["ordereddate"], 0);

    final lastorder = orders.last;
    expect(lastorder["orderid"], "00009");
    expect(lastorder["orderedtime"], 9);
    expect(lastorder["ordereddate"], 0);

    final dishesfirstorder = json["orders"][0]["dishes"][0];

    final firstdish = dishesfirstorder;
    expect(firstdish["dishid"], "A000");
    expect(firstdish["orderid"], "00000");
    expect(firstdish["content"], "Salad");

    final disheslasttorder = json["orders"][11]["dishes"][0];

    final firstdishlastorder = disheslasttorder;
    expect(firstdishlastorder["dishid"], "A017");
    expect(firstdishlastorder["orderid"], "00012");
    expect(firstdishlastorder["content"], "burrito");
  });
}
