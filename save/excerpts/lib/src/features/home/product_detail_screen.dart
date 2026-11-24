// Selected IDressy excerpt for review. Not a standalone compilable file.
// Original path: lib/src/features/home/product_detail_screen.dart
// Surrounding unchanged code is omitted.

import 'package:go_router/go_router.dart';
import '../../app/routes.dart';
import 'apparel_models.dart';
import 'unified_search_provider.dart';
import '../garments/garments_provider.dart';
import '../../core/data/cloud_store.dart';

// ... intervening unchanged code omitted ...

  void _toggleSaved() {
    if (widget.product != null) {
      final category = TryOnUtil.inferCategory(widget.title);
      ref
          .read(garmentsProvider.notifier)
          .toggleGarment(
            productId: widget.product!.id.toString(),
            imageUrl: _shownImage,
            title: widget.title,
            category: category,
            productUrl: _productUrl,
            source: widget.product!.source,
          );
      ref
          .read(analyticsServiceProvider)
          .logAddToGarments(
