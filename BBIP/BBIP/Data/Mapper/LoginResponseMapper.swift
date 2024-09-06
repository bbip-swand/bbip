//
//  LoginResponseMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/6/24.
//

import Foundation

struct LoginResponseMapper {
    func map(_ dto: LoginResponseDTO) -> LoginVO {
        return LoginVO(
            accessToken: dto.accessToken,
            isUserInfoGenerated: dto.isUserInfoGenerated
        )
    }
}
