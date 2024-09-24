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
    func getCurrentWeekStudyInfo() -> AnyPublisher<[CurrentWeekStudyInfoVO], Error>
}

final class StudyRepositoryImpl: StudyRepository {
    private let dataSource: StudyDataSource
    private let studyInfoMapper: StudyInfoMapper
    private let currentWeekStudyInfoMapper: CurrentWeekStudyInfoMapper

    init(
        dataSource: StudyDataSource,
        studyInfoMapper: StudyInfoMapper,
        currentWeekStudyInfoMapper: CurrentWeekStudyInfoMapper
    ) {
        self.dataSource = dataSource
        self.studyInfoMapper = studyInfoMapper
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
    
//    func getOngoingStudyInfo() -> AnyPublisher<StudyInfoVO, Error> {
//        
//    }

    
    func createStudy(vo: CreateStudyInfoVO) -> AnyPublisher<CreateStudyResponseDTO, Error> {
        let dto = studyInfoMapper.toDTO(vo: vo)
        print("dto: \(dto)")
        return dataSource.createStudy(dto: dto)
            .eraseToAnyPublisher()
    }
}

