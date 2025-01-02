//
//  GetFinishedStudyInfoUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/11/24.
//

import Combine

protocol GetFinishedStudyInfoUseCaseProtocol {
    func execute() -> AnyPublisher<[StudyInfoVO], Error>
}

final class GetFinishedStudyInfoUseCase: GetFinishedStudyInfoUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[StudyInfoVO], Error> {
        repository.getFinishedStudyInfo()
            .eraseToAnyPublisher()
    }
}
