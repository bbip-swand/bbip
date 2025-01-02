//
//  UpcommingScheduleMapper.swift
//  BBIP
//
//  Created by 이건우 on 11/20/24.
//

import Foundation

struct UpcommingScheduleMapper {
    func toVO(dto: ScheduleDTO) -> UpcommingScheduleVO {
        let currentDate = Date().addingTimeInterval(60 * 60 * 9)
        let leftDay = Calendar.current.dateComponents([.day], from: currentDate, to: dto.startDate).day ?? 0
        
        return UpcommingScheduleVO(
            scheduleId: dto.scheduleId,
            iconType: dto.icon,
            leftDay: leftDay,
            description: dto.title
        )
    }
}
