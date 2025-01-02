//
//  KeychainManager.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import Foundation
import Security

enum KeychainKeys: String {
    case accessToken = "accessToken"
}

final class KeychainManager {
    static func save(token: String, for key: KeychainKeys) {
        guard let data = token.data(using: .utf8) else {
            print("failed to save token. because cannot casting data type")
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]
        
        // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        assert(status == noErr, "failed to save token")
    }
    
    static func load(for key: KeychainKeys) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let retrievedData = dataTypeRef as? Data else {
            print("failed to load, status code = \(status)")
            return nil
        }
        
        return String(data: retrievedData, encoding: .utf8)
    }
    
    static func delete(key: KeychainKeys) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}

