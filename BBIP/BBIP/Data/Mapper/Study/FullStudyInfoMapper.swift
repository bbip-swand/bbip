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
        var pendingDayString: String {
            let days = ["월", "화", "수", "목", "금", "토", "일"]
            return days[dto.pendingDateIndex].description
        }
        
        // VO로 변환
        return FullStudyInfoVO(
            studyName: dto.studyName,
            studyImageURL: dto.studyImageURL,
            studyField: category,
            totalWeeks: dto.totalWeeks,
            currentWeek: dto.currentWeek,
            studyPeriodString: periodString,
            daysOfWeek: dto.daysOfWeek,
            studyTimes: studyTimes,
            studyDescription: dto.studyDescription,
            studyContents: dto.studyContents,
            studyMembers: dto.studyMembers,
            pendingDate: dto.pendingDate, 
            pendingDayStr: pendingDayString,
            pendingDateTime: dto.studyTimes[dto.pendingDateIndex]
        )
    }
}
