//
//  FullStudyInfoVO.swift
//  BBIP
//
//  Created by 이건우 on 9/27/24.
//

import Foundation

/// 스터디 전체 정보 VO, 스터디 홈에서 사용
struct FullStudyInfoVO {
    let studyName: String
    let studyImageURL: String?
    let studyField: StudyCategory
    let totalWeeks, currentWeek: Int
    let studyPeriodString: String
    let daysOfWeek: [Int]
    let studyTimes: [StudyTime]
    let studyDescription: String
    let studyContents: [String]
    let studyMembers: [StudyMemberDTO]
    
    let pendingDate: String
    let pendingDayStr: String
    let pendingDateTime: StudyTime
}

extension FullStudyInfoVO {
    static func mock() -> FullStudyInfoVO {
        return FullStudyInfoVO(
            studyName: "고양이 식빵",
            studyImageURL: "https://bbip-s3-bucket.s3.amazonaws.com/images/sample_study_image.jpg",
            studyField: .certification,
            totalWeeks: 6,
            currentWeek: 2,
            studyPeriodString: "2024-09-25 ~ 2024-11-07",
            daysOfWeek: [2, 4],
            studyTimes: [
                StudyTime(startTime: "09:00", endTime: "11:00"),
                StudyTime(startTime: "14:00", endTime: "16:00")
            ],
            studyDescription: "고양이 식빵을 탐구해보는 스터디입니다.",
            studyContents: ["준비물: 고양이 식빵", "기타 내용 1", "기타 내용 2"],
            studyMembers: [
                StudyMemberDTO(memberName: "김강릉", isManager: true, memberImageURL: "https://bbip-s3-bucket.s3.amazonaws.com/images/member1.jpg", interest: ["5", "4", "3"]),
                StudyMemberDTO(memberName: "채지영", isManager: false, memberImageURL: nil, interest: ["0"]),
                StudyMemberDTO(memberName: "강희주", isManager: false, memberImageURL: nil, interest: ["7"]),
                StudyMemberDTO(memberName: "고현준", isManager: false, memberImageURL: nil, interest: ["5"])
            ],
            pendingDate: "2024-10-01",
            pendingDayStr: "화요일",
            pendingDateTime: StudyTime(startTime: "09:00", endTime: "11:00")
        )
    }
}
