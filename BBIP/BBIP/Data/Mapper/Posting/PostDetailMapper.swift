//
//  PostDetailMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation

struct PostDetailMapper {
    static func map(dto: PostDTO) -> PostDetailVO {
        let postType: PostType = dto.isNotice ? .notice : .normal
        
        let commentVOs = dto.comments?.map { commentDTO in
            CommentVO(writer: commentDTO.writer,
                      content: commentDTO.content,
                      timeAgo: timeAgo(date: commentDTO.createdAt))
        } ?? []
        
        return PostDetailVO(
            postId: dto.postingId,
            createdAt: dto.createdAt,
            writer: dto.writer,
            studyName: dto.studyName,
            title: dto.title,
            content: dto.content,
            postType: postType,
            week: dto.week,
            commnets: commentVOs
        )
    }
}

