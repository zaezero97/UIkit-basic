//
//  ProfilePresenterTests.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import XCTest

@testable import Twith

final class ProfilePresenterTests: XCTestCase {
    var sut: ProfilePresneter!
    
    var vc: MockProfileViewController!
    
    override func setUp() {
        super.setUp()
        
        self.vc = MockProfileViewController()
        self.sut = ProfilePresneter(vc: self.vc)
    }
    
    override func tearDown() {
        self.sut = nil
        self.vc = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(self.vc.isCalledSetupViews, "setupViews call")
        XCTAssertTrue(self.vc.isCalledSetViews, "setView call")
    }
    
    // name 존재 하지 않을 때
    func test_didTapSaveButton이_요청될때_name이_존재하지않으면() {
        self.sut.didTapSaveButton(name: nil, account: "account")
        
        XCTAssertTrue(self.vc.isCalledShowToast)
        XCTAssertFalse(self.vc.isCalledEndEditing)
        XCTAssertFalse(self.vc.isCalledSetViews)
    }
    
    //account가 존재하지 않을 때
    func test_didTapSaveButton이_요청될때_account이_존재하지않으면() {
        self.sut.didTapSaveButton(name: "name", account: nil)
        
        XCTAssertTrue(self.vc.isCalledShowToast)
        XCTAssertFalse(self.vc.isCalledEndEditing)
        XCTAssertFalse(self.vc.isCalledSetViews)
    }
    
    //name,account 존재하지 않으면
    func test_didTapSaveButton이_요청될때_name과account가_존재하지않으면() {
        self.sut.didTapSaveButton(name: nil, account: nil)
        
        XCTAssertTrue(self.vc.isCalledShowToast)
        XCTAssertFalse(self.vc.isCalledEndEditing)
        XCTAssertFalse(self.vc.isCalledSetViews)
    }
    
    //모두 존재
    func test_didTapSaveButton이_요청될때_name과account가_존재하면() {
        self.sut.didTapSaveButton(name: "name", account: "account")
        
        XCTAssertFalse(self.vc.isCalledShowToast)
        XCTAssertTrue(self.vc.isCalledEndEditing)
        XCTAssertTrue(self.vc.isCalledSetViews)
    }
    
}

