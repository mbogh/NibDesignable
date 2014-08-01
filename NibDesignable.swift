//
//  NibDesignable.swift
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

@IBDesignable
public class NibDesignable: UIView {
    /// View instantiated from the nib. All actions and outlets are/should be connected to this.
    public weak var proxyView: NibDesignable?

    // MARK: - Initializer
    init(frame: CGRect) {
        super.init(frame: frame)
        var view = self.loadNib()
        view.frame = self.bounds
        view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.proxyView = view
        self.addSubview(self.proxyView)
    }

    // MARK: - NSCoding
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override public func awakeAfterUsingCoder(aDecoder: NSCoder!) -> AnyObject! {
        if self.subviews.count == 0 {
            var view = self.loadNib()
            view.setTranslatesAutoresizingMaskIntoConstraints(false)
            let contraints = self.constraints()
            self.removeConstraints(contraints)
            view.addConstraints(contraints)
            view.proxyView = view
            return view
        }
        return self
    }

    // MARK: - Nib loading

    /**
        Called to load the nib in init(frame:) and awakeAfterUsingCoder(aDecoder:).

        :returns: NibDesignable instance loaded from a nib file.
    */
    public func loadNib() -> NibDesignable {
        let bundle = NSBundle(forClass: self.dynamicType)
        return bundle.loadNibNamed(self.nibName(), owner: nil, options: nil)[0] as NibDesignable
    }

    /**
        Called in the default implementation of loadNib()

        :returns: Name of a single view nib file.
    */
    public func nibName() -> String {
        return ""
    }
}