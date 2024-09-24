//
//  AttendDataSource.swift
//  BBIP
//
//  Created by 조예린 on 9/23/24.
//

import Foundation
import Combine
import Moya
import CombineMoya

final class AttendDataSource{
    private let provider = MoyaProvider<AttendanceAPI>(plugins: [TokenPlugin()])
    
    //MARK: - POST
    func createAttendCode(dto: CreateCodeDTO) -> AnyPublisher<CreateCodeResponseDTO, Error> {
        provider.requestPublisher(.createCode(dto: dto))
            .tryMap{ response in
                guard (200...299).contains(response.statusCode) else{
                    throw NSError(
                        domain: "CreateCode Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[CreateCodeDataSource] createAttendCode() failed with status code \(response.statusCode)"]
                    )
                }
                return response.data
            }
            .decode(type: CreateCodeResponseDTO.self, decoder: JSONDecoder())
            .mapError {error in
                return error}
            .eraseToAnyPublisher()
    }
    
    //MARK: -POST
    func enterCode(dto: EnterCodeDTO) -> AnyPublisher<Void,Error>{
        provider.requestPublisher(.enterCode(dto: dto))
            .tryMap{response in
                guard(200...299).contains(response.statusCode) else{
                    throw NSError(
                        domain: "EnterCode Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey:"[EnterCodeDataSource] enterCode() failed with status code \(response.statusCode)"]
                    )
                }
                return ()
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: -GET
    func getStatus() -> AnyPublisher<GetStatusResponseDTO,Error>{
        provider.requestPublisher(.getStatus)
            .tryMap{response in
                guard (200...299).contains(response.statusCode) else {
                    throw NSError(
                        domain: "Get Attendance Code Error",
                        code: response.statusCode,
                        userInfo: [NSLocalizedDescriptionKey: "[GetStatusDataSource] getStatus() failed with status code \(response.statusCode)"]
                    )
                }
                return response.data
            }
            .decode(type: GetStatusResponseDTO.self, decoder:JSONDecoder.iso8601WithMillisecondsDecoder())
            .mapError{ error in
                return error}
            .eraseToAnyPublisher()
    }
}
