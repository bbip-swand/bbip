//
//  CalendarRepository.swift
//  BBIP
//
//  Created by 조예린 on 9/27/24.
//

import Foundation
import Combine

protocol CalendarRepository{
    func getScheduleYM(year:Int, month:Int) -> AnyPublisher<CalendarHomeVO, Error>
    func getScheduleDate(date:String) -> AnyPublisher<CalendarHomeVO,Error>
    func getUpcoming() -> AnyPublisher<CalendarHomeVO, Error>
    func createSchedule(vo:CreateScheduleVO) -> AnyPublisher<Void,Error>
    func updateSchedule(studyId: String,vo:CreateScheduleVO) -> AnyPublisher<Void,Error> //일정 생성 , response 반환없음
}

final class CalendarRepositoryImpl: CalendarRepository{
    private let dataSource: CalendarDataSource
    private let getScheduleMapper: GetScheduleMapper
    private let createScheduleMapper: CreateScheduleMapper
    
    init(
        dataSource: CalendarDataSource,
        getScheduleMapper: GetScheduleMapper,
        createScheduleMapper: CreateScheduleMapper
    ){
        self.dataSource = dataSource
        self.createScheduleMapper = createScheduleMapper
        self.getScheduleMapper = getScheduleMapper
    }
    
    //MARK: -GET
    func getScheduleYM(year: Int, month: Int) -> AnyPublisher<CalendarHomeVO, any Error>{
        dataSource.getScheduleYM(year: year, month: month)
            .map{ dto in
                return self.getScheduleMapper.toVo(dto: dto)
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: -GET
    func getScheduleDate(date: String) -> AnyPublisher<CalendarHomeVO, any Error> {
        dataSource.getScheduleDate(date: date)
            .map{ dto in
                return self.getScheduleMapper.toVo(dto: dto)
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: -GET
    func getUpcoming() -> AnyPublisher<CalendarHomeVO, any Error> {
        dataSource.getUpcoming()
            .map{ dto in
                return self.getScheduleMapper.toVo(dto: dto)
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: -POST
    func createSchedule(vo: CreateScheduleVO) -> AnyPublisher<Void, any Error> {
        let dto = createScheduleMapper.toDTO(vo: vo)
        print("dto: \(dto)")
        return dataSource.createSchedule(dto: dto)
            .eraseToAnyPublisher()
    }
    
    //MARK: -PUT
    func updateSchedule(studyId: String, vo: CreateScheduleVO) -> AnyPublisher<Void, any Error> {
        let dto = createScheduleMapper.toDTO(vo: vo)
        print("dto: \(dto)")
        return dataSource.updateSchedule(studyId: studyId, dto: dto)
            .eraseToAnyPublisher()
    }
}
