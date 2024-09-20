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
    
    func createStudy(dto: StudyInfoDTO) -> AnyPublisher<Bool, Error> {
        provider.requestPublisher(.createStudy(dto: dto))
            .tryMap { response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "CreateStudy Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[StudyDataSource] createStudy() failed with status code \(response.statusCode)"]
                    )
                }
                return true
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
