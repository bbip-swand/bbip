//
//  CalendarAPI.swift
//  BBIP
//
//  Created by 이건우 on 11/12/24.
//

import Foundation
import Moya

enum CalendarAPI {
    case getMonthlySchedule(year: Int, month: Int)
    case getUpcommingSchedule                       // for main view
    case createSchedule(dto: ScheduleDTO)
    case updateschedule(dto: ScheduleDTO)
}

extension CalendarAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMonthlySchedule(let year, let month):
            return "/calendar/list/\(year)/\(month)"
        case .getUpcommingSchedule:
            return "/calendar/schedule/upcoming"
        case .createSchedule(let dto):
            return "calendar/create"
        case .updateschedule(let dto):
            return "/calendar/update/\(dto.scheduleId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMonthlySchedule, .getUpcommingSchedule:
            return .get
        case .createSchedule:
            return .post
        case .updateschedule:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getMonthlySchedule, .getUpcommingSchedule:
            return .requestPlain
        case .createSchedule(let dto):
            return .requestJSONEncodable(dto)
        case .updateschedule(let dto):
            return .requestJSONEncodable(dto)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
