/// How the writer felt that day. An enum with data (week 2): each value
/// carries the label the app shows.
enum Mood {
  happy('Happy'),
  okay('Okay'),
  sad('Sad');

  const Mood(this.label);

  final String label;
}

/// One diary entry. Its fields are final: an entry doesn't change after it
/// is made.
class Entry {
  const Entry({
    required this.title,
    required this.body,
    required this.date,
    required this.mood,
  });

  final String title;
  final String body;
  final DateTime date;
  final Mood mood;
}

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Turns a date into text such as `20 Nov 2026`. `date.month` counts from 1,
/// and a list's indexes count from 0, so the month's name is at `month - 1`.
String formatDate(DateTime date) {
  return '${date.day} ${_months[date.month - 1]} ${date.year}';
}
