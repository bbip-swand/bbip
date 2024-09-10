//
//  CurrentWeekStudyInfoVO.swift
//  BBIP
//
//  Created by 이건우 on 9/9/24.
//

import Foundation

struct CurrentWeekStudyInfoVO {
    let imageUrl: String?
    let title: String
    let category: StudyCategory
    let currentStudyRound: Int
    let currentStudyDescription: String?
    let date: String
    let time: String
    let location: String
}
