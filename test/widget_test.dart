import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lugabox_app/app.dart';
import 'package:lugabox_app/core/widgets/lugabox_logo.dart';

void main() {
  testWidgets('shows splash logo on launch', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: LugaBoxApp()));

    expect(find.byType(LugaBoxLogo), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
