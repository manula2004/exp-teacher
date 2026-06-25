import 'package:flutter/material.dart';
import 'screens/my_classes_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TeacherClassOverviewApp());
}

class TeacherClassOverviewApp extends StatelessWidget {
  const TeacherClassOverviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Class Overview',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MyClassesScreen(),
    );
  }
}
