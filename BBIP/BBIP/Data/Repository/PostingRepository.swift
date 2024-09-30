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
    func getPostingDetail(postingId: String) -> AnyPublisher<[PostDetailVO], Error>
}

final class PostingRepositoryImpl: PostingRepository {
    private let dataSource: PostingDataSource
    private let currentWeekPostmapper: CurrentWeekPostMapper
    private let postDetailMapper: PostDetailMapper

    init(
        dataSource: PostingDataSource,
        currentWeekPostmapper: CurrentWeekPostMapper,
        postDetailMapper: PostDetailMapper
    ) {
        self.dataSource = dataSource
        self.currentWeekPostmapper = currentWeekPostmapper
        self.postDetailMapper = postDetailMapper
    }
    
    func getCurrentWeekPost() -> AnyPublisher<RecentPostVO, Error> {
        return dataSource.getCurrentWeekPosting()
            .map { [weak self] dto in
                guard let self = self else { return [] }
                return self.currentWeekPostmapper.toVO(dto: dto)
            }
            .eraseToAnyPublisher()
    }
    
    func getStudyPosting(studyId: String) -> AnyPublisher<RecentPostVO, Error> {
        return dataSource.getStudyPosting(studyId: studyId)
            .map { [weak self] dto in
                guard let self = self else { return [] }
                return self.currentWeekPostmapper.toVO(dto: dto)
            }
            .eraseToAnyPublisher()
    }
    
    func getPostingDetail(postingId: String) -> AnyPublisher<[PostDetailVO], Error> {
        return dataSource.getPostingDetails(postingId: postingId)
            .map { [weak self] dto in
                guard let self = self else { return [] }
                return self.postDetailMapper.toVO(dto: dto)
            }
            .eraseToAnyPublisher()
    }
}
