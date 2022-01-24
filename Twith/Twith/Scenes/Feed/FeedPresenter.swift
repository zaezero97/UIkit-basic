//
//  FeedPresenter.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import Foundation

protocol FeedProtocol: AnyObject {
    
}

final class FeedPresenter {
    private weak var vc: FeedProtocol?
    
    init(vc: FeedProtocol) {
        self.vc = vc
    }
}
