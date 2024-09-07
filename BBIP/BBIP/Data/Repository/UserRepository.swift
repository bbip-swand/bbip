//
//  UserRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
    func signUp(signUpDTO: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, Error>
    func resign() -> AnyPublisher<Bool, Error>
    func createUserInfo(userInfoDTO: UserInfoDTO) -> AnyPublisher<Bool, Error>
    func updateUserInfo(userInfoDTO: UserInfoDTO) -> AnyPublisher<Bool, Error>
}

final class UserRepository: UserRepositoryProtocol {
    private let dataSource: UserDataSource
    // mapper 아직 필요 없음

    init(dataSource: UserDataSource) {
        self.dataSource = dataSource
    }

    func signUp(signUpDTO: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, Error> {
        dataSource.requestSignUp(signUpReqDTO: signUpDTO)
            .eraseToAnyPublisher()
    }
    
    func resign() -> AnyPublisher<Bool, Error> {
        dataSource.requestResign()
            .eraseToAnyPublisher()
    }

    func createUserInfo(userInfoDTO: UserInfoDTO) -> AnyPublisher<Bool, Error> {
        dataSource.createUserInfo(userInfoDTO: userInfoDTO)
            .eraseToAnyPublisher()
    }

    func updateUserInfo(userInfoDTO: UserInfoDTO) -> AnyPublisher<Bool, Error> {
        dataSource.updateUserInfo(userInfoDTO: userInfoDTO)
            .eraseToAnyPublisher()
    }
}

