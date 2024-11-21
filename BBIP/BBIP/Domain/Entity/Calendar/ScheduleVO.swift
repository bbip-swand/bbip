//
//  ScheduleVO.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import Foundation

struct ScheduleVO: Equatable, Hashable {
    let scheduleId: String
    let studyName: String
    let title: String
    let startDate: Date
    let endDate: Date
    let showAtHome: Bool
    let iconIndex: Int
    let formattedDateRange: String
}
