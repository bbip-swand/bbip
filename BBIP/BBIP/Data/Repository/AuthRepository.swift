//
//  AuthRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/6/24.
//

import Combine

protocol AuthRepository {
    func requestLogin(identityToken: String) -> AnyPublisher<LoginVO, AuthError>
}

final class AuthRepositoryImpl: AuthRepository {
    private let dataSource: AuthDataSource
    private let mapper: LoginResponseMapper
    
    init(
        dataSource: AuthDataSource,
        mapper: LoginResponseMapper
    ) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func requestLogin(identityToken: String) -> AnyPublisher<LoginVO, AuthError> {
        dataSource.requestLogin(identityToken: identityToken)
            .map { self.mapper.map($0) }
            .eraseToAnyPublisher()
    }
}
