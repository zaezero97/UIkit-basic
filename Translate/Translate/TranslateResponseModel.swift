//
//  TranslateResponseModel.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import Foundation

struct TranslateResponseModel: Decodable {
    private let message: Message
    
    struct Message: Decodable {
        let result : Result
    }
    struct Result: Decodable {
        let translatedText: String
    }
    
    var translatedText: String { message.result.translatedText }
}
