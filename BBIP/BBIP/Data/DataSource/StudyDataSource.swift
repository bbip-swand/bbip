//
//  StudyDataSource.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

final class StudyDataSource {
    private let provider = MoyaProvider<StudyAPI>(plugins: [TokenPlugin()])
    
    // MARK: - GET
    func getCurrentWeekStudyInfo() -> AnyPublisher<[CurrentWeekStudyInfoDTO], Error> {
        provider.requestPublisher(.getThisWeekStudy)
            .map(\.data)
            .decode(type: [CurrentWeekStudyInfoDTO].self, decoder: JSONDecoder.iso8601WithMillisecondsDecoder())
            .eraseToAnyPublisher()
    }
    
    // MARK: - POST
    func createStudy(dto: StudyInfoDTO) -> AnyPublisher<CreateStudyResponseDTO, Error> {
        provider.requestPublisher(.createStudy(dto: dto))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "CreateStudy Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[StudyDataSource] createStudy() failed with status code \(response.statusCode)"]
                    )
                }
                return response.data
            }
            .decode(type: CreateStudyResponseDTO.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
