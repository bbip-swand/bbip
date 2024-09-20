//
//  StudyInfoVO.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import UIKit

struct StudyInfoVO {
    let category: Int
    let weekCount: Int
    let startDate: Date
    let endDate: Date
    let dayIndexArr: [Int]
    let studySessionArr: [StudySessionVO]
    let name: String
    let thumbnail: UIImage?
    let description: String
    let weeklyContent: [String?]
}
