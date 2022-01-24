//
//  Icon.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit

enum Icon {
    case comment
    case share
    case like
    case write
    
    var image: UIImage? {
        let systemName: String
        
        switch self {
        case .comment:
            systemName = "message"
        case .share:
            systemName = "square.and.arrow.up"
        case .like:
            systemName = "heart"
        case .write:
            systemName = "square.and.pencil"
        }
        return UIImage(systemName: systemName)
    }
}
