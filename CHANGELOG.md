# Change Log
All notable changes to this project will be documented in this file. This change log follows the conventions of [keepachangelog.com](http://keepachangelog.com/).

## [Unreleased][unreleased]
### Added
- `:working_day` generator can now optionally take a `holidays: []` array for additional non-working days.

### Changed
- Generators are configured with `direction` and not `choose`.

### Fixed
- The date format error message now contains the correct spelling of "ambiguous".

## [0.2.0][0.2.0] - 2016-06-23
### Changed (breaking changes)
- Lowest supported Ruby version is now 2.2.2.
- `then_find_first` is now called `then_find_upcoming`. This clarifies the lookup is being done forward in time.
- `then_find_latest` is now called `then_find_preceding`. This clarifies the lookup is being done backward in time.

## [0.1.0][0.1.0] - 2014-06-26
### Added
- Usage instructions appeared in the readme.
- Support for chaining generators. Combining generators can achieve complex lookup use cases.
  Eg. find the last days of the months and then find the first upcoming working day.
- Support for chaining generators backwards in time.
  Eg. find the last day of the month and find the latest preceding working day.

### Removed
- Next day generator. It was only a proof of concept.

## [0.0.1][0.0.1] - 2014-06-15
### Added
- Date sequence factory: generates eligible dates in an infinite lazy sequence using a "generator".
  Only supports generating upcoming events (no backtracking).
- Next day generator (as a proof of concept).
- Working day generator.

[unreleased]: https://github.com/sldblog/upcoming/compare/0.2.0...master
[0.2.0]: https://github.com/sldblog/upcoming/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/sldblog/upcoming/compare/0.0.1...0.1.0
[0.0.1]: https://github.com/sldblog/upcoming/compare/22b54632cc3309732ffea1c9a0ac8ed8ba61153e...0.0.1
