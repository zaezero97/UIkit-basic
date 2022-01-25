//
//  MockFeedViewController.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation
@testable import Twith
final class MockFeedViewController: FeedProtocol {
    var isCalledSetupView = false
    var isCalledMoveToWriteVC = false
    var isCalledReloadTableView = false
    var isCalledMoveToTwithVC = false
    func setupView() {
        isCalledSetupView = true
    }
    
    func moveToTwithViewController(with twith: Twith) {
        isCalledMoveToTwithVC = true
    }
    
    func moveToWriteViewController() {
        isCalledMoveToWriteVC = true
    }
    
    func reloadData() {
        isCalledReloadTableView = true
    }
}
