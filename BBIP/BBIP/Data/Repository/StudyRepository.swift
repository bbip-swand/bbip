//
//  StudyRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Foundation
import Combine

protocol StudyRepository {
    func createStudy(vo: CreateStudyInfoVO) -> AnyPublisher<CreateStudyResponseDTO, Error>
    func getOngoingStudyInfo() -> AnyPublisher<[StudyInfoVO], Error>
    func getCurrentWeekStudyInfo() -> AnyPublisher<[CurrentWeekStudyInfoVO], Error>
}

final class StudyRepositoryImpl: StudyRepository {
    private let dataSource: StudyDataSource
    private let studyInfoMapper: StudyInfoMapper
    private let createStudyInfoMapper: CreateStudyInfoMapper
    private let currentWeekStudyInfoMapper: CurrentWeekStudyInfoMapper

    init(
        dataSource: StudyDataSource,
        studyInfoMapper: StudyInfoMapper,
        createStudyInfoMapper: CreateStudyInfoMapper,
        currentWeekStudyInfoMapper: CurrentWeekStudyInfoMapper
    ) {
        self.dataSource = dataSource
        self.studyInfoMapper = studyInfoMapper
        self.createStudyInfoMapper = createStudyInfoMapper
        self.currentWeekStudyInfoMapper = currentWeekStudyInfoMapper
    }
    
    func getCurrentWeekStudyInfo() -> AnyPublisher<[CurrentWeekStudyInfoVO], Error> {
        dataSource.getCurrentWeekStudyInfo()
            .map { [weak self] dtoArray in
                guard let self = self else { return [] }
                return dtoArray.map { self.currentWeekStudyInfoMapper.toVO(dto: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func getOngoingStudyInfo() -> AnyPublisher<[StudyInfoVO], Error> {
        dataSource.getOngoingStudyInfo()
            .map { [weak self] dtoArray in
                guard let self = self else { return [] }
                return dtoArray.map { self.studyInfoMapper.toVO(dto: $0) }
            }
            .eraseToAnyPublisher()
    }

    
    func createStudy(vo: CreateStudyInfoVO) -> AnyPublisher<CreateStudyResponseDTO, Error> {
        let dto = createStudyInfoMapper.toDTO(vo: vo)
        print("dto: \(dto)")
        return dataSource.createStudy(dto: dto)
            .eraseToAnyPublisher()
    }
}

