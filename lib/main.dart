import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'utils/custom_colors.dart';
import 'utils/session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FirebaseNotification().initialize();
  await GetStorage.init();
  var box = GetStorage();
  String route = AppRoutes.loginScreen;
  if (box.read(Session.isLogin) ?? false) {
    route = AppRoutes.mainScreen;
  }

  runApp(MyApp(route));
}

class MyApp extends StatelessWidget {
  static Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: true,
  );

  MyApp(this.initialRoute, {Key? key}) : super(key: key);

  final initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mpay Admin',
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: const MaterialColor(
          0xff0b1533,
          // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
          <int, Color>{
            50: Color(0xff1c3580), //10%
            100: Color(0xff1c3580), //20%
            200: Color(0xff1c3580), //30%
            300: Color(0xff1c3580), //40%
            400: Color(0xff1c3580), //50%
            500: Color(0xff162a66), //60%
            600: Color(0xff11204c), //70%
            700: Color(0xff0b1533), //80%
            800: Color(0xff060b19), //90%
            900: Color(0xff000000), //100%
          },
        ),
        fontFamily: 'CeraPro',
        // useMaterial3: true,
      ),
      navigatorKey: alice.getNavigatorKey(),
    );
  }
}
