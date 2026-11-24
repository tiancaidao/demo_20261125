// Selected IDressy excerpt for review. Not a standalone compilable file.
// Original path: test/tryon/ai_stylist_logging_test.dart
// Surrounding unchanged code is omitted.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:IDressy/src/features/tryon/ai_stylist_service.dart';
import 'package:IDressy/src/l10n/l10n.dart';

void main() {
  const secret = 'SYNTHETIC_CUSTOMER_CONTENT_7391';
  late List<String> diagnostics;
  late List<String> standardOutput;
  late AiStylistService service;

  setUp(() {
    diagnostics = [];
    standardOutput = [];
    service = AiStylistService(diagnosticLog: diagnostics.add);
  });

  AiProductsResult parse(String raw) => runZoned(
    () => service.parseProductsResult(raw, 2, secret) as AiProductsResult,
    zoneSpecification: ZoneSpecification(
      print: (_, _, _, line) => standardOutput.add(line),
    ),
  );

  for (final raw in [
    '{"overall":"$secret", malformed',
    '{"ranked":"$secret","overall":"private response"}',
  ]) {
    test('parse failures emit only approved diagnostics (${raw.length} chars)', () {
      final result = parse(raw);

      expect(diagnostics, ['stylist.product_result_parse_failed']);
      expect(standardOutput, isEmpty);
      expect([...diagnostics, ...standardOutput].join(), isNot(contains(secret)));
      expect(result.keywords, secret);
      expect(result.ranked.map((r) => r.originalIndex), [0, 1]);
      expect(result.ranked.every(
        (r) => r.explanation == currentL10n().stylistOptionForLook,
      ), isTrue);
      expect(result.overallMessage, currentL10n().stylistGreatPicksFallback);
    });
  }

  test('valid response preserves ranking and emits no diagnostics', () {
    final result = parse(
      '{"ranked":[{"index":1,"explanation":"$secret"}],'
      '"overall":"private response"}',
    );
    expect(result.ranked.map((r) => r.originalIndex), [1, 0]);
    expect(result.ranked.first.explanation, secret);
    expect(result.overallMessage, 'private response');
    expect(result.keywords, secret);
    expect(diagnostics, isEmpty);
    expect(standardOutput, isEmpty);
  });

  test('empty response retains quiet fallback', () {
    final result = parse('');
    expect(result.ranked.map((r) => r.originalIndex), [0, 1]);
    expect(result.overallMessage, currentL10n().stylistGreatPicksFallback);
    expect(diagnostics, isEmpty);
    expect(standardOutput, isEmpty);
  });
}
