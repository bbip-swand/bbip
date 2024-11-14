//
//  AddScheduleUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/14/24.
//

import Combine

protocol CreateScheduleUseCaseProtocol {
    func execute(dto: ScheduleFormDTO) -> AnyPublisher<Void, Error>
}

final class CreateScheduleUseCase: CreateScheduleUseCaseProtocol {
    private let repository: CalendarRepository
    
    init(repository: CalendarRepository) {
        self.repository = repository
    }
    
    func execute(dto: ScheduleFormDTO) -> AnyPublisher<Void, Error> {
        repository.createSchedule(dto: dto)
            .eraseToAnyPublisher()
    }
}
