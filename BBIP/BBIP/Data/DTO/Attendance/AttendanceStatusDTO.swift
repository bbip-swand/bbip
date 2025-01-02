//
//  AttendanceStatusDTO.swift
//  BBIP
//
//  Created by 이건우 on 11/18/24.
//

struct AttendanceStatusDTO: Decodable {
    let studyName: String
    let studyId: String
    let session: Int
    let startTime: String
    let ttl: Int
    let code: Int?
    let isManager: Bool
    let status: Bool
}
