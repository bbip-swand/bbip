//
//  StudyRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Foundation
import Combine

protocol StudyRepository {
    func createStudy(vo: StudyInfoVO) -> AnyPublisher<CreateStudyResponseDTO, Error>
}

final class StudyRepositoryImpl: StudyRepository {
    private let dataSource: StudyDataSource
    private let mapper: StudyInfoMapper

    init(
        dataSource: StudyDataSource,
        mapper: StudyInfoMapper
    ) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func createStudy(vo: StudyInfoVO) -> AnyPublisher<CreateStudyResponseDTO, Error> {
        let dto = mapper.toDTO(vo: vo)
        print("dto: \(dto)")
        return dataSource.createStudy(dto: dto)
            .eraseToAnyPublisher()
    }
}

