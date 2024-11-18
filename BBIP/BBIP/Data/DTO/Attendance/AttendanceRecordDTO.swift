//
//  AttendanceRecordDTO.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

import Foundation

struct AttendanceRecordDTO: Decodable {
    let session: Int
    let userName: String
    let profileImageUrl: String?
    let status: String
}
