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
    case getStudyInfo(studyId: String)      // param
    case getInviteInfo(inviteCode: String)  // param
    case createStudy(dto: StudyInfoDTO)
    case joinStudy(studyId: String)         // param
}

extension StudyAPI: BaseAPI {
    var path: String {
        switch self {
        case .getThisWeekStudy:
            return "/study/this-week"
        case .getStudyInfo:
            return "/study"
        case .getInviteInfo:
            return "/study/invite-info"
        case .createStudy:
            return "/study/create"
        case .joinStudy:
            return "/study/join"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getThisWeekStudy:
            return .get
        case .getStudyInfo:
            return .get
        case .getInviteInfo:
            return .get
        case .createStudy:
            return .post
        case .joinStudy:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getThisWeekStudy:
            return .requestPlain
            
        case .getStudyInfo(let studyId):
            let param = ["studyId" : studyId]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .getInviteInfo(let inviteCode):
            let param = ["inviteCode" : inviteCode]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .createStudy(let dto):
            return .requestJSONEncodable(dto)
            
        case .joinStudy(let studyId):
            let param = ["studyId" : studyId]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        }
    }
}
