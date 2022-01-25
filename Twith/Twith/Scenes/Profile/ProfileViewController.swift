//
//  ProfileViewController.swift
//  Twith
//
//  Created by 재영신 on 2022/01/25.
//

import UIKit
import SnapKit
import Toast

final class ProfileViewController: UIViewController {
    private lazy var presenter = ProfilePresneter(vc: self)
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20.0, weight: .medium)
        textField.delegate = self
        return textField
    }()
    
    private lazy var accountTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .bold)
        textField.delegate = self
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .bold)
        button.setTitle("저장하기", for: .normal)
        button.layer.cornerRadius = 15.0
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.titlePadding = 8.0
            button.configuration = config
        } else {
            button.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
            // Fallback on earlier versions
        }
     
        return button
    }()
    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
}

extension ProfileViewController: ProfileProtocol {
    func setupViews() {
        self.navigationItem.title = "Profile"
        
        [nameTextField, accountTextField, saveButton]
            .forEach {
                self.view.addSubview($0)
            }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
        }
        
        accountTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTextField)
            make.top.equalTo(nameTextField.snp.bottom).offset(16.0)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTextField)
            make.top.equalTo(accountTextField.snp.bottom).offset(32.0)
        }
    }
    
    func setViews(with name: String, account: String) {
        self.nameTextField.text = name
        self.accountTextField.text = account
    }
    
    func endEditing() {
        self.view.endEditing(true)
    }
    
    func showToast() {
        self.view.makeToast("변경하고자하는 내용을 입력해주세요.")
    }
}

private extension ProfileViewController {
    @objc func didTapSaveButton() {
        self.presenter.didTapSaveButton(name: self.nameTextField.text, account: self.accountTextField.text)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
