//
//  PostingDataSource.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

final class PostingDataSource {
    private let provider = MoyaProvider<PostingAPI>(plugins: [TokenPlugin()])

    func getCurrentWeekPosting() -> AnyPublisher<[PostDTO], Error> {
        return provider.requestPublisher(.getCurrentWeekPosting)
            .map(\.data)
            .decode(type: [PostDTO].self, decoder: JSONDecoder.iso8601WithMillisecondsDecoder())
            .mapError { error in
                print("Error: \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func getStudyPosting(studyId: String) -> AnyPublisher<[PostDTO], Error> {
        return provider.requestPublisher(.getStudyPosting(studyId: studyId))
            .map(\.data)
            .decode(type: [PostDTO].self, decoder: JSONDecoder.iso8601WithMillisecondsDecoder())
            .mapError { error in
                print("Error: \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func getPostingDetails(postingId: String) -> AnyPublisher<PostDTO, Error> {
        return provider.requestPublisher(.getPostingDetail(postingId: postingId))
            .map(\.data)
            .decode(type: PostDTO.self, decoder: JSONDecoder.iso8601WithMillisecondsDecoder())
            .mapError { error in
                error.handleDecodingError()
                return error
            }
            .eraseToAnyPublisher()
    }
}
