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


/**
    Protocol for `NibDesignable` pattern (related to `@IBDesignable`) for loading xib-based views for `UIView` subclasses in an `@IBDesignable`-compatible way.  Views which are `NibDesignable` may typically be rendered in Interface Builder.
     
    ## See also
 
    [NibDesignable](https://github.com/mbogh/NibDesignable) project on github.com (MIT License)
 
     - authors: [@mbogh](https://github.com/mbogh), *et al*.
    */
public protocol NibDesignableProtocol: NSObjectProtocol {
    /**
     Identifies the view that will be the superview of the contents loaded from
     the Nib. Referenced in setupNib().

     - returns: Superview for Nib contents.
     */
    var nibContainerView: UIView { get }
    
    /**
     Called in the default implementation of loadNib(). Default is class name.

     - returns: Name of a single view nib file.
     */
    var nibName: String { get }
    
    /**
     Called in the default implementation of loadNib(). Default is the bundle of the custom view class.
     
     - returns: the bundle of the NibDesigable to look for the Nib for.
     */
    var bundle: Bundle { get }
    
    /**
     Specifies which class should be responsible for loading the nib of this NibDesignable.
     Defaults to the class that implements the NibDesignable protocol.
     However, if subclasses of NibDesignable views (i.e. subclasses of subclasses of NibDesignable) don't want to
     handle their own Nib but rely on that of their superclass, they should override this variable and return the
     super class. This will make sure the superclass handles nib loading and will result in the same nib being used
     for the sub class as was used by the superclass.
     
     - returns: the class that handles the nib loading. This class needs to be implementing NibDesignableProtocol.
     */
    var nibLoadingClass: AnyClass { get }
}

extension NibDesignableProtocol where Self: UIView {
    
    /**
     Called to load the nib in setupNib().

     - returns: UIView instance loaded from a nib file.
     */
    internal func loadNib() -> UIView {
        let bundle = self.bundle
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        let m_view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView // swiftlint:disable:this force_cast
        return m_view
    }

    // MARK: - Nib loading

    /**
     Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
     */
    internal func setupNib() {
        let view = self.loadNib()
        self.nibContainerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:[], metrics:nil, views: bindings))
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:[], metrics:nil, views: bindings))
        self.nibContainerView.preservesSuperviewLayoutMargins = true

        if #available(iOS 11.0, *) {
            // do nothing, because it works ok
        } else {
            // add the preservesSuperviewLayoutMargins workaround
            // will be executed for anything < 11.0
            view.preservesSuperviewLayoutMargins = true
        }
    }

    /// The nib container view of nib designable view.
    /// Defaults to the view itself.
    public var nibContainerView: UIView {
        return self
    }

    /// The name of the nib that the contents of this view is loaded from.
    public var nibName: String {
        return self.nibLoadingClass.description().components(separatedBy: ".").last!
    }
    /// The name of the bundle to look for the nib in. Defaults to the bundle
    /// that contains the nibLoadingClass.
    public var bundle: Bundle {
        return Bundle(for: self.nibLoadingClass)
    }

    /// The class that is responsible for loading the nib. Defaults to the UIView's (sub)class itself.
    public var nibLoadingClass: AnyClass {
        return type(of: self)
    }
}

/**
    `NibDesignableProtocol`-compliant implementation of `UIView`
 
    ## See also
    `NibDesignableProtocol`
 */
@IBDesignable
open class NibDesignable: UIView, NibDesignableProtocol {

    // MARK: - Initializer
    /// :nodoc:
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

/**
 `NibDesignableProtocol`-compliant implementation of `UITableViewCell`
 
 ## See also
 `NibDesignableProtocol`
 */
@IBDesignable
open class NibDesignableTableViewCell: UITableViewCell, NibDesignableProtocol {

    /// The nib container view of this TableView cell.
    open var nibContainerView: UIView {
        return self.contentView
    }

    // MARK: - Initializer
    /// :nodoc:
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.preservesSuperviewLayoutMargins = true
        self.setupNib()
    }

    // MARK: - NSCoding
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.preservesSuperviewLayoutMargins = true
        self.setupNib()
    }
}

/**
 `NibDesignableProtocol`-compliant implementation of `UIControl`
 
 ## See also
 `NibDesignableProtocol`
 */
@IBDesignable
open class NibDesignableControl: UIControl, NibDesignableProtocol {

    // MARK: - Initializer
    /// :nodoc:
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }
    
    // MARK: - NSCoding
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

/**
 `NibDesignableProtocol`-compliant implementation of `UITableViewHeaderFooterView`
 
 ## See also
 `NibDesignableProtocol`
 */
@IBDesignable
open class NibDesignableTableViewHeaderFooterView: UITableViewHeaderFooterView, NibDesignableProtocol {

    /// The nib container view of this TableView header footer view.
	open var nibContainerView: UIView {
			return self.contentView
	}

    // MARK: - Initializer
    /// :nodoc:
	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		self.setupNib()
	}

    // MARK: - NSCoding
    /// :nodoc:
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupNib()
	}
}

/**
 `NibDesignableProtocol`-compliant implementation of `UICollectionReusableView`
 
 ## See also
 `NibDesignableProtocol`
 */
@IBDesignable
open class NibDesignableCollectionReusableView: UICollectionReusableView, NibDesignableProtocol {

    // MARK: - Initializer
    /// :nodoc:
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}

/**
 `NibDesignableProtocol`-compliant implementation of `UICollectionViewCell`
 
 ## See also
 `NibDesignableProtocol`
 */
@IBDesignable
open class NibDesignableCollectionViewCell: UICollectionViewCell, NibDesignableProtocol {
    
    /// The nib container view of this collection view cell.
    open var nibContainerView: UIView {
        return self.contentView
    }

    // MARK: - Initializer
    /// :nodoc:
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }

    // MARK: - NSCoding
    /// :nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}
