/// BOOSTLY - Tests Widget
/// 
/// Tests des widgets de l'application.
/// 
/// @author BOOSTLY Team
/// @date 2025-01-09
/// @version 1.0.0
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';

void main() {
  group('Tests Widget BOOSTLY', () {
    testWidgets('Application démarre', (WidgetTester tester) async {
      // Construire l'application
      await tester.pumpWidget(const MyApp());

      // Vérifier que l'application est construite
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Widget de base fonctionne', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Center(child: Text('BOOSTLY'))),
        ),
      );

      expect(find.text('BOOSTLY'), findsOneWidget);
    });
  });
}
