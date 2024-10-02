
//
//  GetStudyPostingUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/29/24.
//

import Foundation
import Combine

protocol GetStudyPostingUseCaseProtocol {
    func excute(studyId: String) -> AnyPublisher<RecentPostVO, Error>
}

final class GetStudyPostingUseCase: GetStudyPostingUseCaseProtocol {
    private let repository: PostingRepository
    
    init(repository: PostingRepository) {
        self.repository = repository
    }
    
    func excute(studyId: String) -> AnyPublisher<RecentPostVO, Error> {
        repository.getStudyPosting(studyId: studyId)
            .eraseToAnyPublisher()
    }
}
//
//  GetStudyPostingUseCase.swift
//  BBIP
//
//  Created by 조예린 on 10/2/24.
//

import Foundation
