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
     Identifies the view that will be the superview of the contents loaded from
     the Nib. Referenced in setupNib().

     - returns: Superview for Nib contents.
     */
    var nibContainerView: UIView { get }
    // MARK: - Nib loading

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
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: self.nibName(), bundle: bundle)
        return nib.instantiateWithOwner(self, options: nil)[0] as! UIView // swiftlint:disable:this force_cast
    }

    // MARK: - Nib loading

    /**
     Called in init(frame:) and init(aDecoder:) to load the nib and add it as a subview.
     */
    private func setupNib() {
        #if TARGET_INTERFACE_BUILDER
          setupNibWithViewInjection()
        #else
          setupNibWithViewReplication()
        #endif
        self.nibContainerView.awakeFromNib()
      }
      
      private func setupNibWithViewInjection() {
        let view = self.loadNib()
        self.nibContainerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:[], metrics:nil, views: bindings))
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:[], metrics:nil, views: bindings))
      }
      
      private func setupNibWithViewReplication() {
        let view = self.loadNib()
        let nibView = self.nibContainerView
        let constraints = view.constraints.map { (constraint) -> NSLayoutConstraint in
          if view == constraint.firstItem as? UIView {
            constraint.setValue(nibView, forKey: "firstItem")
          }
          if view == constraint.secondItem as? UIView {
            constraint.setValue(nibView, forKey: "secondItem")
          }
          return constraint
        }
        
        view.subviews.forEach { nibView.addSubview($0) }
        nibView.translatesAutoresizingMaskIntoConstraints = false
        nibView.addConstraints(constraints)
        nibView.setValuesForKeysWithDictionary(view.dictionaryWithValuesForKeys(["tag", "clipsToBounds", "backgroundColor", "userInteractionEnabled", "hidden"]))
      }
}

extension UIView {
    public var nibContainerView: UIView {
        return self
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
public class NibDesignable: UIView, NibDesignableProtocol {

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
}

@IBDesignable
public class NibDesignableTableViewCell: UITableViewCell, NibDesignableProtocol {
    public override var nibContainerView: UIView {
        return self.contentView
    }
    
    func setupNib() {
        setupNibWithViewInjection()
      }

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
}

@IBDesignable
public class NibDesignableTableViewHeaderFooterView: UITableViewHeaderFooterView, NibDesignableProtocol {
	
	public override var nibContainerView: UIView {
			return self.contentView
	}
	
	private func setupNib() {
		setupNibWithViewInjection()
	}
	
	// MARK: - Initializer
	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		self.setupNib()
	}
	
	// MARK: - NSCoding
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setupNib()
	}
}

@IBDesignable
public class NibDesignableControl: UIControl, NibDesignableProtocol {

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
}

@IBDesignable
public class NibDesignableCollectionReusableView: UICollectionReusableView, NibDesignableProtocol {

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
}

@IBDesignable
public class NibDesignableCollectionViewCell: UICollectionViewCell, NibDesignableProtocol {
    public override var nibContainerView: UIView {
        return self.contentView
    }
    
    func setupNib() {
        setupNibWithViewInjection()
      }

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
}
