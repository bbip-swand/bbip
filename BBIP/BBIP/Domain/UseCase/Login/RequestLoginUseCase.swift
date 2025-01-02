//
//  RequestLoginUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/6/24.
//

import Combine

protocol RequestLoginUseCaseProtocol {
    func execute(identityToken: String) -> AnyPublisher<LoginVO, AuthError>
}

final class RequestLoginUseCase: RequestLoginUseCaseProtocol {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func execute(identityToken: String) -> AnyPublisher<LoginVO, AuthError> {
        repository.requestLogin(identityToken: identityToken)
    }
}
