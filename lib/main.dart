import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'class.dart';
import 'dishesStream.dart';
import 'lockerBox.dart';
import 'logoWidget.dart';
import 'uiprovider.dart';

void main() {
  ///// Set the device orientation to landscape because our it is
  ///// the best orientation to represent the lockerBox on a full HD Screen
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UiProvider()),
        StreamProvider<List<PickupBox>?>.value(
          value: DishesStreamProvider().getpickupbox(),
          initialData: null,
          updateShouldNotify:
              (List<PickupBox>? previous, List<PickupBox>? current) {
            return (current != previous);
          },
          catchError: (context, error) {
            print(error);
            return null;
          },
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: BodyScreen()),
      ),
    );
  }
}

class BodyScreen extends StatelessWidget {
  const BodyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(builder: (context, uiprovider, child) {
      var fullHdRatio = uiprovider.fullHdRatio.fullHdRatio;
      return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset(uiprovider.imgpath).image, fit: BoxFit.fill),
          ),
          child: Stack(
            children: [
              Positioned(
                right: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.width *
                    uiprovider.fullHdRatio.fullHdRatio *
                    0.02,
                child: const LogoWidget(),
              ),
              Consumer<List<PickupBox>?>(
                  builder: (context, snappickupboxlist, child) {
                return const LockerBox();
              }),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.width *
                      uiprovider.fullHdRatio.fullHdRatio *
                      0.02,
                  child:
                      Text("🌿", style: TextStyle(fontSize: 60 * fullHdRatio))),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.width *
                      uiprovider.fullHdRatio.fullHdRatio *
                      0.02,
                  child:
                      Text("🌱", style: TextStyle(fontSize: 60 * fullHdRatio))),
              Positioned(
                  right: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.width *
                      uiprovider.fullHdRatio.fullHdRatio *
                      0.02,
                  child:
                      Text("🍀", style: TextStyle(fontSize: 60 * fullHdRatio))),
            ],
          ));
    });
  }
}
