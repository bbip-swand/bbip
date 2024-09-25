//
//  CreateStudyInfoMapper.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Foundation

struct CreateStudyInfoMapper {
    func toDTO(vo: CreateStudyInfoVO) -> CreateStudyInfoDTO {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let sessionTimeDateFormatter = DateFormatter()
        sessionTimeDateFormatter.dateFormat = "HH:mm"
        
        // StudyTime 변환
        let studyTimes = vo.studySessionArr.map { session in
            return StudyTime(
                startTime: sessionTimeDateFormatter.string(from: session.startTime!),
                endTime: sessionTimeDateFormatter.string(from: session.endTime!)
            )
        }
        
        // DTO 변환
        return CreateStudyInfoDTO(
            studyName: vo.name,
            studyImageUrl: vo.imageURL,
            studyField: vo.category,
            totalWeeks: vo.weekCount,
            studyStartDate: dateFormatter.string(from: vo.startDate),
            studyEndDate: dateFormatter.string(from: vo.endDate),
            daysOfWeek: vo.dayIndexArr,
            studyTimes: studyTimes,
            studyDescription: vo.description,
            studyContents: vo.weeklyContent.map { $0 ?? "" }
        )
    }
}
