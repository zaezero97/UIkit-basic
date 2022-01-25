//
//  MockProfileViewController.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation

@testable import Twith

final class MockProfileViewController: ProfileProtocol {
    var isCalledSetupViews = false
    var isCalledSetViews = false
    var isCalledEndEditing = false
    var isCalledShowToast = false
    
    func setupViews() {
        self.isCalledSetupViews = true
    }
    
    func setViews(with name: String, account: String) {
        self.isCalledSetViews = true
    }
    
    func endEditing() {
        self.isCalledEndEditing = true
    }
    
    func showToast() {
        self.isCalledShowToast = true
    }
}
