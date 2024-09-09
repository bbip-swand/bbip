//
//  BaseAPI.swift
//  BBIP
//
//  Created by 이건우 on 9/6/24.
//

import Foundation
import Moya

protocol BaseAPI: TargetType { }

extension BaseAPI {
    public var baseURL: URL {
        guard let baseURL = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
            return URL(string: "dummy")!
        }
        
        return URL(string: baseURL)!
    }
    
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
