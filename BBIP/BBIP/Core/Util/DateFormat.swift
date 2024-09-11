//
//  DateFormatManager.swift
//  BBIP
//
//  Created by 이건우 on 9/10/24.
//

import Foundation

func timeAgo(date: Date) -> String {
    let calendar = Calendar.current
    let now = Date()
    
    let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear], from: date, to: now)
    
    if let weeks = components.weekOfYear, weeks >= 3 {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: date)
    } else if let weeks = components.weekOfYear, weeks < 3 && weeks > 0 {
        return "\(weeks)주 전"
    } else if let days = components.day, days < 7 && days > 0 {
        return "\(days)일 전"
    } else if let hours = components.hour, hours < 24 && hours > 0 {
        return "\(hours)시간 전"
    } else if let minutes = components.minute, minutes < 60 && minutes > 0 {
        return "\(minutes)분 전"
    } else if let seconds = components.second, seconds < 60 && seconds > 0 {
        return "방금 전"
    } else {
        return "경희대 화이팅"
    }
}


