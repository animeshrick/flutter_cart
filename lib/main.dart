import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/router/router_manager.dart';
import 'package:flutter_cart/utils/text_utils.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart'; // For getting the desktop path

import 'const/color_const.dart';
import 'extension/hex_color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final appDocumentDir = await getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: TextUtils.appTitle,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorSchemeSeed: HexColor.fromHex(ColorConst.baseHexColor),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: HexColor.fromHex(ColorConst.baseHexColor),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      routerConfig: RouterManager.getInstance.router,
    );
  }
}
