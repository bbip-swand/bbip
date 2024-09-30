//
//  CommentDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation

struct CommentDTO: Decodable {
    let writer: String
    let content: String
    let createdAt: Date
}
