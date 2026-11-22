# Roznamcha: week 5 starter (step 3)

This is Roznamcha, the course app of Mobile Application Development. You build it one step a week from week 3 to week 15, in this repo. This week is step 3: the diary's entries in a list that you can search and sort, a detail screen and an add screen.

This project needs Flutter 3.50.0 or newer.

## Get this week's files

Choose one of the two paths. The handout explains both, step by step.

**Continue.** You already have a `roznamcha` repo, and its week 4 tests pass. Commit your work first. Then open a terminal in your repo's folder and run these commands, one at a time:

```bash
git remote add week5 https://github.com/hackingwithflutter/mad-05-roznamcha-entries.git
git fetch week5
git checkout week5/main -- .
git commit -m "Week 5: add the step 3 starter"
```

The template's version of every file replaces yours. Files that only you have, such as `screenshot.png`, stay.

**Restart.** You have no working `roznamcha` repo. Make a new `roznamcha` repo from this template, as the handout says.

## How to run

1. Connect your Android phone to your laptop with a USB cable. USB debugging must be on.
2. Open a terminal in this folder and run these two commands:

   ```bash
   flutter pub get
   flutter run
   ```

The first build takes several minutes. The untouched starter goes from the welcome screen to the name form to the home screen. The home screen shows one entry only, and a tap on it or on the + button does nothing yet.

## Your tasks

Read `lib/app_flow.dart`, `lib/entry.dart`, `lib/sample_entries.dart`, `lib/entry_queries.dart`, `lib/widgets/entry_card.dart`, `lib/screens/home_screen.dart`, `lib/screens/entry_detail_screen.dart` and `lib/screens/add_entry_screen.dart` first, in that order; the comments explain the given code. Then do TODO 1 in `home_screen.dart`, TODO 2 in `entry_card.dart`, TODO 3 and 4 in `entry_queries.dart`, TODO 5 and 6 in `home_screen.dart` and TODO 7 in `add_entry_screen.dart`. The handout explains each, and shows the design.

## Tests

Run the tests with this command:

```bash
flutter test
```

There are 52 tests in nine files. On the untouched starter, 31 pass and 21 fail. The 31 that pass check given code, the screens of weeks 3 and 4 among it. The failing tests are expected. GitHub Actions runs the same tests on every push, so it shows a red cross until you finish. When all seven TODOs are done, the last line says `All tests passed!`

## My screenshot

![The home screen with my entries on my phone](screenshot.png)

Replace this picture with your own. Add one entry of your own in the app, take a screenshot of the home screen with that entry at the top of the list on your phone, name it `screenshot.png`, and put it in the top folder of this repository, next to this README.

## AI log

From this week, AI may write code with you (AI Level 2), and you keep a log of how you used it. The log is the file `AI_LOG.md`, next to this README. The handout says what goes in it.

## Next weeks

Keep this repo. Each handout tells you how to add that week's starter files to it, the same way.
