//
//  FeedViewController.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit

final class FeedViewController: UIViewController {
    private lazy var presenter = FeedPresenter(vc: self)
}

extension FeedViewController: FeedProtocol {
    
}
