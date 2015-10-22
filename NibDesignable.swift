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

extension UIView {

    // MARK: - Nib loading

    /**
    Called to load the nib in setupNib().
    
    - returns: UIView instance loaded from a nib file.
    */
    public func loadNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: self.nibName(), bundle: bundle)
        return nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    }
    
    /**
    Called in the default implementation of loadNib(). Default is class name.
    
    - returns: Name of a single view nib file.
    */
    public func nibName() -> String {
        return self.dynamicType.description().componentsSeparatedByString(".").last!
    }
}

@IBDesignable
public class NibDesignable: UIView {

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }

    // MARK: - Nib loading

    /**
        Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
    */
    private func setupNib() {
        let view = self.loadNib()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
    }
    
    override public func willMoveToSuperview(newSuperview: UIView?) {
        layoutIfNeeded()
    }
}

@IBDesignable
public class NibDesignableTableViewCell: UITableViewCell {
    
    // MARK: - Initializer
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupNib()
    }
    
    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
    
    // MARK: - Nib loading
    
    /**
        Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
    */
    private func setupNib() {
        let view = self.loadNib()
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
    }
}

@IBDesignable
public class NibDesignableControl: UIControl {

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }

    // MARK: - Nib loading

    /**
    Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
    */
    private func setupNib() {
        let view = self.loadNib()
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
    }
}

@IBDesignable
public class NibDesignableCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }
    
    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
    
    // MARK: - Nib loading
    
    /**
    Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
    */
    private func setupNib() {
        let view = self.loadNib()
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
    }
}
