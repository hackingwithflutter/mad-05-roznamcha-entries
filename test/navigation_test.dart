import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:roznamcha/main.dart';
import 'package:roznamcha/screens/add_entry_screen.dart';
import 'package:roznamcha/screens/entry_detail_screen.dart';
import 'package:roznamcha/screens/home_screen.dart';

import 'phone.dart';

/// Starts the app and walks to the home screen: Get started, a name,
/// Continue.
Future<void> openHome(WidgetTester tester) async {
  await pumpOnPhone(tester, const RoznamchaApp());
  await tester.tap(find.text('Get started'));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextFormField), 'Ali');
  await tester.tap(find.text('Continue'));
  await tester.pumpAndSettle();
}

void main() {
  // TODO 5
  testWidgets('Tapping an entry opens the detail screen with that entry', (
    tester,
  ) async {
    await openHome(tester);
    await tester.tap(find.text('First day of the semester'));
    await tester.pumpAndSettle();
    expect(find.byType(EntryDetailScreen), findsOneWidget);
    expect(find.textContaining('the same long queue'), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('Back from the detail screen returns to the home screen', (
    tester,
  ) async {
    await openHome(tester);
    await tester.tap(find.text('First day of the semester'));
    await tester.pumpAndSettle();
    // Taps the back arrow that the AppBar added by itself.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(EntryDetailScreen), findsNothing);
  });

  // TODO 6
  testWidgets('The + button opens the add screen', (tester) async {
    await openHome(tester);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(AddEntryScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });

  // TODO 6 and TODO 7 (it also needs TODO 1 and TODO 4)
  testWidgets('A saved entry shows at the top of the list', (tester) async {
    await openHome(tester);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Eid shopping');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
    // The new entry has today's date, so newest first puts it at the top.
    final saved = find.text('Eid shopping');
    expect(saved, findsOneWidget);
    final rain = find.text('Rain in Lahore');
    expect(tester.getTopLeft(saved).dy, lessThan(tester.getTopLeft(rain).dy));
  });
}
