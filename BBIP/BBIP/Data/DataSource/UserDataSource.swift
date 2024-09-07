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
    
    func requestSignIn(signUpReqDTO: SignUpRequestDTO) -> AnyPublisher<Bool, Error> {
        provider.requestPublisher(.signUp(dto: signUpReqDTO))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "SignIn Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[UserDataSource] requestSignIn() failed with status code \(response.statusCode)"]
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
