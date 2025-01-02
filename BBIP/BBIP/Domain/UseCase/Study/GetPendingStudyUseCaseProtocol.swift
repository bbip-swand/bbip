//
//  GetPendingStudyUseCaseProtocol.swift
//  BBIP
//
//  Created by 이건우 on 11/19/24.
//

import Foundation
import Combine

protocol GetPendingStudyUseCaseProtocol {
    func execute() -> AnyPublisher<PendingStudyVO, Error>
}

final class GetPendingStudyUseCase: GetPendingStudyUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<PendingStudyVO, Error> {
        repository.getPendingStudy()
            .eraseToAnyPublisher()
    }
}
