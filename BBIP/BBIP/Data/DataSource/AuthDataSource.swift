//
//  AuthDataSource.swift
//  BBIP
//
//  Created by 이건우 on 9/6/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

enum AuthError: Error {
    case notRegisted
    case unknownError
}

final class AuthDataSource {
    private let provider = MoyaProvider<AuthAPI>()
    
    func requestLogin(identityToken : String) -> AnyPublisher<LoginResponseDTO, AuthError> {
        provider.requestPublisher(.login(identityToken: identityToken))
            .tryMap { response in
                print("[AuthDataSource] requestLogin() Status Code: \(response.statusCode)")
                if response.statusCode == 401 {
                    throw AuthError.notRegisted
                }
                return response.data
            }
            .decode(type: LoginResponseDTO.self, decoder: JSONDecoder())
            .mapError { error in
                print("[AuthDataSource] requestLogin() Error: \(error.localizedDescription)")
                return AuthError.unknownError
            }
            .eraseToAnyPublisher()
    }
}
