//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 재영신 on 2022/01/19.
//

import UIKit
import SwiftUI
import SnapKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소가 무엇인가요?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.delegate = self
        textField.becomeFirstResponder()
        return textField
    }()
    
    lazy var pwdLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 입력해주세요."
        label.textColor = .white
        label.textAlignment = .center
        
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var pwdTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.delegate = self
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        var config = UIButton.Configuration.filled()
        config.title = "다음"
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        button.configuration = config
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    lazy var inputStackView: UIStackView = {
        let stackView = UIStackView()
        [emailLabel,emailTextField,pwdLabel,pwdTextField,errorLabel].forEach{
            stackView.addArrangedSubview($0)
        }
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    private func configureUI() {
        
        //root view
        self.view.addSubview(inputStackView)
        self.view.addSubview(nextButton)
        self.view.backgroundColor = .black
        
        //navigation
        self.navigationController?.navigationBar.isHidden = false
        
        self.setConstraints()
    }
    private func setConstraints() {
        self.emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        self.pwdTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        self.inputStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(70)
        }
        
        self.nextButton.snp.makeConstraints { make in
            make.top.equalTo(self.inputStackView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(80)
        }
    }
    @objc func didTapNextButton() {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = pwdTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {
            [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007:
                    //이미 가입한 계정일 때 로그인 하기
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorLabel.text = error.localizedDescription
                }
            }else {
                self.showMainViewController()
            }
            
        }
    }
    
    private func showMainViewController() {
        navigationController?.show(MainViewController(), sender: nil)
        
    }
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                self.errorLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPwdEmpty = pwdTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPwdEmpty
        
    }
}

struct EnterEmailViewController_Priviews: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = EnterEmailViewController()
            return vc
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
    
 
}
