//
//  AttendanceRecordVO.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Foundation

struct AttendanceRecordVO: Identifiable {
    let id: UUID = UUID()
    let session: Int
    let userName: String
    let profileImageUrl: String?
    let isAttended: Bool
}
