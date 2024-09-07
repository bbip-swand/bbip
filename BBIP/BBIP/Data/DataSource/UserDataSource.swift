//
//  UserDataSource.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

final class UserDataSource {
    private let provider = MoyaProvider<UserAPI>()
    
    func requestSignUp(signUpReqDTO: SignUpRequestDTO) -> AnyPublisher<Bool, Error> {
        provider.requestPublisher(.signUp(dto: signUpReqDTO))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "SignUp Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[UserDataSource] requestSignUp() failed with status code \(response.statusCode)"]
                    )
                }
                return true
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func requestResign() -> AnyPublisher<Bool, Error> {
        provider.requestPublisher(.resign)
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "Resign Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[UserDataSource] requestResign() failed with status code \(response.statusCode)"]
                    )
                }
                return true
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func createUserInfo(userInfoDTO: UserInfoDTO) -> AnyPublisher<Bool, Error> {
        provider.requestPublisher(.info(dto: userInfoDTO))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "Create UIS Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[UserDataSource] createUserInfo() failed with status code \(response.statusCode)"]
                    )
                }
                return true
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
            
    }
    
    func updateUserInfo(userInfoDTO: UserInfoDTO) -> AnyPublisher<Bool, Error> {
        provider.requestPublisher(.updateInfo(dto: userInfoDTO))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "Update UIS Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[UserDataSource] updateUserInfo() failed with status code \(response.statusCode)"]
                    )
                }
                return true
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
