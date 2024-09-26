//
//  JoinStudyUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/26/24.
//

import Combine

protocol JoinStudyUseCaseProtocol {
    func excute(studyId: String) -> AnyPublisher<Bool, Error>
}

final class JoinStudyUseCase: JoinStudyUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func excute(studyId: String) -> AnyPublisher<Bool, Error> {
        repository.joinStudy(studyId: studyId)
            .eraseToAnyPublisher()
    }
}
