//
//  MoyaProvider+Extension.swift
//  BBIP
//
//  Created by 이건우 on 10/2/24.
//

import Moya

extension MoyaProvider {
    /// MoyaProvider 그런데 async await을 곁들인.
    func request(_ target: Target) async -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            self.request(target) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
