//
//  errorExtension.swift
//  BBIP
//
//  Created by 조예린 on 9/29/24.
//

import Foundation

extension Error {
    func handleDecodingError() {
        if let decodingError = self as? DecodingError {
            switch decodingError {
            case .typeMismatch(let type, let context):
                print("Type mismatch for type: \(type), context: \(context)")
            case .valueNotFound(let value, let context):
                print("Value not found: \(value), context: \(context)")
            case .keyNotFound(let key, let context):
                print("Key not found: \(key), context: \(context)")
            case .dataCorrupted(let context):
                print("Data corrupted, context: \(context)")
            default:
                print("Decoding error: \(decodingError)")
            }
        } else {
            print("Other error: \(self)")
        }
    }
}
