import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inno_cart/backend_functions.dart';
import 'generate_route.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';

bool ok = false;
PlatformFile? pickedFile = null;
Future<void> calc() async {
  final directory = await getApplicationDocumentsDirectory();
  File file = File('${directory.path}/data.json');
  if (await file.exists() == true) {
    Map<String, dynamic> data = jsonDecode(await file.readAsString());
    ok = await dataIsCorrect(data['nickname'], data['password_hash'], 1);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  calc().then((value) => runApp(const MyApp()));
}

int selectedPage = 0;
const double bottomPadding = 29;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static List<Route<dynamic>> maybeSkip(String initialRoute) {
    if (ok)
      return [generateRoute(const RouteSettings(name: '/PageOfActiveOrders'))!];
    return [generateRoute(const RouteSettings(name: '/'))!];
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: generateRoute,
      onGenerateInitialRoutes: maybeSkip,
      debugShowCheckedModeBanner: false,
    );
  }
}
