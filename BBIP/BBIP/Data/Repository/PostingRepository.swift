//
//  PostingRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation
import Combine

protocol PostingRepository {
    func getCurrentWeekPost() -> AnyPublisher<RecentPostVO, Error>
    func getStudyPosting(studyId: String) -> AnyPublisher<RecentPostVO, Error>
}

final class PostingRepositoryImpl: PostingRepository {
    private let dataSource: PostingDataSource
    private let mapper: CurrentWeekPostMapper

    init(
        dataSource: PostingDataSource,
        mapper: CurrentWeekPostMapper
    ) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func getCurrentWeekPost() -> AnyPublisher<RecentPostVO, Error> {
        return dataSource.getCurrentWeekPosting()
            .map { [weak self] dto in
                guard let self = self else { return [] }
                return self.mapper.toVO(dto: dto)
            }
            .eraseToAnyPublisher()
    }
    
    func getStudyPosting(studyId: String) -> AnyPublisher<RecentPostVO, Error> {
        return dataSource.getStudyPosting(studyId: studyId)
            .map { [weak self] dto in
                guard let self = self else { return [] }
                return self.mapper.toVO(dto: dto)
            }
            .eraseToAnyPublisher()
    }
}
