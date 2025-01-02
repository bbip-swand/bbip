//
//  ArchiveAPI.swift
//  BBIP
//
//  Created by 이건우 on 9/30/24.
//

import Foundation
import Moya

enum ArchiveAPI {
    case getArchivedFile(studyId: String)
}

extension ArchiveAPI: BaseAPI {
    var path: String {
        switch self {
        case .getArchivedFile(let studyId):
            return "/archive/\(studyId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getArchivedFile:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getArchivedFile:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
