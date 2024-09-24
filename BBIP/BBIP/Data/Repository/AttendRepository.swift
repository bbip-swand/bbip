//
//  AttendRepository.swift
//  BBIP
//
//  Created by 조예린 on 9/25/24.
//

import Foundation
import Combine

protocol AttendRepository{
    func getAttendCode() -> AnyPublisher<GetStatusVO, Error> //getStatus - 반환있음
    func createCode(vo:AttendVO) -> AnyPublisher<CreateCodeResponseDTO, Error> //createcode - 반환 있음
    func enterCode(vo:AttendVO) -> AnyPublisher<Void,Error> // entercode - 반환 없음
}

final class AttendRepositoryImpl: AttendRepository{
    private let dataSource: AttendDataSource
    private let createCodeMapper: CreateCodeMapper
    private let enterCodeMapper: EnterCodeMapper
    private let getStatusMapper: GetStatusMapper
    
    init(
        dataSource: AttendDataSource,
        createCodeMapper: CreateCodeMapper,
        enterCodeMapper: EnterCodeMapper,
        getStatusMapper: GetStatusMapper
    ){
        self.dataSource = dataSource
        self.createCodeMapper = createCodeMapper
        self.enterCodeMapper = enterCodeMapper
        self.getStatusMapper = getStatusMapper
    }
    
    //MARK: -GET
    func getAttendCode() -> AnyPublisher<GetStatusVO, any Error> {
        dataSource.getStatus()
            .map{dto in
                return self.getStatusMapper.toVo(dto:dto)
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: -POST
    func createCode(vo: AttendVO) -> AnyPublisher<CreateCodeResponseDTO, any Error> {
        let dto = createCodeMapper.toDTO(vo: vo)
        print("dto: \(dto)")
        return dataSource.createAttendCode(dto: dto)
            .eraseToAnyPublisher()
    }
    
    //MARK: -POST
    func enterCode(vo: AttendVO) -> AnyPublisher<Void, any Error> {
        let dto = enterCodeMapper.toDTO(vo: vo)
        print("dto: \(dto)")
        return dataSource.enterCode(dto: dto)
            .eraseToAnyPublisher()
    }
}
