//
//  GetProfileUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/11/24.
//

import Foundation
import Combine

protocol GetProfileUseCaseProtocol {
    func execute() -> AnyPublisher<UserInfoVO, Error>
}

final class GetProfileUseCase: GetProfileUseCaseProtocol {
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<UserInfoVO, Error> {
        repository.getUserProfile()
    }
}
