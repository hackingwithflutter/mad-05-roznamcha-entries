import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:roznamcha/main.dart';
import 'package:roznamcha/screens/home_screen.dart';
import 'package:roznamcha/screens/name_form_screen.dart';
import 'package:roznamcha/screens/welcome_screen.dart';

import 'phone.dart';

void main() {
  // Week 4's three tests, and one new one. All four pass: the flow is given
  // code now. The name form is a route on the Navigator, so each test waits
  // for the screen's animation to finish with pumpAndSettle.
  testWidgets('Tapping Get started opens the name form', (tester) async {
    await pumpOnPhone(tester, const RoznamchaApp());
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    expect(find.byType(NameFormScreen), findsOneWidget);
    expect(find.byType(WelcomeScreen), findsNothing);
  });

  testWidgets(
    'Submitting an empty name shows the error and stays on the form',
    (tester) async {
      await pumpOnPhone(tester, const RoznamchaApp());
      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter your name.'), findsOneWidget);
      expect(find.byType(NameFormScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    },
  );

  testWidgets('Submitting a name opens the home screen with the greeting', (
    tester,
  ) async {
    await pumpOnPhone(tester, const RoznamchaApp());
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Ali');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Hi, Ali'), findsOneWidget);
    expect(find.byType(NameFormScreen), findsNothing);
  });

  // New in week 5: the form is on the Navigator's stack, so back closes it.
  testWidgets(
    'The back button on the name form returns to the welcome screen',
    (tester) async {
      await pumpOnPhone(tester, const RoznamchaApp());
      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();
      // The same as the phone's back button or back gesture.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.byType(NameFormScreen), findsNothing);
    },
  );
}
