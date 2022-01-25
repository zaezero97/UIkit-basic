//
//  MockUserDefaultsManager.swift
//  TwithTests
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation
@testable import Twith

final class MockUserDefaulutsManager: UserDefaultsManagerProtocol {
    var twiths: [Twith] = []
    var newTwith: Twith!
    
    var isCalledGetTwith = false
    var isCalledSetTwith = false
    
    func getTwith() -> [Twith] {
        isCalledGetTwith = true
        
        return twiths
    }
    
    func setTwith(_ newValue: Twith) {
        isCalledSetTwith = true
    }
}
