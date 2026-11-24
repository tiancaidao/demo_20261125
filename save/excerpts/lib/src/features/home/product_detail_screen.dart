// Selected IDressy excerpt for review. Not a standalone compilable file.
// Original path: lib/src/features/home/product_detail_screen.dart
// Surrounding unchanged code is omitted.

import 'package:go_router/go_router.dart';
import '../../app/routes.dart';
import 'apparel_models.dart';
import 'tabs/save_to_closet.dart';
import 'unified_search_provider.dart';
import '../garments/garments_provider.dart';
import '../../core/data/cloud_store.dart';

// ... intervening unchanged code omitted ...

  void _toggleSaved() {
    if (widget.product != null) {
      final category = TryOnUtil.inferCategory(widget.title);
      toggleSavedToCloset(
        context: context,
        product: widget.product!.withImage(_shownImage),
        category: category,
        title: widget.title,
        productUrl: _productUrl,
        messageAtTop: true,
      );
      ref
          .read(analyticsServiceProvider)
          .logAddToGarments(
