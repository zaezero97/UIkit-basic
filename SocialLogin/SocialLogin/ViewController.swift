//
//  ViewController.swift
//  SocialLogin
//
//  Created by 재영신 on 2022/01/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import NaverThirdPartyLogin
import Alamofire
import AuthenticationServices
import GoogleSignIn

class ViewController: UIViewController,NaverThirdPartyLoginConnectionDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let signInConfig = GIDConfiguration.init(clientID: "638644447656-86s4janofbagv678mhue0cf8oe8cm6vc.apps.googleusercontent.com")
    @IBOutlet weak var facebookLoginButton: UIButton! {
        didSet {
            facebookLoginButton.addTarget(self, action: #selector(didTapFackBookButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var naverLoginButton: UIButton! {
        didSet {
            naverLoginButton.addTarget(self, action: #selector(didTapNaverloginButton(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var kakaoLoginButton: UIButton! {
        didSet {
            kakaoLoginButton.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logout()
     //   GIDSignIn.sharedInstance.signOut()
        let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        authorizationButton.addTarget(self, action: #selector(appleSignInButtonPress), for: .touchUpInside)
        self.view.addSubview(authorizationButton)
        stackView.addArrangedSubview(authorizationButton)
        
        let googleButton = GIDSignInButton()
        googleButton.style = .standard
        googleButton.addTarget(self, action: #selector(didTapGoogleLoginButton), for: .touchUpInside)
        stackView.addArrangedSubview(googleButton)
        loginInstance?.delegate = self
        //kakao
        //kakaoUnlink()
        
        //        if (AuthApi.hasToken()) {
        //            UserApi.shared.accessTokenInfo { (a, error) in
        //                print(a)
        //                if let error = error {
        //                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
        //                        //로그인 필요
        //                    }
        //                    else {
        //                        //기타 에러
        //                    }
        //                }
        //                else {
        //                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
        //                }
        //            }
        //        }
        //        else {
        //            //로그인 필요
        //        }
        
    }
    @objc func appleSignInButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    @objc func didTapKakaoLoginButton() {
        //kakao
        //        if (UserApi.isKakaoTalkLoginAvailable()) {
        //            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        //                if let error = error {
        //                    print(error)
        //                }
        //                else {
        //                    print("loginWithKakaoTalk() success.")
        //                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //                    let vc = storyboard.instantiateViewController(withIdentifier: "abc")
        //                    self.present(vc, animated: true, completion: nil)
        //                    //do something
        //                    _ = oauthToken
        //                }
        //            }
        //        }
        //        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        //            if let error = error {
        //                print(error)
        //            }
        //            else {
        //                print("loginWithKakaoAccount() success.")
        //
        //                //do something
        //                 _ = oauthToken
        //            }
        //        }
        //        UserApi.shared.me {(user, error) in
        //            if let error = error {
        //                print(error)
        //            } else {
        //                print("me() success")
        //                _ = user
        //                print("nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")
        //                print("image: \(user?.kakaoAccount?.profile?.profileImageUrl)")
        //            }
        //        }
    }
    
    @objc private func setUserInfo() {
        
    }
    @objc func didTapFackBookButton() {
        
        
    }
    

    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getInfo()
    }
    
    // referesh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print(loginInstance?.accessToken)
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    @objc func didTapNaverloginButton(_ sender: Any) {
        
        loginInstance?.requestThirdPartyLogin()
    }
    
    func logout() {
        loginInstance?.requestDeleteToken()
    }
    
    // RESTful API, id가져오기
    func getInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
        
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      print("test")
      req.responseJSON { response in
          print(response)
        guard let result = response.value as? [String: Any] else { return }
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let id = object["id"] as? String else {return}
        
        print(email)
        
        
      }
        
        print("test2")
    }
    @objc func didTapGoogleLoginButton(sender: Any) {
      GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
        guard error == nil else { return }
          print("user!!!",user)
          print(user?.profile?.email)
          user?.authentication.do(freshTokens: { authentication, error in
              
          })
        // If sign in succeeded, display the app's main content View.
      }
    }
}


func kakaoUnlink() {
    UserApi.shared.unlink {(error) in
        if let error = error {
            print(error)
        }
        else {
            print("unlink() success.")
        }
    }
}


extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
                
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
     
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
