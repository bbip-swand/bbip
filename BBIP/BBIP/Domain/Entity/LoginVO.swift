//
//  LoginVO.swift
//  BBIP
//
//  Created by 이건우 on 9/6/24.
//

import Foundation

struct LoginVO: Encodable {
    let accessToken: String
    let isUserInfoGenerated: Bool
}
