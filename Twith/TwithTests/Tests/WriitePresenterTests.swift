//
//  WriitePresenterTests.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import XCTest
@testable import Twith

class WritePresenterTestS: XCTestCase {
    var sut: WritePresenter!
    
    var vc: MockWriteViewController!
    var manager: MockUserDefaulutsManager!
    
    override func setUp() {
        super.setUp()
        
        self.vc = MockWriteViewController()
        self.manager = MockUserDefaulutsManager()
        
        self.sut = WritePresenter(vc: vc, manager: manager)
    }
    
    override func tearDown() {
        self.sut = nil
        self.manager = nil
        self.vc = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()
        
        XCTAssertTrue(self.vc.isCalledSetupViews)
    }
    
    func test_didTapLeftBarButtonItem가_클릭되면() {
        sut.didTapLeftBarButtonItem()
        XCTAssertTrue(self.vc.isCalledDismiss)
    }
    
    func test_didTapRightBarButton가_클릭되면() {
        sut.didTapRightBarButtonItem(text: "")
        XCTAssertTrue(self.manager.isCalledSetTwith)
        XCTAssertTrue(self.vc.isCalledDismiss)
    }
}

