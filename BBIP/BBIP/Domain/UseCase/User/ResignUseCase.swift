//
//  ResignUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/26/24.
//

import Combine
import Foundation

protocol ResignUseCaseProtocol {
    func execute() -> AnyPublisher<Bool, Error>
}

final class ResignUseCase: ResignUseCaseProtocol {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<Bool, Error> {
        repository.resign()
    }
}
