//
//  GetMonthlyScheduleUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import Combine

protocol GetMonthlyScheduleUseCaseProtocol {
    func execute(year: Int, month: Int) -> AnyPublisher<[ScheduleVO], Error>
}

final class  GetMonthlyScheduleUseCase: GetMonthlyScheduleUseCaseProtocol {
    private let repository: CalendarRepository
    
    init(repository: CalendarRepository) {
        self.repository = repository
    }
    
    func execute(year: Int, month: Int) -> AnyPublisher<[ScheduleVO], Error> {
        repository.getMonthlySchedule(year: year, month: month)
            .eraseToAnyPublisher()
    }
}
