//
//  ScheduleFormDTO.swift
//  BBIP
//
//  Created by 이건우 on 11/14/24.
//

import Foundation

/// 일정 정보를 post, put할 때 사용합니다.
struct ScheduleFormDTO: Codable {
    let studyId: String
    let title: String
    let startDate: String
    let endDate: String
    let isHomeView: Bool
    let icon: Int
}
