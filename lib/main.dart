import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sigara_metre/pages/home/home_page.dart';
import 'package:sigara_metre/provider/home_provider.dart';

void main() {
  // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // myMaterialApp(context);
        DevicePreview(
      enabled: true,
      builder: (context) => myMaterialApp(context),
    );
  }

  Widget myMaterialApp(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primaryColor: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.blue,
            ),
      ),
      title: 'Sigara Sayar',
      home: ChangeNotifierProvider<HomeProvider>(
        create: (_) => HomeProvider(),
        child: HomePage(),
      ),
    );
  }
}
