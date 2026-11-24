// Selected IDressy excerpt for review. Not a standalone compilable file.
// Original path: test/garment_undo_test.dart
// Surrounding unchanged code is omitted.

    await tester.pump(const Duration(seconds: 6));
  });

  for (final useOverrides in [false, true]) {
    testWidgets(
      'shared Save preserves ${useOverrides ? 'detail overrides' : 'existing defaults'} and supports Undo',
      (tester) async {
        const selectedImage = 'data:image/png;base64,AQID';
        await tester.pumpWidget(
          ProviderScope(
            overrides: [appDatabaseProvider.overrideWithValue(db)],
            child: MaterialApp(
              home: Scaffold(
                body: _Save(
                  imageUrl: useOverrides ? selectedImage : null,
                  title: useOverrides ? 'Selected dress' : null,
                  productUrl: useOverrides ? 'https://shop.example/resolved' : null,
                ),
              ),
            ),
          ),
        );
        Future<void> settle() async {
          for (var i = 0; i < 15; i++) {
            await tester.runAsync(
              () => Future<void>.delayed(const Duration(milliseconds: 20)),
            );
            await tester.pump(const Duration(milliseconds: 100));
          }
        }

        await settle();
        await tester.tap(find.text('Save'));
        await settle();
        final row = await tester.runAsync(
          () => db.select(db.garmentItems).getSingle(),
        );
        expect(row!.name, useOverrides ? 'Selected dress' : _product.title);
        expect(row.productId, _product.id);
        expect(row.productUrl,
            useOverrides ? 'https://shop.example/resolved' : _product.detailUrl);
        expect(row.category, 'top');
        expect(row.source, _product.source);
        final bytes = await tester.runAsync(
          () => File('${docs.path}/${row.imagePath}').readAsBytes(),
        );
        expect(bytes, useOverrides ? [1, 2, 3] : [0, 0, 0]);
        expect(find.text('Saved to Closet'), findsOneWidget);
        expect(find.text('Undo'), findsOneWidget);
        await tester.tap(find.text('Undo'));
        await settle();
        expect(await tester.runAsync(rows), isEmpty);
        expect(cloud.records, isEmpty);
        await tester.pump(const Duration(seconds: 6));
      },
    );
  }

  group('signed in', () {
    late ProviderContainer container;
    late GarmentsNotifier notifier;

// ... intervening unchanged code omitted ...


/// The Shop's Save button: reads the garments, saves with an Undo message.
class _Save extends ConsumerWidget {
  const _Save({this.imageUrl, this.title, this.productUrl});

  final String? imageUrl;
  final String? title;
  final String? productUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

// ... intervening unchanged code omitted ...

    return TextButton(
      onPressed: () => toggleSavedToCloset(
        context: context,
        product: imageUrl == null ? _product : _product.withImage(imageUrl!),
        category: 'top',
        title: title,
        productUrl: productUrl,
        messageAtTop: true,
      ),
      child: Text(saved ? 'Saved' : 'Save'),
