// Selected IDressy excerpt for review. Not a standalone compilable file.
// Original path: lib/src/features/tryon/ai_stylist_service.dart
// Surrounding unchanged code is omitted.

import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

// ... intervening unchanged code omitted ...

}

class AiStylistService {
  /// Whether this app run sends App Check tokens to Firebase AI Logic: set
  /// on the first chat, and turned off if a send fails because of App Check.
  static bool? _useAppCheck;

// ... intervening unchanged code omitted ...


    final raw = response.text?.trim() ?? '';
    print('AiRecommendationService: AI final response length=${raw.length}');
    return _parseProductsResult(raw, searchProductCount, searchQuery);
  }

  // -------------------------------------------------------------------------

// ... intervening unchanged code omitted ...

  // Parsing
  // -------------------------------------------------------------------------

  AiSessionResult _parseProductsResult(
    String raw,
    int productCount,
    String query,

// ... intervening unchanged code omitted ...

        overallMessage: overall,
        keywords: query,
      );
    } catch (e) {
      print('AiRecommendationService parse error: $e\nRaw: $raw');
      return _fallbackProductsResult(productCount, query);
    }
  }
