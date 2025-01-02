//
//  PendingStudyDTO.swift
//  BBIP
//
//  Created by 이건우 on 11/19/24.
//

import Foundation

struct PendingStudyDTO: Decodable {
    let studyId: String
    let studyName: String
    let studyWeek: Int
    let startDate: String
    let studyTime: StudyTime
    let leftDays: Int
    let place: String
    let totalWeeks: Int
}
