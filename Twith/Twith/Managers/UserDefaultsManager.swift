//
//  UserDefaultManager.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getTwith() -> [Twith]
    func setTwith(_ newValue: Twith)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case twith
        
        var value: String {
            self.rawValue
        }
    }
    
    func getTwith() -> [Twith] {
        guard let data = UserDefaults.standard.data(forKey: Key.twith.value) else { return [] }
        
        return (try? PropertyListDecoder().decode([Twith].self, from: data)) ?? []
    }
    
    func setTwith(_ newValue: Twith) {
        let currentTwith: [Twith] = [newValue] + getTwith()
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentTwith), forKey: Key.twith.value)
    }
}
