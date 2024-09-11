//
//  CommingScheduleVO.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import Foundation

struct CommingScheduleVO {
    let iconType: Int
    let leftDay: Int
    let description: String
}

extension CommingScheduleVO {
    static func generateMock() -> [CommingScheduleVO] {
        return [
            .init(iconType: 1, leftDay: 10, description: "예술적인 소프트웨어"),
            .init(iconType: 2, leftDay: 20, description: "예술적인 소융소융"),
            .init(iconType: 3, leftDay: 30, description: "예술적인 예디예디"),
            .init(iconType: 4, leftDay: 40, description: "예술적인 두둥두둥두둥"),
            .init(iconType: 5, leftDay: 50, description: "예술적인 김치깍두기")
        ]
    }
}
