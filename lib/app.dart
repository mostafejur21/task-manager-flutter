import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter/controller_bindings/controller_bindings.dart';
import 'package:task_manager_flutter/ui/screens/splash_screens.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: globalKey,
      debugShowCheckedModeBanner: false,
      title: "Task Manager",
      initialBinding: ControllerBinding(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
