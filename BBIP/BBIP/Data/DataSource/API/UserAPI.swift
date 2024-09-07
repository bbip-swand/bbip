//
//  UserAPI.swift
//  BBIP
//
//  Created by 이건우 on 9/7/24.
//

import Moya

enum UserAPI {
    case signUp(dto: SignUpRequestDTO)
    case resign
    case info(dto: UserInfoDTO)
    case updateInfo(dto: UserInfoDTO)
}

extension UserAPI: BaseAPI {
    var path: String {
        switch self {
        case .signUp:
            return "/users/signup/apple"
        case .resign:
            return "/users/resign/apple"
        case .info:
            return "/users/info"
        case .updateInfo:
            return "/users/update/info"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .resign:
            return .post
        case .info:
            return .post
        case .updateInfo:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signUp(let dto):
            return .requestJSONEncodable(dto)
        case .resign:
            return .requestPlain
        case .info(let dto):
            return .requestJSONEncodable(dto)
        case .updateInfo(let dto):
            return .requestJSONEncodable(dto)
        }
    }
}
