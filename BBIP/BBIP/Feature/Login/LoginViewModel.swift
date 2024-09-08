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
    @Published var UISDataIsEmpty: Bool = false
    
    private let requestLoginUseCase: RequestLoginUseCaseProtocol
    private let signUpUseCase: SignUpUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    private var identityToken: String?
    private var authorizationCode: String?
    
    init(
        requestLoginUseCase: RequestLoginUseCaseProtocol,
        signUpUseCase: SignUpUseCaseProtocol
    ) {
        self.requestLoginUseCase = requestLoginUseCase
        self.signUpUseCase = signUpUseCase
    }
    
    func handleAppleLogin(result: Result<ASAuthorization, any Error>) {
        switch result {
        case .success(let authResults):
            print("Apple Login Successful")
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                
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
                    // 신규유저 or Error
                    self.handleError(error)
                }
            } receiveValue: { [weak self] vo in
                guard let self = self else { return }
                UserDefaultsManager.shared.saveAccessToken(token: vo.accessToken)
                
                guard vo.isUserInfoGenerated else {
                    print("기존 유저이지만 UIS 입력 안된 유저입니다 (UISView push)")
                    self.UISDataIsEmpty = true
                    return
                }
                
                // MARK: Login Success!
                UserDefaultsManager.shared.setIsLoggedIn(true)
                self.loginSuccess = true
                print("로그인 성공!")
                
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
        guard let identityToken = identityToken, 
              let authorizationCode = authorizationCode else {
            print("[LoginViewModel] Missing token or authorization code")
            return
        }
        
        let signUpDTO = SignUpRequestDTO(
            identityToken: identityToken,
            authorizationCode: authorizationCode,
            fcmToken: UserDefaultsManager.shared.getFCMToken()!
        )
        signUpUseCase.execute(signUpDTO: signUpDTO)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] vo in
                guard let self = self else { return }
                print("지금 회원가입된 유저입니다")
                UserDefaultsManager.shared.saveAccessToken(token: vo.accessToken)
                self.UISDataIsEmpty = true
            }
            .store(in: &cancellables)
    }
}
