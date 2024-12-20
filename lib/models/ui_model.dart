import 'package:flutter/material.dart';

import '../class/class.dart';

class UiProvider extends ChangeNotifier {
  // Full HD screen pixels infos
  // height: 1080.0
  // width: 1920.0

  final double _fullHdHeight = 1080.0;
  final double _fullHdWidth = 1920.0;
  final FullHdRatio _fullHdRatio = FullHdRatio(1080.0 / 1920.0);

  //background image path
  final String _imgpath = 'assets/background_image_wood.png';

  double get fullHdheight => _fullHdHeight;
  double get fullHdwidth => _fullHdWidth;
  FullHdRatio get fullHdRatio => _fullHdRatio;
  String get imgpath => _imgpath;


    // lockerbox parameters
  final int _nbBox = 15;
  final int _nbBoxPerRow = 5;

  int get nbBox => _nbBox;
  int get nbBoxPerRow => _nbBoxPerRow;

  // company name
  final String _companynamepart1 = "part1";
  final String _companynamepart2 = "part2";

  String get companynamepart1 => _companynamepart1;
  String get companynamepart2 => _companynamepart2;
  
}
