//
//  GetOngoingStudyInfoUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Combine

protocol GetOngoingStudyInfoUseCaseProtocol {
    func excute() -> AnyPublisher<[StudyInfoVO], Error>
}

final class GetOngoingStudyInfoUseCase: GetOngoingStudyInfoUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func excute() -> AnyPublisher<[StudyInfoVO], Error> {
        repository.getOngoingStudyInfo()
            .eraseToAnyPublisher()
    }
}
