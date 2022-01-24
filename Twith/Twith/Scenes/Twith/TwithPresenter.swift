//
//  TwithPresenter.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import Foundation

protocol TwithProtocol: AnyObject {
    func setViews(twith: Twith)
    func setupViews()
}

final class TwithPresenter {
    private weak var vc: TwithProtocol?
    private let twith: Twith
    
    init(
        vc: TwithProtocol,
        twith: Twith
    ) {
        self.vc = vc
        self.twith = twith
    }
    
    func viewDidLoad() {
        self.vc?.setupViews()
        self.vc?.setViews(twith: self.twith)
    }
}
