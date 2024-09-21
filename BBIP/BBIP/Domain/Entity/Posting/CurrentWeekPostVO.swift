//
//  CurrentWeekPostVO.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

typealias CurrentWeekPostVO = [PostVO]

struct PostVO {
    let createdAt: Date
    let postingId: String
    let title: String
    let content: String
    let isNotice: Bool
}
