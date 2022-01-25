//
//  MockWriteViewController.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation
@testable import Twith
final class MockWriteViewController: WriteProtocol {
    var isCalledSetupViews = false
    var isCalledDismiss = false
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func dismiss() {
        isCalledDismiss = true
    }
}
