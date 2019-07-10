# Changelog
## [1.3.0]
### Added
- `Player` class
- `getClub` and `getBattleLog` methods under player class

### Changed
- `getPlayer` now returns a `Player` object
- All methods that are supposed to return a hash now actually return one, instead of `HTTParty::Response`

## [1.2.1]
### Added
- Actual region code checking

### Changed
- Moved validation functions to one file ([validation.rb](../master/lib/brawlstars/tag.rb))
- Fixed changelog link in gemspec

### Removed
- Removed tag.rb and region.rb (see above)

## [1.2.0]
### Added
- Add player battle log endpoint
- Add region parameter to top player/club leaderboards
- Add RegionError

## [1.1.0]
### Added
- Custom Error Types

## [1.0.0]
Initial version

[1.3.0]: https://github.com/Karthik99999/brawlstarsrb/tree/v1.3.0
[1.2.1]: https://github.com/Karthik99999/brawlstarsrb/tree/v1.2.1
[1.2.0]: https://github.com/Karthik99999/brawlstarsrb/tree/v1.2.0
[1.1.0]: https://github.com/Karthik99999/brawlstarsrb/tree/v1.1.0
[1.0.0]: https://github.com/Karthik99999/brawlstarsrb/tree/v1.0.0
