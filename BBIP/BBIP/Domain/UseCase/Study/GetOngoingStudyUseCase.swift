//
//  GetOngoingStudyInfoUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Combine

protocol GetOngoingStudyInfoUseCaseProtocol {
    func execute() -> AnyPublisher<[StudyInfoVO], Error>
}

final class GetOngoingStudyInfoUseCase: GetOngoingStudyInfoUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[StudyInfoVO], Error> {
        repository.getOngoingStudyInfo()
            .eraseToAnyPublisher()
    }
}
