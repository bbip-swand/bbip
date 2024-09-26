//
//  updateScheduleUseCase.swift
//  BBIP
//
//  Created by 조예린 on 9/27/24.
//

import Foundation
import Combine

protocol UpdateScheduleUseCaseProtocol{
    func execute(studyId:String, calendarVO:CreateScheduleVO) -> AnyPublisher<Void,Error>
}

final class UpdateScheduleUseCase: UpdateScheduleUseCaseProtocol{
    private let repository: CalendarRepository
    
    init(repository: CalendarRepository){
        self.repository = repository
    }
    
    func execute(studyId: String, calendarVO: CreateScheduleVO) -> AnyPublisher<Void, any Error> {
        return repository.updateSchedule(studyId: studyId, vo: calendarVO)
            .eraseToAnyPublisher()
    }
}
