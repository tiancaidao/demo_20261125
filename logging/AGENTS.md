# IDressy demo engineering instructions

## Assumed enterprise logging policy
This policy belongs to the fictional enterprise in the enablement demo. It is
not a claim about an existing IDressy firm policy.

- Never log raw model prompts, responses, search queries, or customer content.
- Exception messages and stack traces can contain input. Do not forward them in the product-result parser's diagnostics.
- For product-result parsing failures, emit only the approved event `stylist.product_result_parse_failed`, with no dynamic payload.
- Preserve the existing fallback result and successful parsing behavior.
- Keep this change limited to product-result parsing. Other logging paths need a separate review.
- Do not add dependencies or call live AI services for verification.

## Verification
- Test malformed JSON and invalid response field types using synthetic sensitive markers.
- Capture diagnostics and standard output. Verify only the approved event appears.
- Check valid and empty responses and preserve fallback behavior.
- Run `flutter test test/tryon/ai_stylist_logging_test.dart test/tryon/ai_stylist_app_check_test.dart`.
- Analyze changed Dart files, review the diff, and report actual results and limitations.
