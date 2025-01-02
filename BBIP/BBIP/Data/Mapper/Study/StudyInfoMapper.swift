//
//  StudyInfoMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Foundation
import UIKit

struct StudyInfoMapper {
    func toVO(dto: StudyInfoDTO) -> StudyInfoVO {
        let studyTimes = dto.studyTimes.map { dtoTime in
            return StudyInfoVO.StudyTime(
                startTime: dtoTime.startTime,
                endTime: dtoTime.endTime
            )
        }
        let category = StudyCategory.from(int: dto.studyField) ?? .others
        
        // VO로 변환
        return StudyInfoVO(
            studyId: dto.studyId,
            studyName: dto.studyName,
            imageUrl: dto.studyImageUrl,
            category: category,
            totalWeeks: dto.totalWeeks,
            studyStartDate: dto.studyStartDate.replacingOccurrences(of: "-", with: "."),
            studyEndDate: dto.studyEndDate.replacingOccurrences(of: "-", with: "."),
            studyTimes: studyTimes,
            studyDescription: dto.studyDescription ?? "",
            studyContents: dto.studyContents ?? [], 
            currentWeek: dto.currentWeek,
            isManager: dto.isManager
        )
    }
}
