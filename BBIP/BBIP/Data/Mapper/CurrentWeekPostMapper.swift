//
//  CurrentWeekPostMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

struct CurrentWeekPostMapper {
    func toVO(dto: [PostDTO]) -> [PostVO] {
        return dto.map { dtoItem in
            let postType: PostType = dtoItem.isNotice ? .notice : .normal
            
            return PostVO(
                postId: dtoItem.postingId,
                createdAt: dtoItem.createdAt,
                studyName: dtoItem.studyName,
                title: dtoItem.title,
                content: dtoItem.content,
                postType: postType
            )
        }
    }
}
