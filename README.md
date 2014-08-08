Nib Designable
=============

## Installation

Simply drop `NibDesignable.swift` into your project and it is ready to use.

## Usage

1. Create a new class that subclass' `NibDesignable` like
  ``` swift
  class CustomView: NibDesignable {
  
  }
  ```
2. Create a nib, place a `UIView` and change the `File's Owner` to `CustomView`
3. Design your view and add `@IBInspectable` properties.

## Thanks

- Donkey.jpg - [cobalt123 - Baby Burro in Oatman, Arizona](https://flic.kr/p/Gk2KR) licensed under [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/)
- [klngarthur](http://www.reddit.com/user/klngarthur)

## Contact

Follow me on Twitter ([@mbogh](https://twitter.com/mbogh)) and/or visit my blog [Just a Beech](http://justabeech.com)

## License

Nib Designable is released under an MIT license. See LICENSE for more information.

## Release Notes

Version 1.1

- proxyView is passe.
- `nibName()` returns class name per default.

Version 1.0

- Initial release
