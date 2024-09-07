//
//  SignUpRequestDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Foundation

struct SignUpRequestDTO: Encodable {
    let identityToken: String
    let authorizationCode: String
}
