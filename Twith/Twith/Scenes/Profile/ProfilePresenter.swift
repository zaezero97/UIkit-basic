//
//  ProfileProtocol.swift
//  Twith
//
//  Created by 재영신 on 2022/01/25.
//

import Foundation

protocol ProfileProtocol: AnyObject {
    func setupViews()
    func setViews(with name: String, account: String)
    func endEditing()
    func showToast()
}

final class ProfilePresneter {
    private weak var vc: ProfileProtocol?
    private var user:User {
        get { User.shared }
        set { User.shared = newValue }
    }
        
    
    init(vc: ProfileProtocol) {
        self.vc = vc
    }
    
    func viewDidLoad() {
        self.vc?.setupViews()
        self.vc?.setViews(with: user.name, account: user.account)
    }
    
    func didTapSaveButton(name: String?, account: String?) {
        if name == nil || name == "" || account == nil || account == "" {
            self.vc?.showToast()
            return
        }
        self.vc?.endEditing()
        if let name = name {
            user.name = name
        }
        
        if let account = account {
            user.account = account
        }
        
        self.vc?.setViews(with: user.name, account: user.account)
    }
}
