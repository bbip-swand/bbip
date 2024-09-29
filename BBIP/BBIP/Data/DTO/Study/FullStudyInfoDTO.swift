//
//  StudyFullInfoDTO.swift
//  BBIP
//
//  Created by 이건우 on 9/27/24.
//

import Foundation

/// 스터디 전체 정보 DTO
struct FullStudyInfoDTO: Decodable {
    let studyName: String
    let studyImageUrl: String?
    let studyField, totalWeeks, currentWeek: Int
    let studyStartDate, studyEndDate: String
    let daysOfWeek: [Int]
    let studyTimes: [StudyTime]
    let studyDescription: String
    let studyContents: [String]
    let studyMembers: [StudyMemberDTO]
    let pendingDate: String
    let pendingDateIndex: Int
    let studyInviteCode: String
}
