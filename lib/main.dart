import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tictatctoe/constants/boxes.dart';
import 'package:tictatctoe/constants/theme.dart';
import 'package:tictatctoe/data/gameLog.dart';
import 'package:tictatctoe/pages/home.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await Hive.initFlutter();
  Hive.registerAdapter(GamelogAdapter());
  myBox = await Hive.openBox("settings");
  games = await Hive.openBox("games");
  runApp(Application());
}

class Application extends StatelessWidget {
  Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}
