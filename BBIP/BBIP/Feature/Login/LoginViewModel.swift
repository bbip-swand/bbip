//
//  LoginViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import Foundation
import Combine
import AuthenticationServices

final class LoginViewModel: ObservableObject {
    @Published var loginSuccess: Bool = false
    @Published var isNewUser: Bool = false
    
    private let requestLoginUseCase: RequestLoginUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var identityToken: String?
    private var authorizationCode: String?
    
    init(requestLoginUseCase: RequestLoginUseCaseProtocol) {
        self.requestLoginUseCase = requestLoginUseCase
    }
    
    func handleAppleLogin(result: Result<ASAuthorization, any Error>) {
        switch result {
        case .success(let authResults):
            print("Apple Login Successful")
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                
                assert(identityToken == nil, "identity token is nil")
                requestLogin(identityToken: identityToken!)
            default:
                break
            }
        case .failure(let error):
            print("Apple Login Failed: \(error.localizedDescription)")
        }
    }
    
    private func requestLogin(identityToken: String) {
        requestLoginUseCase.excute(identityToken: identityToken)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.handleError(error)
                }
            } receiveValue: { [weak self] vo in
                guard let self = self else { return }
                guard vo.isUserInfoGenerated else {
                    self.isNewUser = true
                    return
                }
                // MARK: Login Success!
                UserDefaultsManager.shared.saveAccessToken(token: vo.accessToken)
                UserDefaultsManager.shared.setIsLoggedIn(true)
                self.loginSuccess = true
            }.store(in: &cancellables)
    }
    
    private func handleError(_ error: AuthError) {
        switch error {
        case .notRegisted:
            signInProcess()
        case .unknownError:
            print("[LoginViewModel] requestLogin() Unknown Error! :", error.localizedDescription)
        }
    }
    
    private func signInProcess() {
        print("signInProcess is called!")
    }
}
