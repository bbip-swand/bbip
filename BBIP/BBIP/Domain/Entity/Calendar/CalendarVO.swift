//
//  CalendarVO.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import Foundation

struct CalendarVO {
    struct StudyEvent {
        let studyName: String
        let eventTitle: String
        let eventTime: String
    }
    
    let date: Date
    let events: [StudyEvent]
}
