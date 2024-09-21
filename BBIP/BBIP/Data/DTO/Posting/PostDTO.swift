//
//  PostDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

struct PostDTO: Decodable {
    let createdAt: Date
    let dbPostingId: Int
    let postingId: String
    let title: String
    let content: String
    let isNotice: Bool
}

/*  {
 "createdAt": "2024-09-21T19:42:46.557Z",
 "dbPostingId": 10,
 "postingId": "33dca162-4251-44a9-a8c8-029eab983c7e",
 "title": "게시글",
 "content": "내용",
 "isNotice": false
}
*/
