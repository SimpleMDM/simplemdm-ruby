# Change Log

## [0.2.0] - 2016-07-01
### Removed
- API no longer allows the enterprise app name to be specified. The name is automatically set to that which is specified in the app binary.

### Fixed
- App 'version' attribute is now properly updated after uploading an updated binary file.

## [0.2.0] - 2016-05-03
### Added
- Add and remove devices from app groups.

### Fixed
- Gem properly declares 'Hashie' gem dependency now.

## [0.1.0] - 2015-10-20
- Initial release

## [1.1.3] - 2016-9-29
### Fixed
- New App objects failed to save when 'binary' was declared as an initialization argument.
- App objects were not able to update their 'name' attribute.