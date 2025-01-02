//
//  GetCurrentWeekStudyInfoUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Combine

protocol GetCurrentWeekStudyInfoUseCaseProtocol {
    func execute() -> AnyPublisher<[CurrentWeekStudyInfoVO], Error>
}

final class GetCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[CurrentWeekStudyInfoVO], Error> {
        repository.getCurrentWeekStudyInfo()
            .eraseToAnyPublisher()
    }
}
