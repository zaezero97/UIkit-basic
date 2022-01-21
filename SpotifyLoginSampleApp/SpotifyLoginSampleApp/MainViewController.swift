//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 재영신 on 2022/01/19.
//
import UIKit
import SwiftUI
import SnapKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "환영합니다."
        label.textColor = .white
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "로그아웃"
        config.baseForegroundColor = .white
        button.configuration = config
        button.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    lazy var pwdChangeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "비밀 번호 변경"
        config.baseForegroundColor = .white
        button.configuration = config
        button.addTarget(self, action: #selector(didTapPwdChangeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var updateNickNameButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "닉네임 업데이트"
        config.baseForegroundColor = .white
        button.configuration = config
        button.addTarget(self, action: #selector(didTapUpdateNickNameButton), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        
    }
    
    private func configureUI() {
        
        //root view
        self.view.backgroundColor = .black
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(logoutButton)
        self.view.addSubview(pwdChangeButton)
        self.view.addSubview(updateNickNameButton)
        //navigation
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.navigationBar.isHidden = true
        
        //welcomeLabel
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
        환영합니다
        \(email)님
        """
        
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password" //이메일로 로그인
        pwdChangeButton.isHidden = !isEmailSignIn
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.welcomeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.logoutButton.snp.makeConstraints { make in
            make.centerX.equalTo(welcomeLabel)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
        }
        self.pwdChangeButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.updateNickNameButton.snp.makeConstraints { make in
            make.top.equalTo(pwdChangeButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func didTapLogoutButton() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: singout error",signOutError.localizedDescription)
        }
        
    }
    @objc func didTapPwdChangeButton() {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    @objc func didTapUpdateNickNameButton() {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "토끼"
        changeRequest?.commitChanges(completion: {  _ in
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            self.welcomeLabel.text = """
            환영합니다.
            \(displayName)님
            """
        })
    }
}

struct MainViewController_Priviews: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = MainViewController()
            return vc
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
    
    
}
