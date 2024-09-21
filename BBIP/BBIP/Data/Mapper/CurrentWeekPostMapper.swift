//
//  CurrentWeekPostMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

struct CurrentWeekPostMapper {
    func toVO(dto: [PostDTO]) -> CurrentWeekPostVO {
        return dto.map { postDTO in
            PostVO(
                createdAt: postDTO.createdAt,
                postingId: postDTO.postingId,
                title: postDTO.title,
                content: postDTO.content,
                isNotice: postDTO.isNotice
            )
        }
    }
}
