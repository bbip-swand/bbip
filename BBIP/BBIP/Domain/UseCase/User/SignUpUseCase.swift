//
//  SignUpUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Combine
import Foundation

protocol SignUpUseCaseProtocol {
    func execute(signUpDTO: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, Error>
}

final class SignUpUseCase: SignUpUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(signUpDTO: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, Error> {
        repository.signUp(signUpDTO: signUpDTO)
    }
}
