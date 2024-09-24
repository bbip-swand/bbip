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
        
        return StudyInfoVO(
            studyId: dto.studyId,
            imageUrl: dto.studyImageUrl,
            title: dto.studyName,
            category: .from(int: dto.studyField) ?? .others,
            currentStudyRound: dto.studyWeek,
            currentStudyDescription: dto.studyContent,
            date: dateFormatter.string(from: dto.studyDate),
            time: dto.studyTime.startTime + " ~ " + dto.studyTime.endTime,
            location: "미정"
        )
    }
}
