import 'package:flutter/material.dart';
import 'package:flutter_machine_test/common/appStrings/app_strings.dart';
import 'package:flutter_machine_test/config/providers.dart';
import 'package:flutter_machine_test/config/routes.dart';
import 'package:flutter_machine_test/view/splashScreen/splashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(AppStrings().hiveBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
          routes: routes),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
