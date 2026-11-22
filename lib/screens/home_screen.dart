import 'package:material_ui/material_ui.dart';

import '../entry.dart';
import '../entry_queries.dart';
import '../sample_entries.dart';
import '../widgets/entry_card.dart';

/// Step 3 of Roznamcha: the home screen, now with the diary's entries.
///
/// It greets the user, as in step 2, and shows the entries in a list that
/// the user can search and sort. A tap on an entry opens its detail screen,
/// and the + button opens the add screen.
///
/// It is a StatefulWidget now, because it has things to remember: the
/// entries, the search text and the chosen order.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.name});

  /// The name from the form, given to this screen by app_flow.dart.
  final String name;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // The state. `[...sampleEntries]` copies the sample data into a new list
  // that this screen owns and may add to (TODO 6 does).
  final List<Entry> _entries = [...sampleEntries];
  String _query = '';
  SortOrder _order = SortOrder.newestFirst;

  /// Opens the detail screen for [entry].
  void _openEntry(Entry entry) {
    // TODO 5: Push the detail screen on top of this one, and give it the
    // entry through its constructor: `Navigator.push(context, ...)` with a
    // `MaterialPageRoute<void>` whose `builder` returns
    // `EntryDetailScreen(entry: entry)`. `_openNameForm` in app_flow.dart
    // has the same shape. Import entry_detail_screen.dart.
  }

  /// Opens the add screen.
  void _openAddEntry() {
    // TODO 6: Push the add screen the same way. Its constructor takes a
    // callback, `onSave`: the add screen calls it with the new entry. Pass a
    // function that takes `(entry)` and adds it to `_entries` inside
    // `setState`, so the list builds again with the new entry in it. Import
    // add_entry_screen.dart.
  }

  /// Builds the part of the screen that shows the [visible] entries.
  Widget _buildList(List<Entry> visible) {
    // TODO 1: The starter shows only the first entry. Show them all: return
    // a `ListView.builder` instead. Give it `itemCount: visible.length`,
    // `padding: const EdgeInsets.only(bottom: 88)` (room for the + button),
    // and an `itemBuilder`: a function that takes `(context, index)` and
    // returns the EntryCard for `visible[index]`, built like the one below.
    final entry = visible.first;
    return Align(
      alignment: Alignment.topCenter,
      child: EntryCard(entry: entry, onTap: () => _openEntry(entry)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    // The list on the screen is not stored: every build computes it from the
    // state. Search first, then sort what is left. `_entries` itself never
    // changes order.
    final visible = sortEntries(searchEntries(_entries, _query), _order);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roznamcha'),
        // `actions` are the buttons at the end of the AppBar.
        actions: [
          // A button that opens a small menu. A tap on an item calls
          // `onSelected` with that item's `value`.
          PopupMenuButton<SortOrder>(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort',
            initialValue: _order,
            onSelected: (order) {
              setState(() {
                _order = order;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: SortOrder.newestFirst,
                child: Text('Newest first'),
              ),
              PopupMenuItem(
                value: SortOrder.oldestFirst,
                child: Text('Oldest first'),
              ),
              PopupMenuItem(
                value: SortOrder.titleAToZ,
                child: Text('Title A to Z'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              'Hi, ${widget.name}',
              style: text.headlineSmall?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // A plain TextField: nothing to validate, so no Form. `onChanged`
            // runs on every key press, so the list follows the typing.
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search your entries',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              // A tap anywhere else closes the keyboard.
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          // Expanded gives the list all the height that is left. A list that
          // scrolls needs to know its height.
          Expanded(
            child: visible.isEmpty
                ? Center(
                    child: Text(
                      'No entries match your search.',
                      style: text.bodyLarge?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  )
                : _buildList(visible),
          ),
        ],
      ),
      // The round button that floats over the list, bottom right.
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEntry,
        tooltip: 'Add an entry',
        child: const Icon(Icons.add),
      ),
    );
  }
}
