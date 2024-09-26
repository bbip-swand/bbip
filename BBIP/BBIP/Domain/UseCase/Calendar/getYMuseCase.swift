//
//  getScheduleYMuseCase.swift
//  BBIP
//
//  Created by 조예린 on 9/27/24.
//

import Foundation
import Combine

protocol GetYMUseCaseProtocol{
    func execute(year:Int, month:Int) -> AnyPublisher<CalendarHomeVO, Error>
}

final class GetYMUseCase: GetYMUseCaseProtocol{
    private let repository: CalendarRepository
    
    init(repository: CalendarRepository){
        self.repository = repository
    }
    
    func execute(year:Int, month:Int) -> AnyPublisher<CalendarHomeVO,Error>{
        return repository.getScheduleYM(year: year, month: month)
            .eraseToAnyPublisher()
    }
}
