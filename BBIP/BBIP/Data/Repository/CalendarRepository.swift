//
//  CalendarRepository.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import Foundation
import Combine

protocol CalendarRepository {
    func getMonthlySchedule(year: Int, month: Int) -> AnyPublisher<[ScheduleVO], Error>
}

final class CalendarRepositoryImpl: CalendarRepository {
    private let dataSource: CalendarDataSource
    private let mapper: ScheduleMapper

    init(
        dataSource: CalendarDataSource,
        mapper: ScheduleMapper
    ) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func getMonthlySchedule(year: Int, month: Int) -> AnyPublisher<[ScheduleVO], Error> {
        dataSource.getMonthlySchedule(year: year, month: month)
            .map { [weak self] dto in
                guard let self = self else { return [] }
                return dto.map { self.mapper.toVO(dto: $0) }
            }
            .eraseToAnyPublisher()
    }
}
