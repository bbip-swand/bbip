//
//  CommingScheduleVO.swift
//  BBIP
//
//  Created by 이건우 on 9/11/24.
//

import Foundation

struct UpcommingScheduleVO {
    let scheduleId: String
    let iconType: Int
    let leftDay: Int
    let description: String
}

extension UpcommingScheduleVO {
    static func placeholderVO() -> UpcommingScheduleVO {
        .init(scheduleId: "", iconType: 0, leftDay: 0, description: "placeholder")
    }
}
