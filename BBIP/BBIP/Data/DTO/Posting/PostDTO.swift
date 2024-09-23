//
//  PostDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

struct PostDTO: Decodable {
    let studyName: String
    let dbPostingId: Int
    let writer: String
    let postingId: String
    let title: String
    let content: String
    let isNotice: Bool
    let createdAt: Date
}

/* {
 "studyName": "쿠팡 상하차",
 "postingId": "6ef06ed6-f905-4538-b814-8941fa8b76a5",
 "writer": 17,
 "title": "게시글1",
 "content": "댓글1",
 "isNotice": false,
 "createdAt": "2024-09-21T21:10:14.623Z"
}
*/
