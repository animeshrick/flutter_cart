import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart/router/router_manager.dart';
import 'package:flutter_cart/storage/local_product_bloc/local_products_bloc.dart';
import 'package:flutter_cart/utils/text_utils.dart';
import 'package:toastification/toastification.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              LocalProductsBloc()..add(GetLocalProductList()),
        ),
      ],
      child: ToastificationWrapper(
        child: MaterialApp.router(
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
        ),
      ),
    );
  }
}
