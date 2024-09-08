//
//  AWSS3API.swift
//  BBIP
//
//  Created by 이건우 on 9/8/24.
//

import Foundation
import Moya

enum AWSS3API {
    case requestPresignedUrl(fileName: String)
    case upload(imageData: Data, url: String)
}

extension AWSS3API: TargetType {
    var baseURL: URL {
        switch self {
        case .requestPresignedUrl:
            guard let baseURL = Bundle.main.infoDictionary?["API_BASE_URL"] as? String else {
                return URL(string: "dummy")!
            }
            return URL(string: baseURL)!
        case .upload(_, let url):
            return URL(string: url)!
        }
    }
    
    var path: String {
        switch self {
        case .requestPresignedUrl:
            return "/aws-s3/upload-image/presigned-url"
        case .upload:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestPresignedUrl:
            return .post
        case .upload:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .requestPresignedUrl(let fileName):
            let body = AWSS3RequestPresignedUrlDTO(fileName: fileName)
            return .requestJSONEncodable(body)
        case .upload(let imageData, _):
            return .requestData(imageData)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .requestPresignedUrl:
            let token = UserDefaultsManager.shared.getAccessToken()!
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .upload:
            return ["Content-Type": "image/jpeg"]
        }
    }
}

fileprivate extension AWSS3API {
    struct AWSS3RequestPresignedUrlDTO: Codable {
        let fileName: String
    }
}
