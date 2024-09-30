//
//  PostDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

struct PostDTO: Decodable {
    let studyName: String
    let postingId: String
    let writer: String
    let title: String
    let content: String
    let isNotice: Bool
    let createdAt: Date
    let week: Int
    let comments: [CommentDTO]?
}

/*[
 {
   "studyName": "쿠팡 상하차 스터디",
   "postingId": "b01d0657-b9e3-4de7-9769-16ac0f69d3c8",
   "writer": "김강릉",
   "title": "오늘은 서울에서 진행합니다",
   "content": "다들 일정 확인해주세요",
   "isNotice": false,
   "createdAt": "2024-09-23T17:35:52.822Z"
 }
]
 */
