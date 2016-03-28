//
//  NibDesignableDemoTests.swift
//  NibDesignableDemoTests
//
//  Copyright (c) 2015 Morten Bøgh
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
import XCTest
import NibDesignableDemo

class NibDesignableDemoTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testNibNameMatchingClassName() {
        let view = ProfileAvatarView(frame: CGRect())
        XCTAssertEqual("ProfileAvatarView", view.nibName(), "nibName should return the class name when not overridden")
    }

    func testNibNameMatchingNibName() {
        let view = TestView(frame: CGRect())
        XCTAssertEqual("TestingView", view.nibName(), "nibName should return the nib name when overridden")
    }

    func testNibNameNotMatchingClassName() {
        let view = TestView(frame: CGRect())
        XCTAssertNotEqual("TestView", view.nibName(), "nibName should return the nib name when overridden")
    }

    func testNibViewFrameShouldMatchViewFrame() {
        let view = TestView(frame: CGRect())
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
        XCTAssertEqual(view.bounds, view.subviews.first!.frame, "View bounds should match that of the view from the Nib")

        view.frame = CGRect(x: 20, y: 18, width: 200, height: 100)
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
        XCTAssertEqual(view.bounds, view.subviews.first!.frame, "View bounds should match that of the view from the Nib")
    }

    func testViewHasExactlyASingleSubviewAfterInit() {
        let view = TestView(frame: CGRect())
        XCTAssertEqual(view.subviews.count, 1, "View should have exactly 1 subview after init.")
    }
}
