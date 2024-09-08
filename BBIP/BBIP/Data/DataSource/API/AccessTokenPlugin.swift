//
//  AccessTokenPlugin.swift
//  BBIP
//
//  Created by 이건우 on 9/8/24.
//

import Foundation
import Moya

struct TokenPlugin: PluginType {
    let token: String
    
    init() {
        self.token = UserDefaultsManager.shared.getAccessToken()!
    }

    func prepare(
        _ request: URLRequest,
        target: TargetType
    ) -> URLRequest {
        var request = request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
