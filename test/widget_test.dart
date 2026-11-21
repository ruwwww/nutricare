import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutricare/main.dart';

void main() {
  testWidgets('NutriCareApp renders', (tester) async {
    await tester.pumpWidget(const NutriCareApp());
    expect(find.text('NutriCare'), findsWidgets);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
