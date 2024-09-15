//
//  StudySessionVO.swift
//  BBIP
//
//  Created by 이건우 on 9/15/24.
//

import Foundation

struct StudySessionVO: Identifiable {
    let id = UUID()  // 각 객체에 고유 ID 부여
    var startTime: Date? // 시작 시간
    var endTime: Date? // 마감 시간
    
    static func emptySession() -> StudySessionVO {
        StudySessionVO(startTime: nil, endTime: nil)
    }
    
    func duration() -> TimeInterval {
        return endTime!.timeIntervalSince(startTime!) // 세션의 지속 시간
    }
}
