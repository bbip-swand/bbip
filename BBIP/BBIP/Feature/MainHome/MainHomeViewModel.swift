//
//  MainHomeViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import Foundation

class MainHomeViewModel: ObservableObject {
    @Published var homeBulletnData = generateHomeBulletnData()
    @Published var currentWeekStudyData = generateCurrentWeekStudyData()
}

extension MainHomeViewModel {
    static func generateHomeBulletnData() -> [HomeBulletnboardPostVO] {
        return [
            HomeBulletnboardPostVO(postType: .notice, studyName: "포트폴리오 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-10000)),
            HomeBulletnboardPostVO(postType: .normal, studyName: "JLPT N2 청해 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-30000)),
            HomeBulletnboardPostVO(postType: .notice, studyName: "포트폴리오 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-300000)),
            HomeBulletnboardPostVO(postType: .normal, studyName: "JLPT N2 청해 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-4000000)),
            HomeBulletnboardPostVO(postType: .notice, studyName: "포트폴리오 스터디", postContent: "오늘 스터디는 강서구 카페베네에서 진행합니다", createdAt: Date().addingTimeInterval(-5000000))
        ]
    }
    
    static func generateCurrentWeekStudyData() -> [CurrentWeekStudyInfoVO] {
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

