//
//  AttendanceMapper.swift
//  BBIP
//
//  Created by 조예린 on 9/25/24.
//

import Foundation
import UIKit

struct CreateCodeMapper {
    func toDTO(vo:AttendVO) -> CreateCodeDTO{
        return CreateCodeDTO(studyId: vo.studyId, session: vo.session)
    }
}

struct EnterCodeMapper{
    func toDTO(vo:AttendVO) -> EnterCodeDTO{
        return EnterCodeDTO(studyId: vo.studyId, code: vo.code)
    }
}

struct GetStatusMapper{
    func toVo(dto:GetStatusResponseDTO) -> GetStatusVO{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") // "오전/오후"를 처리하기 위해 로케일 설정
        dateFormatter.dateFormat = "yyyy. M. d. a h:mm:ss"
        
        let startTime: Date = dateFormatter.date(from: dto.startTime) ?? Date()
        
        return GetStatusVO(
                    studyName: dto.studyId,
                    studyId: dto.studyId,
                    session: dto.ttl,
                    startTime: startTime,
                    ttl: dto.ttl
                )
    }
}

struct GetAttendRecordMapper{
    func toVO(dto:GetAttendRecordDTO) -> getAttendRecordVO{
        return getAttendRecordVO(session: dto.session, userName: dto.userName, profileImageUrl: dto.profileImageUrl, status: dto.status)
    }
}
