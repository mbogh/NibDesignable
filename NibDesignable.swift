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

public protocol NibDesignableProtocol: NSObjectProtocol {

    /**
     Called to load the nib in setupNib().

     - returns: UIView instance loaded from a nib file.
     */
    func loadNib() -> UIView
    /**
     Called in the default implementation of loadNib(). Default is class name.

     - returns: Name of a single view nib file.
     */
    func nibName() -> String
}

extension NibDesignableProtocol {
    // MARK: - Nib loading

    /**
     Called to load the nib in setupNib().

     - returns: UIView instance loaded from a nib file.
     */
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName(), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView // swiftlint:disable:this force_cast
    }

    // MARK: - Nib loading

    /**
     Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.

     - parameter container: a view that will become the superview of the contents loaded from the Nib
     */
    fileprivate func setupNib(in container: UIView) {
        let view = self.loadNib()
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:[], metrics:nil, views: bindings))
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:[], metrics:nil, views: bindings))
    }
}

extension UIView {

    /**
     Called in the default implementation of loadNib(). Default is class name.

     - returns: Name of a single view nib file.
     */
    open func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
}

@IBDesignable
open class NibDesignable: UIView, NibDesignableProtocol {

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib(in: self)
    }

    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib(in: self)
    }
}

@IBDesignable
open class NibDesignableTableViewCell: UITableViewCell, NibDesignableProtocol {

    // MARK: - Initializer
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupNib(in: self.contentView)
    }

    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib(in: self.contentView)
    }
}

@IBDesignable
open class NibDesignableTableViewHeaderFooterView: UITableViewHeaderFooterView, NibDesignableProtocol {

	// MARK: - Initializer
	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		self.setupNib(in: self)
	}

	// MARK: - NSCoding
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
        self.setupNib(in: self)
	}
}

@IBDesignable
open class NibDesignableControl: UIControl, NibDesignableProtocol {

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib(in: self)
    }

    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib(in: self)
    }
}

@IBDesignable
open class NibDesignableCollectionReusableView: UICollectionReusableView, NibDesignableProtocol {

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib(in: self)
    }

    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib(in: self)
    }
}

@IBDesignable
open class NibDesignableCollectionViewCell: UICollectionViewCell, NibDesignableProtocol {

    // MARK: - Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib(in: self.contentView)
    }

    // MARK: - NSCoding
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib(in: self.contentView)
    }
}
