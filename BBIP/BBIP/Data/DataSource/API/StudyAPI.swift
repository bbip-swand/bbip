//
//  StudyAPI.swift
//  BBIP
//
//  Created by 이건우 on 9/20/24.
//

import Foundation
import Moya

enum StudyAPI {
    case getThisWeekStudy
    case getOngoingStudy
    case getFullStudyInfo(studyId: String)      // param
    case getInviteInfo(inviteCode: String)  // param
    case createStudy(dto: CreateStudyInfoDTO)
    case joinStudy(studyId: String)         // param
}

extension StudyAPI: BaseAPI {
    var path: String {
        switch self {
        case .getThisWeekStudy:
            return "/study/this-week"
        case .getOngoingStudy:
            return "/study/ongoing"
        case .getFullStudyInfo(let studyId):
            return "/study/search/\(studyId)"
        case .getInviteInfo:
            return "/study/invite-info"
        case .createStudy:
            return "/study/create"
        case .joinStudy(let studyId):
            return "/study/join/\(studyId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getThisWeekStudy, .getOngoingStudy, .getFullStudyInfo, .getInviteInfo:
            return .get
        case .createStudy, .joinStudy:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getThisWeekStudy, .getOngoingStudy:
            return .requestPlain
            
        case .getFullStudyInfo:
            return .requestPlain
            
        case .getInviteInfo(let inviteCode):
            let param = ["inviteCode" : inviteCode]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .createStudy(let dto):
            return .requestJSONEncodable(dto)
            
        case .joinStudy(let studyId):
            let param = ["studyId": studyId]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
