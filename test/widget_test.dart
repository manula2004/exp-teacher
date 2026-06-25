import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:exg_parent/main.dart';

void main() {
  testWidgets('App smoke test — renders MaterialApp', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TeacherClassOverviewApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
