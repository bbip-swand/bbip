//
//  UserInfoMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Foundation

struct UserInfoMapper {
    func toDTO(vo: UserInfoVO) -> UserInfoDTO {
        return UserInfoDTO(
            name: vo.userName,
            profileImageUrl: vo.profileImageUrl,
            location: vo.selectedArea.compactMap{ $0 },
            interest: vo.selectedInterestIndex,
            occupation: vo.selectedJobIndex.first!,
            birthYear: Int(vo.birthYear)!
        )
    }
}
