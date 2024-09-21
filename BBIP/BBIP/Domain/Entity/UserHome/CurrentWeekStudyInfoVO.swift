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

extension CurrentWeekStudyInfoVO {
    static func generateMock() -> [CurrentWeekStudyInfoVO] {
        return [
            CurrentWeekStudyInfoVO(
                imageUrl: nil,
                title: "JLPT N2 청해 스터디",
                category: .art,
                currentStudyRound: 1,
                currentStudyDescription: "단어 시험, 교재 300~320p",
                date: "8월 13일",
                time: "12:00 ~ 15:00",
                location: "스타벅스 강남역점"
            ),
            CurrentWeekStudyInfoVO(
                imageUrl: nil,
                title: "JLPT N2 청해 스터디",
                category: .science,
                currentStudyRound: 1,
                currentStudyDescription: "단어 시험, 교재 300~320p",
                date: "8월 13일",
                time: "12:00 ~ 15:00",
                location: "스타벅스 강남역점"
            ),
            CurrentWeekStudyInfoVO(
                imageUrl: nil,
                title: "JLPT N2 청해 스터디",
                category: .history,
                currentStudyRound: 1,
                currentStudyDescription: "단어 시험, 교재 300~320p",
                date: "8월 13일",
                time: "12:00 ~ 15:00",
                location: "스타벅스 강남역점"
            )
        ]
    }
}
