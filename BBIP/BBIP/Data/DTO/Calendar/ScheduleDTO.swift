//
//  ScheduleDTO.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import Foundation

struct ScheduleDTO: Codable {
    let scheduleId: String
    let studyName: String
    let title: String
    let startDate: Date
    let endDate: Date
    let isHomeView: Bool
    let icon: Int
}
