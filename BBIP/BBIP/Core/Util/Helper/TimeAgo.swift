//
//  TimeAgo.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import Foundation

func timeAgo(date: Date) -> String {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ko_KR")
    calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!

    // let now = Date().addingTimeInterval(9 * 60 * 60) // GMT 한국 현지 시간
    
    let now = Date()
    let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear], from: date, to: now)
    
    if let weeks = components.weekOfYear, weeks >= 3 {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.timeZone = calendar.timeZone // 한국 시간대 설정
        return formatter.string(from: date)
    } else if let weeks = components.weekOfYear, weeks < 3 && weeks > 0 {
        return "\(weeks)주 전"
    } else if let days = components.day, days < 7 && days > 0 {
        return "\(days)일 전"
    } else if let hours = components.hour, hours < 24 && hours > 0 {
        return "\(hours)시간 전"
    } else if let minutes = components.minute, minutes < 60 && minutes > 0 {
        return "\(minutes)분 전"
    } else if let seconds = components.second, seconds < 60 && seconds >= 0 {
        return "방금 전"
    } else {
        return "날짜 변환 오류"
    }
}
