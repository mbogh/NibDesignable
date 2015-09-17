//
//  ProfileAvatarView.swift
//  NibDesignableDemo
//
//  Copyright (c) 2014 Morten Bøgh
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

public class ProfileAvatarView: NibDesignable {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    @IBInspectable public var name: String = "" {
        didSet {
            self.nameLabel.text = name
        }
    }

    @IBInspectable public var profileImage: UIImage = UIImage() {
        didSet {
            let size = self.profileImage.size
            let rect = CGRectMake(0, 0, size.width, size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            let path = UIBezierPath(ovalInRect: rect)
            path.addClip()
            self.profileImage.drawInRect(rect)

            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.profileImageView.image = image
        }
    }

    // MARK: Interface Builder
    override public func prepareForInterfaceBuilder() {
        if self.name.utf8.count == 0 {
            self.name = "John Appleseed"
        }

        if self.profileImage.size == CGSizeZero {
            let bundle = NSBundle(forClass: self.dynamicType)
            self.profileImage = UIImage(named: "Donkey", inBundle: bundle, compatibleWithTraitCollection: nil)!
        }
    }
}
