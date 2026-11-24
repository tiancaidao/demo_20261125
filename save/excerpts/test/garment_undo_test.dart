// Selected IDressy excerpt for review. Not a standalone compilable file.
// Original path: test/garment_undo_test.dart
// Surrounding unchanged code is omitted.

    await tester.pump(const Duration(seconds: 6));
  });

  group('signed in', () {
    late ProviderContainer container;
    late GarmentsNotifier notifier;

// ... intervening unchanged code omitted ...


/// The Shop's Save button: reads the garments, saves with an Undo message.
class _Save extends ConsumerWidget {
  const _Save();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

// ... intervening unchanged code omitted ...

    return TextButton(
      onPressed: () => toggleSavedToCloset(
        context: context,
        product: _product,
        category: 'top',
        messageAtTop: true,
      ),
      child: Text(saved ? 'Saved' : 'Save'),
