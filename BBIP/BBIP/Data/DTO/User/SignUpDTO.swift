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
    let fcmToken: String
}

// DTO와 VO가 같아 통일함
struct SignUpResponseDTO: Decodable {
    let accessToken: String
}
