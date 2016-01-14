[![Build Status](https://travis-ci.org/mbogh/NibDesignable.svg?branch=master)](https://travis-ci.org/mbogh/NibDesignable) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 
[![Pod version](http://img.shields.io/cocoapods/v/NibDesignable.svg)](http://cocoadocs.org/docsets/NibDesignable/) 
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/mbogh/NibDesignable/master/LICENSE)

Nib Designable
=============

## Installation

### CocoaPods
Add `pod 'NibDesignable'` to your `Podfile`

### Carthage
Add `github "mbogh/NibDesignable"` to your `Cartfile`.

### Manual
Simply drop `NibDesignable.swift` into your project and it is ready to use.

## Usage

1. Create a new class that subclass' `NibDesignable` like
  ``` swift
  class CustomView: NibDesignable {

  }
  ```
2. Create a nib, place a `UIView` and change the `File's Owner` to `CustomView`
3. Design your view and add `@IBInspectable` properties.
4. Sometimes Xcode/Interface Builder does not recognize `NibDesignable` as `@IBDesignable`. **Workaround** Declare your custom class as `@IBDesignable` like:
  ``` swift
  @IBDesignable
  class CustomView: NibDesignable {

  }
  ```

## Thanks

- Donkey.jpg - [cobalt123 - Baby Burro in Oatman, Arizona](https://flic.kr/p/Gk2KR) licensed under [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/)
- [klngarthur](http://www.reddit.com/user/klngarthur)

## Contact

Follow me on Twitter ([@mbogh](https://twitter.com/mbogh)) and/or visit my blog [Just a Beech](http://justabeech.com)

## License

Nib Designable is released under an MIT license. See LICENSE for more information.

## Release Notes

Version 2.3.0

- `UICollectionReusableView` support added by @ikesyo

Version 2.2.0

- `UICollectionViewCell` support added by @pyankoff

Version 2.1.0

- `UIControl` support added by @illaz

Version 2.0.0

- Swift 2.0 for everyone, thanks to @bjarkehs

Version 1.1.1

- Fixed minor issue with `UITableViewCell`

Version 1.1.0

- Added support for `UITableViewCell`s, thanks to @duemunk

Version 1.0.4

- Swift 1.2 support, thanks to @ikesyo

Version 1.0.3

- Switched to Auto Layout in `setupNib()`. This fixes issues when views have size of `{0,0}` initially.

Version 1.0.2

- CocoaPods support

Version 1.0.1

- proxyView is passe.
- `nibName()` returns class name per default.

Version 1.0.0

- Initial release
