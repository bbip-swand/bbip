//
//  PostingAPI.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation
import Moya

enum PostingAPI {
    case getCurrentWeekPosting
    case getPostingDetail(postingId: String)                  // param
    case createPosting(dto: CreatePostingDTO)
    case createComment(postingId: String, content: String)  // param
    case getStudyPosting(studyId: String)
}

extension PostingAPI: BaseAPI {
    var path: String {
        switch self {
        case .getCurrentWeekPosting:
            return "/posting/recent"
        case .getPostingDetail(let postingId):
            return "/posting/details/\(postingId)"
        case .createPosting:
            return "/posting/create"
        case .createComment:
            return "/posting/create/comment"
        case .getStudyPosting(let studyId):
            return "/posting/all/\(studyId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentWeekPosting, .getPostingDetail, .getStudyPosting:
            return .get
        case .createPosting, .createComment:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCurrentWeekPosting, .getPostingDetail, .getStudyPosting:
            return .requestPlain
        case .createPosting(let dto):
            return .requestJSONEncodable(dto)
        case .createComment(let postingId, let content):
            let param = ["postingId": postingId]
            let body = ["content": content]
            return .requestCompositeParameters(bodyParameters: body, bodyEncoding: JSONEncoding.default, urlParameters: param)
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
