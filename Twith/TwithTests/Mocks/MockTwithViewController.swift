//
//  MockTwithViewController.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation

@testable import Twith

final class MockTwithViewController: TwithProtocol {
    var isCalledSetViews = false
    var isCalledSetupViews = false
    func setViews(twith: Twith) {
        self.isCalledSetViews = true
    }
    
    func setupViews() {
        self.isCalledSetupViews = true
    }
    
    
}
