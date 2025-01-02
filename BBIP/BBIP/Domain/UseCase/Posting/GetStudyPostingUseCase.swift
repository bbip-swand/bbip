//
//  GetStudyPostingUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/29/24.
//

import Foundation
import Combine

protocol GetStudyPostingUseCaseProtocol {
    func execute(studyId: String) -> AnyPublisher<RecentPostVO, Error>
}

final class GetStudyPostingUseCase: GetStudyPostingUseCaseProtocol {
    private let repository: PostingRepository
    
    init(repository: PostingRepository) {
        self.repository = repository
    }
    
    func execute(studyId: String) -> AnyPublisher<RecentPostVO, Error> {
        repository.getStudyPosting(studyId: studyId)
            .eraseToAnyPublisher()
    }
}

