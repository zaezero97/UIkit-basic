//
//  User.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import Foundation

struct User: Codable {
    var name: String
    var account: String
    
    static var shared = User(name: "IOS개발자", account: "ios_developer") 
}
