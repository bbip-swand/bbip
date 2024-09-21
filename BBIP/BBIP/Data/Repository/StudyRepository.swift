//
//  StudyRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Foundation
import Combine

protocol StudyRepository {
    func createStudy(vo: StudyInfoVO) -> AnyPublisher<Bool, Error>
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
    
    func createStudy(vo: StudyInfoVO) -> AnyPublisher<Bool, Error> {
        let dto = mapper.toDTO(vo: vo)
        return dataSource.createStudy(dto: dto)
            .eraseToAnyPublisher()
    }
}

