//
//  CreateStudyContent.swift
//  BBIP
//
//  Created by 이건우 on 8/30/24.
//

import Foundation

/// 스터디 생성 화면에서 사용되는 content 데이터
struct CreateStudyContent {
    let title: String
    let subTitle: String
    
    init(
        title: String,
        subTitle: String
    ) {
        self.title = title
        self.subTitle = subTitle
    }
}

extension CreateStudyContent {
    static func generate() -> [CreateStudyContent] {
        return [
            CreateStudyContent(title: "출전 분야를 선택해주세요", subTitle: "스터디 분야는 1개만 선택 가능합니다"),
            CreateStudyContent(title: "진행할 라운드와 횟수를 선택해주세요", subTitle: "주차와 횟수는 생성 후에도 수정 가능합니다"),
            CreateStudyContent(title: "팀 프로필을 작성해주세요", subTitle: "스터디의 방향이 잘 보이는 이름을 지어주세요"),
            CreateStudyContent(title: "스터디의 한 줄 소개를 적어주세요", subTitle: "스터디원에게 가장 먼저 보이는 소개글이에요"),
            CreateStudyContent(title: "주차별 계획을 작성해주세요", subTitle: "효율적인 시간 관리를 통해 목표를 달성해 보세요")
        ]
    }
}

