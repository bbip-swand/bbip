//
//  CreatePostingUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import Combine

protocol CreatePostingUseCaseProtocol {
    func excute(dto: CreatePostingDTO) -> AnyPublisher<Bool, Error>
}

final class CreatePostingUseCase: CreatePostingUseCaseProtocol {
    private let repository: PostingRepository
    
    init(repository: PostingRepository) {
        self.repository = repository
    }
    
    func excute(dto: CreatePostingDTO) -> AnyPublisher<Bool, Error> {
        repository.createPosting(dto: dto)
            .eraseToAnyPublisher()
    }
}
