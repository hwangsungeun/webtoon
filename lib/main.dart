import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
  checkPermission();
}

Future<void> checkPermission() async {
  if (await Permission.contacts.request().isGranted) {
  // Either the permission was already granted before or the user just granted it.
  }

// You can request multiple permissions at once.
  Map<Permission, PermissionStatus> statuses = await [
  Permission.phone,
  ].request();
  print(statuses[Permission.phone]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}