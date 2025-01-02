//
//  GetUpcommingScheduleUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import Combine

protocol GetUpcommingScheduleUseCaseProtocol {
    func execute() -> AnyPublisher<[UpcommingScheduleVO], Error>
}

final class GetUpcommingScheduleUseCase: GetUpcommingScheduleUseCaseProtocol {
    private let repository: CalendarRepository
    
    init(repository: CalendarRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[UpcommingScheduleVO], Error> {
        repository.getUpcommingSchdule()
            .eraseToAnyPublisher()
    }
}
