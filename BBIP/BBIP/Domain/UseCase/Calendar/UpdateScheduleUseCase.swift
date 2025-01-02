//
//  UpdateScheduleUseCase.swift
//  BBIP
//
//  Created by 이건우 on 11/14/24.
//

import Combine

protocol UpdateScheduleUseCaseProtocol {
    func execute(dto: ScheduleFormDTO) -> AnyPublisher<Void, Error>
}

final class UpdateScheduleUseCase: UpdateScheduleUseCaseProtocol {
    private let repository: CalendarRepository
    
    init(repository: CalendarRepository) {
        self.repository = repository
    }
    
    func execute(dto: ScheduleFormDTO) -> AnyPublisher<Void, Error> {
        repository.updateSchedule(dto: dto)
            .eraseToAnyPublisher()
    }
}
