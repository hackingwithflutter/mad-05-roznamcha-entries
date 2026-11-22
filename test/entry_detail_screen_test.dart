import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:roznamcha/entry.dart';
import 'package:roznamcha/screens/entry_detail_screen.dart';

import 'phone.dart';

void main() {
  // Both tests pass before and after the TODOs: the detail screen is given
  // code.
  testWidgets('The detail screen shows the entry it was given', (tester) async {
    final entry = Entry(
      title: 'Chai with Zain',
      body: 'Two cups each.',
      date: DateTime(2026, 11, 5),
      mood: Mood.happy,
    );
    await pumpOnPhone(
      tester,
      MaterialApp(home: EntryDetailScreen(entry: entry)),
    );
    expect(find.text('Chai with Zain'), findsOneWidget);
    expect(find.text('Happy, 5 Nov 2026'), findsOneWidget);
    expect(find.text('Two cups each.'), findsOneWidget);
    expect(find.byIcon(Icons.sentiment_satisfied_alt), findsOneWidget);
  });

  testWidgets('A long entry scrolls and nothing overflows', (tester) async {
    final entry = Entry(
      title: 'A very long day that needs a very long title to describe it',
      body: 'I wrote and wrote. ' * 200,
      date: DateTime(2026, 11, 5),
      mood: Mood.sad,
    );
    await pumpOnPhone(
      tester,
      MaterialApp(home: EntryDetailScreen(entry: entry)),
    );
    expect(tester.takeException(), isNull);
  });
}
