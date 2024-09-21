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
    case getPostingInfo(postingId: String)                  // param
    case createPosting(dto: PostingDTO)
    case createComment(postingId: String, content: String)  // param
}

extension PostingAPI: BaseAPI {
    var path: String {
        switch self {
        case .getCurrentWeekPosting:
            return "/posting"
        case .getPostingInfo:
            return "/posting"
        case .createPosting:
            return "/posting/create"
        case .createComment:
            return "/posting/create/comment"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentWeekPosting:
            return .get
        case .getPostingInfo:
            return .get
        case .createPosting:
            return .post
        case .createComment:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCurrentWeekPosting:
            return .requestPlain
        case .getPostingInfo(let postingId):
            let param = ["postingId" : postingId]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
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
