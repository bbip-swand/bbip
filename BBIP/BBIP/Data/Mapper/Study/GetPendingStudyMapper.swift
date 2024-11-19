//
//  PendingStudyMapper.swift
//  BBIP
//
//  Created by 이건우 on 11/19/24.
//

import Foundation

struct PendingStudyMapper {
    func toVO(dto: PendingStudyDTO) -> PendingStudyVO {
        print("\(dto)")
        let dateformatter = DateFormatter.customFormatter(format: "yyyy.mm.dd")
        
        return PendingStudyVO(
            studyId: dto.studyId,
            studyName: dto.studyName,
            studyWeek: dto.studyWeek,
            studyTime: dto.studyTime.startTime + " - " + dto.studyTime.endTime,
            leftDays: dto.leftDays,
            place: dto.place.isEmpty ? "장소 미정" : dto.place
        )
    }
}
