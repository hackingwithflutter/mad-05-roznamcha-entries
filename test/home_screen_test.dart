import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:roznamcha/screens/home_screen.dart';
import 'package:roznamcha/widgets/entry_card.dart';

import 'phone.dart';

/// Builds the home screen alone, on the phone-sized screen.
Future<void> pumpHome(WidgetTester tester) async {
  await pumpOnPhone(tester, const MaterialApp(home: HomeScreen(name: 'Ali')));
}

/// True when the widget [above] finds is higher on the screen than [below].
bool isAbove(WidgetTester tester, Finder above, Finder below) {
  return tester.getTopLeft(above).dy < tester.getTopLeft(below).dy;
}

void main() {
  // These three tests pass before and after the TODOs: they check given code.
  // The first two are week 4's.
  testWidgets('The home screen greets the user by name', (tester) async {
    await pumpHome(tester);
    expect(find.text('Hi, Ali'), findsOneWidget);
  });

  testWidgets('Nothing overflows on the home screen', (tester) async {
    await pumpOnPhone(
      tester,
      const MaterialApp(home: HomeScreen(name: 'Fatima Noor')),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('The home screen has a search field, a sort button and a +', (
    tester,
  ) async {
    await pumpHome(tester);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.sort), findsOneWidget);
    expect(
      find.widgetWithIcon(FloatingActionButton, Icons.add),
      findsOneWidget,
    );
  });

  // TODO 1
  testWidgets('The entries are in a ListView.builder, one item per entry', (
    tester,
  ) async {
    await pumpHome(tester);
    expect(find.byType(ListView), findsOneWidget);
    final list = tester.widget<ListView>(find.byType(ListView));
    // ListView.builder keeps a builder function, not a list of children.
    expect(list.childrenDelegate, isA<SliverChildBuilderDelegate>());
    expect(list.childrenDelegate.estimatedChildCount, 8);
    expect(find.byType(EntryCard), findsAtLeastNWidgets(2));
  });

  testWidgets('On a short screen the list scrolls', (tester) async {
    // 360 x 500: shorter than the phone, so the list can't show every entry.
    tester.view.physicalSize = const Size(1080, 1500);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: HomeScreen(name: 'Ali')));
    final top = tester.widget<EntryCard>(find.byType(EntryCard).first).entry;
    expect(find.text(top.title), findsOneWidget);
    // Drag the list up by more than one card: the top entry leaves the screen.
    await tester.drag(find.byType(ListView), const Offset(0, -100));
    await tester.pump();
    expect(find.text(top.title), findsNothing);
    expect(tester.takeException(), isNull);
  });

  // TODO 3 (it also needs TODO 1)
  testWidgets('Typing in the search field shows only the matching entries', (
    tester,
  ) async {
    await pumpHome(tester);
    await tester.enterText(find.byType(TextField), 'chai');
    await tester.pump();
    expect(find.text('Chai with Zain'), findsOneWidget);
    expect(find.text('Too much chai'), findsOneWidget);
    expect(find.byType(EntryCard), findsNWidgets(2));
  });

  // TODO 3
  testWidgets('A search with no match shows a message', (tester) async {
    await pumpHome(tester);
    await tester.enterText(find.byType(TextField), 'zebra');
    await tester.pump();
    expect(find.text('No entries match your search.'), findsOneWidget);
    expect(find.byType(EntryCard), findsNothing);
  });

  // TODO 4 (it also needs TODO 1)
  testWidgets('The list starts with the newest entry at the top', (
    tester,
  ) async {
    await pumpHome(tester);
    final newest = find.text('Rain in Lahore');
    final older = find.text('Quiz went badly');
    expect(isAbove(tester, newest, older), isTrue);
  });

  testWidgets('Choosing Title A to Z in the sort menu sorts the list', (
    tester,
  ) async {
    await pumpHome(tester);
    await tester.tap(find.byIcon(Icons.sort));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Title A to Z'));
    await tester.pumpAndSettle();
    final first = find.text('Biryani on Sunday');
    final second = find.text('Chai with Zain');
    expect(isAbove(tester, first, second), isTrue);
    expect(tester.getTopLeft(first).dy, lessThan(250));
  });
}
