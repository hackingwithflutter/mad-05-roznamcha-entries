import 'package:material_ui/material_ui.dart';

import '../entry.dart';

/// One entry in the home screen's list: a Card with a ListTile inside.
///
/// Like week 4's buttons, it doesn't know what a tap does. It calls `onTap`,
/// and whoever built the card decides.
class EntryCard extends StatelessWidget {
  const EntryCard({super.key, required this.entry, required this.onTap});

  /// The entry this card shows.
  final Entry entry;

  /// Called when the user taps the card.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // A Card is a rounded surface that lifts its child off the background.
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      // Without this, the tap's ripple would paint over the rounded corners.
      clipBehavior: Clip.antiAlias,
      // A ListTile is a ready-made row: something at the start (`leading`),
      // a `title` with a `subtitle` under it, and something at the end
      // (`trailing`).
      child: ListTile(
        // TODO 2: Give the ListTile three more parameters, as on the design
        // sheet: `leading`, an Icon that shows `moodIcon(entry.mood)`;
        // `subtitle`, a Text with `formatDate(entry.date)`; and `trailing`,
        // a Text with `entry.mood.label`. `moodIcon` is in mood_icon.dart, in
        // this folder: import it.
        title: Text(entry.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        onTap: onTap,
      ),
    );
  }
}
