//
//  AuthAPI.swift
//  BBIP
//
//  Created by 이건우 on 9/6/24.
//

import Foundation
import Moya

enum AuthAPI {
    case login(identityToken: String)
}

extension AuthAPI: BaseAPI {
    var path: String {
        switch self {
        case .login:
            return "/auth/login/apple"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let identityToken):
            let body = LoginRequestDTO(identityToken: identityToken)
            return .requestJSONEncodable(body)
        }
    }
}
