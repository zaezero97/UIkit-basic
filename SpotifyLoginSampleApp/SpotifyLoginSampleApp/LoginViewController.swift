//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 재영신 on 2022/01/19.
//

import UIKit
import SwiftUI
import SnapKit
import GoogleSignIn
import Firebase
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class LoginViewController: UIViewController {
    let userNotiCenter = UNUserNotificationCenter.current()
  
    private var currentNonce: String?
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "music.note.house.fill")
        imageView.tintColor = .white
        return imageView
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.text =
        """
        내 마음에 꼭 드는 또 다른
        플레이리스트를
        발견해보세요.
        """
        label.font = .systemFont(ofSize: 31, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    lazy var emailLoginButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = "이메일/비밀번호로 계속하기"
        configuration.baseBackgroundColor = .black
        button.configuration = configuration
        button.addTarget(self, action: #selector(didTapEmailLoginButton), for: .touchUpInside)
        return button
    }()
    lazy var googleLoginButton: UIButton = {
        let button = UIButton()
       // button.style = .standard
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 30
        configuration.title = "구글로 계속하기"
        configuration.baseBackgroundColor = .black
        configuration.image = UIImage(named: "logo_google")
        button.configuration = configuration
        button.addTarget(self, action: #selector(didTapGoogleLoginButton), for: .touchUpInside)
        return button
    }()
    lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 30
        configuration.title = "Apple ID로 계속하기"
        configuration.baseBackgroundColor = .black
        configuration.image = UIImage(named: "logo_apple")
        button.configuration = configuration
        button.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
        return button
    }()
    lazy var titleStackView: UIStackView = {
       let stackView = UIStackView()
        [imageView,label].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.alignment = .center
        stackView.axis = .vertical
        
        return stackView
    }()
    lazy var loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()

        self.requestSendNoti(seconds: 2.0)
    }
    
    private func configureUI() {
        
        //root view
        self.view.backgroundColor = .black
        self.view.addSubview(titleStackView)
        self.view.addSubview(loginButtonStackView)
        //navigation
        self.navigationController?.navigationBar.isHidden = true
        
        //Login Buttons
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach{
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.cornerRadius = 30
            $0.clipsToBounds = true
        }
        
        self.setConstraints()
    }
    private func setConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(80)
        }
        loginButtonStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.leading.trailing.equalToSuperview()
            }
        }
        self.titleStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
        }
        self.loginButtonStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(titleStackView.snp.bottom).offset(60)
        }
    }
   
    // 알림 전송
    func requestSendNoti(seconds: Double) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "알림 title"
        notiContent.body = "알림 body"
        notiContent.userInfo = ["targetScene": "splash"] // 푸시 받을때 오는 데이터

        // 알림이 trigger되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )

        userNotiCenter.add(request) { (error) in
            print(#function, error)
        }

    }

}

struct ViewController_Priviews: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = LoginViewController()
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}

// MARK: - Action Methods
extension LoginViewController {
    @objc func didTapEmailLoginButton() {
        print("tapped")
        self.navigationController?.pushViewController(EnterEmailViewController(), animated: true)
    
    }
    @objc func didTapGoogleLoginButton() {
       
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: self) { user, error in
            guard let authentication = user?.authentication else { return }
            
            let crecential = GoogleAuthProvider.credential(withIDToken: authentication.idToken!, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: crecential) { _, _ in
                self.showMainViewController()
            }
        }
    }
    
    @objc func didTapAppleLoginButton() {
        self.startSignInWithAppleFlow()
    }
    private func showMainViewController() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
}
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
                ///Main 화면으로 보내기
               
                self.navigationController?.show(MainViewController(), sender: nil)
            }
        }
    }
}
//Apple Sign in
extension LoginViewController {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
