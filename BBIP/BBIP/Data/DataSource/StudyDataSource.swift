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
            .decode(type: [CurrentWeekStudyInfoDTO].self, decoder: JSONDecoder.yyyyMMddDecoder())
            .eraseToAnyPublisher()
    }
    
    func getOngoingStudyInfo() -> AnyPublisher<[StudyInfoDTO], Error> {
        provider.requestPublisher(.getOngoingStudy)
            .map(\.data)
            .decode(type: [StudyInfoDTO].self, decoder: JSONDecoder.yyyyMMddDecoder())
            .eraseToAnyPublisher()
    }

    
    // MARK: - POST
    func createStudy(dto: CreateStudyInfoDTO) -> AnyPublisher<CreateStudyResponseDTO, Error> {
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
    
    func joinStudy(studyId: String) -> AnyPublisher<Bool, Error> {
        provider.requestPublisher(.joinStudy(studyId: studyId))
            .tryMap { response in
                print(String(data: response.data, encoding: .utf8))
                print(response.statusCode)
                if (200...299).contains(response.statusCode) {
                    return true
                } else if response.statusCode == 400 {
                    return false // already study member
                } else {
                    throw NSError(
                        domain: "joinStudy Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[StudyDataSource] createStudy() failed with status code \(response.statusCode)"]
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
