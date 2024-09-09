//
//  UserInfoDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Foundation

// 유저 정보 생성 및 수정 시 사용
struct UserInfoDTO: Codable {
    let name: String
    let profileImageUrl: String
    let location: [String]
    let interest: [Int]
    let occupation: Int
    let birthYear: Int
}
