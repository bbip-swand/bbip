//
//  CreateStudyInfoVO.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import UIKit

/// 스터디 생성시 사용되는 VO
struct CreateStudyInfoVO {
    let category: Int
    let weekCount: Int
    let startDate: Date
    let endDate: Date
    let dayIndexArr: [Int]
    let studySessionArr: [StudySessionVO]
    let name: String
    let imageURL: String
    let description: String
    let weeklyContent: [String?]
}
