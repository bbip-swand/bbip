//
//  LoginViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import Foundation
import AuthenticationServices

final class LoginViewModel: ObservableObject {
    @Published var loginSuccess: Bool = false
    
    func handleAppleLogin(result: Result<ASAuthorization, any Error>) {
        switch result {
        case .success(let authResults):
            print("Apple Login Successful")
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                let email = appleIDCredential.email
                let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                
                print("User ID: \(userIdentifier)")
                print("Name: \(name)")
                print("Email: \(email ?? "No email")")
                print("Identity Token: \(identityToken ?? "No identity token")")
                print("Authorization Code: \(authorizationCode ?? "No authorization code")")
                
                loginProcess()
            default:
                break
            }
        case .failure(let error):
            print("Apple Login Failed: \(error.localizedDescription)")
        }
    }
    
    private func loginProcess() {
        // TODO: - loginProcess
        // 1. 받은 Identity Token으로 로그인 요청
        // 2. AccessToken 받아지면 기존유저 이므로 Keychain & UD 저장 후 Home 진입
        // 3. 2번이 아니라면 Identity Token, authorizationCode로 회원가입 요청 후 AccessToken 받기 (신규유저 트리거)
        // 4. UIS뷰로 진입시키고 받은 기초 정보로 회원정보 수정 요청
        
        loginSuccess = true
    }
}
