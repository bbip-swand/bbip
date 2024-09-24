//
//  StudyInfoDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Foundation

struct StudyInfoDTO: Decodable {
    let studyId: String
    let studyName: String
    let studyImageUrl: String
    let studyField: Int
    let totalWeeks: Int
    let studyStartDate: String
    let studyEndDate: String
    let daysOfWeek: [Int]
    let studyTimes: [StudyTime]
    let studyDescription: String
    let studyContents: [String]
}
