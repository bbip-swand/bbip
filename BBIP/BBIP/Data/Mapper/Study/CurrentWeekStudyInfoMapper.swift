//
//  CurrentWeekStudyInfoMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Foundation

struct CurrentWeekStudyInfoMapper {
    func toVO(dto: CurrentWeekStudyInfoDTO) -> StudyInfoVO {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"

        var timeString: String {
            timeFormatter.string(from: dto.studyTime.startTime) + " ~ " + timeFormatter.string(from: dto.studyTime.endTime)
        }
        
        return StudyInfoVO(
            studyId: dto.studyId,
            imageUrl: dto.studyImageUrl,
            title: dto.studyName,
            category: .from(int: dto.studyField) ?? .others,
            currentStudyRound: dto.studyWeek,
            currentStudyDescription: dto.studyContent,
            date: dateFormatter.string(from: dto.studyDate),
            time: timeString,
            location: "미정"
        )
    }
}
