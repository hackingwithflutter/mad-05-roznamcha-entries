import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:roznamcha/entry.dart';
import 'package:roznamcha/screens/add_entry_screen.dart';

import 'phone.dart';

/// Builds a screen with one button, taps it, and so opens the add screen on
/// top of it, as the home screen does. The add screen reports to [onSave].
Future<void> openAddScreen(
  WidgetTester tester, {
  ValueChanged<Entry>? onSave,
}) async {
  await pumpOnPhone(
    tester,
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) =>
                      AddEntryScreen(onSave: onSave ?? (_) {}),
                ),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
}

void main() {
  // These two tests pass before and after the TODOs: they check given code.
  testWidgets('The add screen shows two fields, three moods and Save', (
    tester,
  ) async {
    await openAddScreen(tester);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ChoiceChip), findsNWidgets(3));
    expect(find.widgetWithText(FilledButton, 'Save'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('An empty title, or only spaces, does not validate', (
    tester,
  ) async {
    await openAddScreen(tester);
    final form = tester.state<FormState>(find.byType(Form));
    expect(form.validate(), isFalse);
    await tester.pump();
    expect(find.text('Please enter a title.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).first, '   ');
    expect(form.validate(), isFalse);
  });

  // TODO 7
  testWidgets('Save hands back an entry with the trimmed text and the mood', (
    tester,
  ) async {
    Entry? saved;
    await openAddScreen(tester, onSave: (entry) => saved = entry);
    await tester.enterText(find.byType(TextFormField).first, '  Eid shopping ');
    await tester.enterText(find.byType(TextFormField).last, ' New shoes. ');
    await tester.tap(find.text('Sad'));
    await tester.pump();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(saved, isNotNull);
    expect(saved!.title, 'Eid shopping');
    expect(saved!.body, 'New shoes.');
    expect(saved!.mood, Mood.sad);
    // The entry's date is the moment Save was tapped.
    expect(DateTime.now().difference(saved!.date).inMinutes, 0);
  });

  testWidgets('Save closes the add screen', (tester) async {
    await openAddScreen(tester);
    await tester.enterText(find.byType(TextFormField).first, 'Eid shopping');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.byType(AddEntryScreen), findsNothing);
    expect(find.text('Open'), findsOneWidget);
  });

  testWidgets('Save with an empty title shows the error and stays open', (
    tester,
  ) async {
    var calls = 0;
    await openAddScreen(tester, onSave: (_) => calls++);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter a title.'), findsOneWidget);
    expect(find.byType(AddEntryScreen), findsOneWidget);
    expect(calls, 0);
  });
}
