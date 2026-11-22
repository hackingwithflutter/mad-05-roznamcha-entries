import 'package:material_ui/material_ui.dart';

import '../entry.dart';
import '../widgets/mood_icon.dart';

/// Step 3 of Roznamcha: the detail screen, which shows one whole entry.
///
/// The entry arrives through the constructor: the home screen builds this
/// screen with the entry the user tapped. That is how data goes forward
/// from one screen to the next.
class EntryDetailScreen extends StatelessWidget {
  const EntryDetailScreen({super.key, required this.entry});

  /// The entry to show, given by the screen that opened this one.
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      // No back button is written here. The AppBar adds one by itself when
      // there is a screen under this one on the Navigator's stack.
      appBar: AppBar(title: const Text('Entry')),
      // A long entry can be taller than the screen, so the body scrolls.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.title,
              style: text.headlineSmall?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  moodIcon(entry.mood),
                  size: 20,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  '${entry.mood.label}, ${formatDate(entry.date)}',
                  style: text.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(entry.body, style: text.bodyLarge),
          ],
        ),
      ),
    );
  }
}
