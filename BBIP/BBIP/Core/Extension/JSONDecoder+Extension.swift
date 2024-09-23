//
//  JSONDecoder+Extension.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import Foundation

extension JSONDecoder {
    static func iso8601WithMillisecondsDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601WithMilliseconds)
        return decoder
    }
}
