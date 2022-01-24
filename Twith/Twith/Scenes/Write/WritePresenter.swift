//
//  WritePresenter.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import Foundation

protocol WriteProtocol: AnyObject {
    func setupViews()
    func dismiss()
}

final class WritePresenter {
    private weak var vc: WriteProtocol?
    private let manager: UserDefaultsManagerProtocol
    init(
        vc: WriteProtocol,
        manager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.vc = vc
        self.manager = manager
    }
    
    func viewDidLoad() {
        self.vc?.setupViews()
    }
    
    func didTapLeftBarButtonItem() {
        self.vc?.dismiss()
    }
    func didTapRightBarButtonItem(text: String) {
        self.manager.setTwith(Twith(user: User.shared, content: text))
        self.vc?.dismiss()
    }
}
