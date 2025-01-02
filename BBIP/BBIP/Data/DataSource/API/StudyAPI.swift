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
    case getFinishedStudy
    case getFullStudyInfo(studyId: String)      // param
    case getInviteInfo(inviteCode: String)      // param
    case createStudy(dto: CreateStudyInfoDTO)
    case joinStudy(studyId: String)             // param
    case editStudyLocation(studyId: String, session: Int, location: String)
    case getPendingStudy
}

extension StudyAPI: BaseAPI {
    var path: String {
        switch self {
        case .getThisWeekStudy:
            return "/study/this-week"
        case .getOngoingStudy:
            return "/study/ongoing"
        case .getFinishedStudy:
            return "/study/finished"
        case .getFullStudyInfo(let studyId):
            return "/study/search/\(studyId)"
        case .getInviteInfo:
            return "/study/invite-info"
        case .createStudy:
            return "/study/create"
        case .joinStudy(let studyId):
            return "/study/join/\(studyId)"
        case .editStudyLocation(let studyId, _, _):
            return "/study/place/\(studyId)"
        case .getPendingStudy:
            return "/study/pending"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getThisWeekStudy, .getOngoingStudy, .getFinishedStudy, .getFullStudyInfo, .getInviteInfo, .getPendingStudy:
            return .get
        case .createStudy, .joinStudy:
            return .post
        case .editStudyLocation:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getThisWeekStudy, .getOngoingStudy, .getFinishedStudy, .getFullStudyInfo, .getPendingStudy:
            return .requestPlain
            
        case .getInviteInfo(let inviteCode):
            let param = ["inviteCode" : inviteCode]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
            
        case .createStudy(let dto):
            return .requestJSONEncodable(dto)
            
        case .joinStudy(let studyId):
            let param = ["studyId": studyId]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case .editStudyLocation(_, let session, let location):
            let param = ["session" : session, "place" : location] as [String : Any]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
}
