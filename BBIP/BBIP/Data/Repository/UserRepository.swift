//
//  UserRepository.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Foundation
import Combine

protocol UserRepository {
    func signUp(signUpDTO: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, Error>
    func resign() -> AnyPublisher<Bool, Error>
    func createUserInfo(userInfoVO: UserInfoVO) -> AnyPublisher<Bool, Error>
    func updateUserInfo(userInfoVO: UserInfoVO) -> AnyPublisher<Bool, Error>
    func getUserProfile() -> AnyPublisher<UserInfoVO, Error>
}

final class UserRepositoryImpl: UserRepository {
    private let dataSource: UserDataSource
    private let mapper: UserInfoMapper

    init(
        dataSource: UserDataSource,
        mapper: UserInfoMapper
    ) {
        self.dataSource = dataSource
        self.mapper = mapper
    }

    func signUp(signUpDTO: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, Error> {
        dataSource.requestSignUp(signUpReqDTO: signUpDTO)
            .eraseToAnyPublisher()
    }
    
    func resign() -> AnyPublisher<Bool, Error> {
        dataSource.requestResign()
            .eraseToAnyPublisher()
    }

    func createUserInfo(userInfoVO: UserInfoVO) -> AnyPublisher<Bool, Error> {
        let dto = mapper.toDTO(vo: userInfoVO)
        return dataSource.createUserInfo(userInfoDTO: dto)
            .eraseToAnyPublisher()
    }

    func updateUserInfo(userInfoVO: UserInfoVO) -> AnyPublisher<Bool, Error> {
        let dto = mapper.toDTO(vo: userInfoVO)
        return dataSource.updateUserInfo(userInfoDTO: dto)
            .eraseToAnyPublisher()
    }
    
    func getUserProfile() -> AnyPublisher<UserInfoVO, Error> {
        dataSource.getUserInfo()
            .map { dto in
                return self.mapper.toVO(dto: dto)
            }
            .eraseToAnyPublisher()
    }
}

