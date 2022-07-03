import 'package:flutter/material.dart';
import 'package:inno_cart/backend_functions.dart';
import 'generate_route.dart';
import 'WelcomePage/start_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'ServerURL.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

bool ok = false;

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

  calc().then((value) => runApp(const MyApp()));
}

int selectedPage = 0;
const double bottomPadding = 29;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static List<Route<dynamic>> maybeskip(String initialRoute) {
    if (ok) return [generateRoute(RouteSettings(name: '/PageOfActiveOrders'))!];
    return [generateRoute(RouteSettings(name: '/'))!];
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: generateRoute,
      onGenerateInitialRoutes: maybeskip,
      debugShowCheckedModeBanner: false,
    );
  }
}
