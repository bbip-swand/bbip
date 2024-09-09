//
//  CreateUserInfoUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Combine
import Foundation

protocol CreateUserInfoUseCaseProtocol {
    func execute(userInfoVO: UserInfoVO) -> AnyPublisher<Bool, Error>
}

final class CreateUserInfoUseCase: CreateUserInfoUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func execute(userInfoVO: UserInfoVO) -> AnyPublisher<Bool, Error> {
        repository.createUserInfo(userInfoVO: userInfoVO)
    }
}

