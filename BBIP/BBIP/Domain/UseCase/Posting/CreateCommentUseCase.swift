//
//  CreateCommentUseCase.swift
//  BBIP
//
//  Created by 이건우 on 10/1/24.
//

import Combine

protocol CreateCommentUseCaseProtocol {
    func excute(postingId: String, content: String) -> AnyPublisher<Bool, Error>
}

final class CreateCommentUseCase: CreateCommentUseCaseProtocol {
    private let repository: PostingRepository
    
    init(repository: PostingRepository) {
        self.repository = repository
    }
    
    func excute(postingId: String, content: String) -> AnyPublisher<Bool, Error> {
        repository.createComment(postingId: postingId, content: content)
            .eraseToAnyPublisher()
    }
}
