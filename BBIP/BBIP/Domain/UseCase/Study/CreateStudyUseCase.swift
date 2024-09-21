//
//  CreateStudyUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Combine

protocol CreateStudyUseCaseProtocol {
    func excute(studyInfoVO: StudyInfoVO) -> AnyPublisher<Bool, Error>
}

final class CreateStudyUseCase: CreateStudyUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func excute(studyInfoVO: StudyInfoVO) -> AnyPublisher<Bool, Error> {
        repository.createStudy(vo: studyInfoVO)
            .eraseToAnyPublisher()
    }
}
