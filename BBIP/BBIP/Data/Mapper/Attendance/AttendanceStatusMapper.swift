//
//  AttendanceStatusMapper.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Foundation

struct AttendanceStatusMapper {
    func toVO(dto: AttendanceStatusDTO) -> AttendanceStatusVO {
        let formatter = ISO8601DateFormatter()
        guard let startTimeDate = formatter.date(from: dto.startTime) else {
            fatalError("Invalid date format in AttendanceStatusDTO.startTime")
        }
        
        let currentTime = Date()
        let expirationTime = startTimeDate.addingTimeInterval(TimeInterval(dto.ttl))
        let remainingTime = max(0, Int(expirationTime.timeIntervalSince(currentTime)) - 9 * 60 * 60)

        return AttendanceStatusVO(
            studyName: dto.studyName,
            studyId: dto.studyId,
            session: dto.session,
            remainingTime: remainingTime,
            code: dto.code ?? -1,
            isManager: dto.isManager,
            isAttended: dto.status
        )
    }
}
