# Demo: safe AI diagnostics

This folder contains selected code changes and instructions only. It is not a runnable copy of IDressy.

## Same behavior, different diagnostics
Both implementations parse AI product-ranking output and return the existing fallback on malformed output. The before implementation prints the raw response and exception. The after implementation emits only `stylist.product_result_parse_failed` through a diagnostic callback, defaulting to the existing Dart logging facility. It retains successful parsing and the fallback.

## Assumed enterprise requirement
Do not log prompts, model responses, customer content or input-bearing exception messages. This is a fictional firm's policy for the teaching scenario, not an existing IDressy policy.

## Before
```dart
} catch (e) {
  print('AiRecommendationService parse error: $e\nRaw: $raw');
  return _fallbackProductsResult(productCount, query);
}
```

## After
```dart
} catch (_) {
  // Raw output and exception messages may both contain customer content.
  _diagnosticLog('stylist.product_result_parse_failed');
  return _fallbackProductsResult(productCount, query);
}
```

## Human review
Check that neither raw output nor exception text reaches the diagnostic sink, that an approved diagnostic remains, and that the fallback still returns the same user-facing result. Other logging paths remain outside this bounded change. No claim of application-wide compliance is made.

## Task prompt for rehearsal
Make product-result parse-failure diagnostics comply with the repository logging guidance. Preserve successful parsing and the current fallback behavior. Inspect the applicable instructions and propose a minimal change before editing.

## Verification status
Regression examples cover malformed JSON, incorrect field types, successful parsing and empty output, capturing the diagnostic callback and standard output with synthetic sensitive markers. The parser is exposed with @visibleForTesting to exercise the real parsing path without a live model.
Builds, formatting checks, analysis and tests have not been run, as requested. Treat this as an illustrative code change pending normal engineering validation.

## Comparison limits
This is current code versus an implementation guided by AGENTS.md and human direction. It is not an A/B experiment proving that the file alone caused the result, and the original code's authorship is not established.
