import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:arctive/main.dart';

void main() {
  testWidgets('Arctive app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ArctiveApp()));
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsWidgets);
  });
}
