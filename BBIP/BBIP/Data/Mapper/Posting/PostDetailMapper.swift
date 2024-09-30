//
//  PostDetailMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation

struct PostDetailMapper {
    func toVO(dto: [PostDTO]) -> [PostDetailVO] {
        return dto.map { singleDTO in
            let postType: PostType = singleDTO.isNotice ? .notice : .normal
            
            let commentVOs = singleDTO.comments?.map { commentDTO in
                CommentVO(writer: commentDTO.writer,
                          content: commentDTO.content,
                          timeAgo: timeAgo(date: commentDTO.createdAt))
            } ?? []
            
            return PostDetailVO(
                postId: singleDTO.postingId,
                createdAt: singleDTO.createdAt,
                writer: singleDTO.writer,
                studyName: singleDTO.studyName,
                title: singleDTO.title,
                content: singleDTO.content,
                postType: postType,
                week: singleDTO.week,
                commnets: commentVOs
            )
        }
    }
}

