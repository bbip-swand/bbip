//
//  ArchiveRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation
import Combine

protocol ArchiveRepository {
    func getArchivedFile(studyId: String) -> AnyPublisher<[ArchivedFileInfoVO], Error>
}

final class ArchiveRepositoryImpl: ArchiveRepository {
    private let dataSource: ArchiveDataSource
//    private let mapper: CurrentWeekPostMapper

    init(
        dataSource: ArchiveDataSource
//        mapper: CurrentWeekPostMapper
    ) {
        self.dataSource = dataSource
//        self.mapper = mapper
    }
    
    func getArchivedFile(studyId: String) -> AnyPublisher<[ArchivedFileInfoVO], any Error> {
        dataSource.getArchivedFile(studyId: studyId)
    }
}

