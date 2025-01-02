//
//  GetFullStudyInfoUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/27/24.
//

import Combine

protocol GetFullStudyInfoUseCaseProtocol {
    func execute(studyId: String) -> AnyPublisher<FullStudyInfoVO, Error>
}

final class GetFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func execute(studyId: String) -> AnyPublisher<FullStudyInfoVO, Error> {
        repository.getFullStudyInfo(studyId: studyId)
            .eraseToAnyPublisher()
    }
}
