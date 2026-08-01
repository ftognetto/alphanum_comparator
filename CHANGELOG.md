## [0.0.1] - 2020-05-30
* Initial commit

## [1.0.0] - 2020-06-01
* Added example

## [1.0.1] - 2020-06-01
* Added description

## [2.0.0] - 2021-03-05
* Migrated to null safety

## [2.0.1] - 2021-09-07
* Removed flutter dependency

## [2.0.2] - 2022-06-29
* Added compareNumFirst method

## [2.0.3] - 2025-03-06
* Upgrade dart version
* dart pub upgrade
* Changed _getChunk method

## [3.0.0] - 2026-08-01
* **Breaking change**: numeric chunks containing a decimal separator (`.` or `,`) are now compared by their actual numeric value instead of digit-by-digit. For example "1.2" is now sorted after "1.10" (1.2 = 1.20 > 1.10), instead of before it as in previous versions.
* Decimal numbers are recognized both when isolated and when embedded in more complex strings (e.g. "file_v1.10_final").
* Plain integer chunks without a decimal separator keep the previous comparison behaviour, so no regression for existing alphanumeric sorting.