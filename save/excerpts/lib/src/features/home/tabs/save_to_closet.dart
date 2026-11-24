// Selected IDressy excerpt for review. Not a standalone compilable file.
// Original path: lib/src/features/home/tabs/save_to_closet.dart
// Surrounding unchanged code is omitted.

/// already there. A save shows "Saved to Closet" with an Undo action.
/// Returns whether the product is saved afterwards. [messageAtTop] shows
/// the message below the top bar, clear of content above the bottom bar.
Future<bool> toggleSavedToCloset({
  required BuildContext context,
  required ApparelProduct product,
  required String category,
  bool messageAtTop = false,
}) async {
  // The container outlives the calling widget, so Undo still works after

// ... intervening unchanged code omitted ...

  Future<void> toggle() => notifier.toggleGarment(
    productId: product.id,
    imageUrl: product.mainImage,
    title: product.title,
    category: category,
    productUrl: product.detailUrl,
    source: product.source,
  );

