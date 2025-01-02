//
//  PostDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

struct PostDTO: Decodable {
    let studyName: String
    let writer: String
    let isManager: Bool?
    let profileImageUrl: String?
    let postingId: String
    let title: String
    let content: String
    let isNotice: Bool
    let createdAt: Date
    let week: Int
    let comments: [CommentDTO]?
}

/*[
 {
   "studyName": "고양이 식빵",
   "writer": "고현준",
   "isManager": false,
   "profileImageUrl": null,
   "comments": [],
   "createdAt": "2024-09-30T20:58:44.045Z",
   "postingId": "5a16b8b6-33d1-45d3-97a4-0b8a8c3a1cd8",
   "title": "강희주 퇴사 완료",
   "content": "string",
   "week": 1,
   "isNotice": false
 }
 */
