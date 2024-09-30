//
//  AWSS3API.swift
//  BBIP
//
//  Created by 이건우 on 9/8/24.
//

import Foundation
import Moya

enum AWSS3API {
    case requestImagePresignedUrl(fileName: String)
    case requestFilePresignedUrl(fileName: String, fileKey: String, studyId: String)
    case upload(fileData: Data, url: String)
}

extension AWSS3API: TargetType {
    var baseURL: URL {
        switch self {
        case .requestImagePresignedUrl, .requestFilePresignedUrl:
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
        case .requestImagePresignedUrl:
            return "/aws-s3/upload-image/presigned-url"
        case .requestFilePresignedUrl:
            return "/aws-s3/upload-file/presigned-url"
        case .upload:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestImagePresignedUrl, .requestFilePresignedUrl:
            return .post
        case .upload:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .requestImagePresignedUrl(let fileName):
            return .requestParameters(parameters: ["fileName": fileName], encoding: JSONEncoding.default)
            
        case .requestFilePresignedUrl(let fileName, let fileKey, let studyId):
            let parameters: [String: Any] = [
                "fileName": fileName,
                "fileKey": fileKey,
                "studyId": studyId
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .upload(let fileData, _):
            return .requestData(fileData)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .requestImagePresignedUrl, .requestFilePresignedUrl:
            let token = UserDefaultsManager.shared.getAccessToken()!
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        case .upload:
            return .none
        }
    }
}
