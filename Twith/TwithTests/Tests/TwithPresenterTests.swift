//
//  TwithPresenterTests.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import XCTest

@testable import Twith

final class TwithPresenterTests: XCTestCase {
    var sut: TwithPresenter!
    
    var vc: MockTwithViewController!
    var twith: Twith!
    
    override func setUp() {
        super.setUp()
        
        self.vc = MockTwithViewController()
        self.twith = Twith(user: User(name: "name", account: "accoount"), content: "contents")
        
        self.sut = TwithPresenter(vc: self.vc, twith: twith)
    }
    
    override func tearDown() {
        self.sut = nil
        self.twith = nil
        self.vc = nil
        super.tearDown()
    }
    
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()
        
        XCTAssertTrue(self.vc.isCalledSetViews)
        XCTAssertTrue(self.vc.isCalledSetupViews)
    }
}

