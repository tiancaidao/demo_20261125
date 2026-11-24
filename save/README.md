# Demo: shared Save behavior

This folder contains selected code changes and instructions only. It is not a runnable copy of IDressy.

## Same task
Add the existing Save confirmation and Undo experience to product details. Preserve the selected image and product metadata. The prompt describes the feature. AGENTS.md provides the reusable requirement to search for related code and make the smallest compatible change.

## Before
`ProductDetailScreen._toggleSaved` calls `toggleGarment` directly. The feed calls `toggleSavedToCloset`, which supplies localized confirmation and Undo. The shared helper takes its image, title and URL from the original product card.

## After
The screen uses the shared helper. The existing ApparelProduct.withImage helper preserves the selected image. Optional title/URL overrides preserve metadata resolved by the details screen. Existing callers retain their defaults. Provider persistence, localized notification and Undo remain in the existing implementation. Analytics remains in the screen.

## Human review moment
Blindly reusing the helper would save product.mainImage rather than the image selected in details, and could lose a resolved URL or updated title. Review reuse of withImage, the two metadata overrides, and the defaults, not just the reduction in duplicated code.

## Evidence
Run `flutter test test/garment_undo_test.dart test/home/product_detail_card_test.dart`.
The added tests check stored image bytes, metadata, localized confirmation and Undo for both overridden values and unchanged defaults. They exercise the real helper/provider with an in-memory database and fake cloud. They do not drive the entire product-details screen or verify analytics delivery.
Inspect the call site and run the app with synthetic products to validate the full screen.

## Recording
Show prepared AGENTS.md, then the task, implementation diff, test output and your review. Label any prepared results. Retain human review and release approval.

## Verification status
Builds, analysis and tests have not been run, as requested. The locally available SDK is older than this project requires. An initial formatter attempt used that older SDK and could not parse the existing modern Dart syntax. Final code formatting was adjusted manually. Regression tests are examples pending normal validation.

## Reusable rule, specific application
The guidance does not name Save, Undo, or a target helper. It asks Codex to discover existing implementations and model transformations. In this case those are toggleSavedToCloset and ApparelProduct.withImage. Reusing withImage avoids adding a duplicate image override to the shared helper. Only the necessary title and URL overrides remain. This is a prepared implementation reviewed against the rule, not a fresh independent experiment measuring its causal effect.
