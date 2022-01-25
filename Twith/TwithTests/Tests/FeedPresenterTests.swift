//
//  FeedPresenterTests.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import XCTest
@testable import Twith

class FeedPresenterTests: XCTestCase {
    var sut: FeedPresenter!
    
    var viewController: MockFeedViewController!
    var userDefaultsManager: MockUserDefaulutsManager!
    
    override func setUp() {
        super.setUp()
        self.viewController = MockFeedViewController()
        self.userDefaultsManager = MockUserDefaulutsManager()
        self.sut = FeedPresenter(vc: self.viewController, manager: self.userDefaultsManager)
    }
    
    override func tearDown() {
        self.sut = nil
        self.userDefaultsManager = nil
        self.viewController = nil
    }
    
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()
        
        XCTAssertTrue(self.viewController.isCalledSetupView)
    }
    
    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()
        XCTAssertTrue(self.userDefaultsManager.isCalledGetTwith)
        XCTAssertTrue(self.viewController.isCalledReloadTableView)
    }
    
    func test_didTapWriteButton이_요청되면() {
        sut.didTapWriteButton()
        
        XCTAssertTrue(self.viewController.isCalledMoveToWriteVC)
    }
}



