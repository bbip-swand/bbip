//
//  GetCurrentWeekStudyInfoUseCase.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Combine

protocol GetCurrentWeekStudyInfoUseCaseProtocol {
    func excute() -> AnyPublisher<[CurrentWeekStudyInfoVO], Error>
}

final class GetCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
    
    func excute() -> AnyPublisher<[CurrentWeekStudyInfoVO], Error> {
        repository.getCurrentWeekStudyInfo()
            .eraseToAnyPublisher()
    }
}
