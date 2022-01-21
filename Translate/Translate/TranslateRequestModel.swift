//
//  TranslateRequestModel.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import Foundation

struct TranslateRequestModel: Encodable {
    let source: String
    let target: String
    let text: String
}
