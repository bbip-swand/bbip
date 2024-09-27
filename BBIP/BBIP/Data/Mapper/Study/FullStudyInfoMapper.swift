//
//  FullStudyInfoMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/27/24.
//

import Foundation

struct FullStudyInfoMapper {
    func toVO(dto: FullStudyInfoDTO) -> FullStudyInfoVO {
        let studyTimes = dto.studyTimes.map { dtoTime in
            return StudyTime(
                startTime: dtoTime.startTime,
                endTime: dtoTime.endTime
            )
        }
        let category = StudyCategory.from(int: dto.studyField) ?? .others
        var periodString: String {
            dto.studyStartDate.replacingOccurrences(of: "-", with: ".") +
            " ~ " +
            dto.studyEndDate.replacingOccurrences(of: "-", with: ".")
        }
        var pendingDateTimeStr: String {
            let times = dto.studyTimes[dto.pendingDateIndex]
            return "\(times.startTime) ~ \(times.endTime)"
        }
        
        // VO로 변환
        return FullStudyInfoVO(
            studyName: dto.studyName,
            studyImageURL: dto.studyImageURL,
            studyField: category,
            totalWeeks: dto.totalWeeks,
            currentWeek: dto.currentWeek,
            currentWeekContent: dto.studyContents[dto.currentWeek],
            studyPeriodString: periodString,
            daysOfWeek: dto.daysOfWeek,
            studyTimes: studyTimes,
            studyDescription: dto.studyDescription,
            studyContents: dto.studyContents,
            studyMembers: dto.studyMembers,
            pendingDateStr: dto.pendingDate,
            pendingDateTimeStr: pendingDateTimeStr
        )
    }
}
