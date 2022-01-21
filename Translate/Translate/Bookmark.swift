//
//  Bookmark.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguade: Language
    
    let sourceText: String
    let tranlatedText: String
}

