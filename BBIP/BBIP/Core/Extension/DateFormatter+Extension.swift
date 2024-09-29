//
//  DateFormatter+Extension.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Foundation

extension DateFormatter {
    /// "yyyy-MM-dd" 형식의 DateFormatter
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    /// "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX" 형식의 ISO8601 DateFormatter
    static let iso8601WithMilliseconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

/// int to 0요일
func dayName(for day: Int) -> String {
    switch day {
    case 0: return "월요일"
    case 1: return "화요일"
    case 2: return "수요일"
    case 3: return "목요일"
    case 4: return "금요일"
    case 5: return "토요일"
    case 6: return "일요일"
    default: return ""
    }
}
