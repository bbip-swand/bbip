//
//  StudyInfoVO.swift
//  BBIP
//
//  Created by 이건우 on 9/9/24.
//

import Foundation

typealias CurrentWeekStudyInfoVO = [StudyInfoVO]

/// 앱 내부에서 사용되는 스터디 정보 VO
struct StudyInfoVO {
    let studyId: String
    let imageUrl: String?
    let title: String
    let category: StudyCategory
    let currentStudyRound: Int
    let currentStudyDescription: String?
    let date: String
    let time: String
    let location: String
}
