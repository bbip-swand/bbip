//
//  AttendanceRecordMapper.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

struct AttendanceRecordMapper {
    func toVO(dto: [AttendanceRecordDTO]) -> [AttendanceRecordVO] {
        return dto.map { record in
            AttendanceRecordVO(
                session: record.session,
                userName: record.userName,
                profileImageUrl: record.profileImageUrl,
                isAttended: record.status == "ATTENDED"
            )
        }
    }
}
