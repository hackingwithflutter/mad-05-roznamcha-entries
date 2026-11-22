import 'entry.dart';

/// The orders the home screen can show the entries in.
enum SortOrder { newestFirst, oldestFirst, titleAToZ }

/// Returns the entries whose title contains [query].
///
/// Upper and lower case don't matter: `chai` finds `Chai with Zain`. Spaces
/// at both ends of [query] don't matter either. An empty [query] keeps every
/// entry.
List<Entry> searchEntries(List<Entry> entries, String query) {
  // TODO 3: Search the list. Trim `query` and make it lower case. Then
  // return a new list with only the entries whose title, in lower case,
  // contains it: `where` keeps the items that pass a test, `contains` is the
  // test, and `toList` makes the list. Replace the `return` line below.
  return entries;
}

/// Returns a new list with the same entries in the given [order].
///
/// The list it was given stays as it is.
List<Entry> sortEntries(List<Entry> entries, SortOrder order) {
  // TODO 4: Sort a copy. `sort` changes the list it is called on, so copy
  // `entries` into a new list first (`[...entries]`) and sort the copy. Give
  // `sort` a function that compares two entries, `a` and `b`, with
  // `compareTo`: by `date` for the two date orders (newest first compares
  // `b` with `a`), and by `title` in lower case for `titleAToZ`. A `switch`
  // on `order` needs a case for each of the three values. Return the copy.
  // Replace the `return` line below.
  return entries;
}
