//
//  LoginViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import Foundation
import AuthenticationServices

final class LoginViewModel: ObservableObject {
    @Published var showUISView: Bool = false
    
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
            default:
                break
            }
        case .failure(let error):
            print("Apple Login Failed: \(error.localizedDescription)")
        }
    }
}
