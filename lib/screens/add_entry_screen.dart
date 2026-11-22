import 'package:material_ui/material_ui.dart';

import '../entry.dart';
import '../widgets/mood_icon.dart';

/// Step 3 of Roznamcha: the add screen, a form for a new entry.
///
/// It is week 4's form pattern again: a Form with a key, one controller per
/// field, a validator, and a callback for the result. The new part is how it
/// ends: it hands the entry back through `onSave`, then closes itself.
class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key, required this.onSave});

  /// Called with the new entry when the user taps Save and the title is
  /// fine. That is how data goes back to the screen that opened this one.
  final ValueChanged<Entry> onSave;

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  // The mood the user picked. Happy until they pick another.
  Mood _mood = Mood.happy;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    final title = value?.trim() ?? '';
    if (title.isEmpty) {
      return 'Please enter a title.';
    }
    return null;
  }

  /// Runs when the user taps Save.
  void _save() {
    // TODO 7: If the form validates (as `_submit` does in
    // name_form_screen.dart), make an `Entry` from the trimmed text of the
    // two controllers, `DateTime.now()` as its date, and `_mood`. Hand it
    // back with `widget.onSave(...)`. Then close this screen with
    // `Navigator.pop(context)`.
  }

  /// One mood the user can pick. The chip for the picked mood is filled.
  Widget _moodChip(Mood mood) {
    return ChoiceChip(
      avatar: Icon(moodIcon(mood), size: 18),
      label: Text(mood.label),
      showCheckmark: false,
      selected: _mood == mood,
      onSelected: (_) {
        setState(() {
          _mood = mood;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('New entry')),
      body: Form(
        key: _formKey,
        // A plain ListView with a few children, not ListView.builder: the
        // form is short, but it must scroll when the keyboard covers it.
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              validator: _validateTitle,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'What happened today?',
                // Keep the label at the top of a tall field.
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            Text('Mood', style: text.titleSmall),
            const SizedBox(height: 8),
            // A Wrap is a Row that moves to a new line when it runs out of
            // width.
            Wrap(
              spacing: 8,
              children: [
                _moodChip(Mood.happy),
                _moodChip(Mood.okay),
                _moodChip(Mood.sad),
              ],
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _save, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
