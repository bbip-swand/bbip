//
//  ScheduleMapper.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import Foundation

struct ScheduleMapper {
    func toVO(dto: ScheduleDTO) -> ScheduleVO {
        let timeFormatter = DateFormatter.customFormatter(format: "HH:mm")
        let dateTimeFormatter = DateFormatter.customFormatter(format: "MM/dd HH:mm")
        let dateFormatter = DateFormatter.customFormatter(format: "MM/dd")
        
        // 포맷팅된 startDate와 endDate
        let formattedStartTime = timeFormatter.string(from: dto.startDate)
        let formattedEndTime = timeFormatter.string(from: dto.endDate)
        let formattedStartDateTime = dateTimeFormatter.string(from: dto.startDate)
        let formattedEndDateTime = dateTimeFormatter.string(from: dto.endDate)

        // 날짜 범위 형식
        let formattedDateRange: String
        if Calendar.current.isDate(dto.startDate, inSameDayAs: dto.endDate) {
            // 같은 날짜인 경우: "09:00 - 24:00" 형태
            formattedDateRange = "\(formattedStartTime) - \(formattedEndTime)"
        } else {
            // 다른 날짜인 경우: "9/24 00:00 - 12/31 20:00" 형태
            formattedDateRange = "\(formattedStartDateTime) - \(formattedEndDateTime)"
        }
        
        return ScheduleVO(
            scheduleId: dto.scheduleId,
            studyName: dto.studyName,
            title: dto.title,
            startDate: formattedStartTime,
            endDate: formattedEndTime,
            showAtHome: dto.isHomeView,
            iconIndex: dto.icon,
            formattedDateRange: formattedDateRange
        )
    }
}
