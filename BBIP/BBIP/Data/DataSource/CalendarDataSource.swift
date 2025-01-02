//
//  CalendarDataSource.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

final class CalendarDataSource {
    private let provider = MoyaProvider<CalendarAPI>(plugins: [TokenPlugin()])
    
    func getMonthlySchedule(year: Int, month: Int) -> AnyPublisher<[ScheduleDTO], Error> {
        return provider.requestPublisher(.getMonthlySchedule(year: year, month: month))
            .map(\.data)
            .decode(type: [ScheduleDTO].self, decoder: JSONDecoder.iso8601WithMillisecondsDecoder())
            .mapError { error in
                error.handleDecodingError()
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func getUpcommingSchedule() -> AnyPublisher<[ScheduleDTO], Error> {
        return provider.requestPublisher(.getUpcommingSchedule)
            .map(\.data)
            .decode(type: [ScheduleDTO].self, decoder: JSONDecoder.iso8601WithMillisecondsDecoder())
            .mapError { error in
                error.handleDecodingError()
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func createSchedule(dto: ScheduleFormDTO) -> AnyPublisher<Void, Error> {
        provider.requestPublisher(.createSchedule(dto: dto))
            .map { _ in () }
            .mapError { error in
                error.handleDecodingError()
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func updateSchedule(dto: ScheduleFormDTO) -> AnyPublisher<Void, Error> {
        provider.requestPublisher(.updateschedule(dto: dto))
            .map { _ in () }
            .mapError { error in
                error.handleDecodingError()
                return error
            }
            .eraseToAnyPublisher()
    }
}
