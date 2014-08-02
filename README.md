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

2. Either override `loadNib() -> NibDesignable` or `nibName() -> String` like
  ``` swift
  override func loadNib() -> NibDesignable {
    let bundle = NSBundle(...)
    return bundle.loadNibNamed("CustomView", owner: nil, options: nil)[2] as NibDesignable
  }
  ```
  or
  ``` swift
  override func nibName() -> String {
    return "CustomView"
  }
  ```
3. Create a nib, place a `UIView` and change the class to `CustomView`
4. Design your view and add `@IBInspectable` properties.

**NB** Access to outlets must be done through `self.proxyView` and for now I recommend that you implement this in your subclass. This is to avoid unwrapping the optional property `proxyView` and casting everytime you want to access an outlet.
``` swift
private func proxyView() -> CustomView {
  return self.proxyView! as CustomView
}
```

## Thanks

Donkey.jpg - [cobalt123 - Baby Burro in Oatman, Arizona](https://flic.kr/p/Gk2KR) licensed under [CC BY-NC-SA 2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/)

## Contact

Follow me on Twitter ([@mbogh](https://twitter.com/mbogh)) and/or visit my blog [Just a Beech](http://justabeech.com)

## License

Nib Designable is released under an MIT license. See LICENSE for more information.

## Release Notes

Version 1.0

- Initial release
