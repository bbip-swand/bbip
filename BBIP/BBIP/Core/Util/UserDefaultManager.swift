//
//  UserDefaultManager.swift
//  BBIP
//
//  Created by 이건우 on 8/28/24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    private init() {}

    private enum UserDefaultKeys: String {
        case isLoggedIn
        case accessToken
    }

    // MARK: - Setters
    func saveAccessToken(token: String) {
        defaults.set(token, forKey: UserDefaultKeys.accessToken.rawValue)
    }
    
    func setIsLoggedIn(_ value: Bool) {
        defaults.set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

    // MARK: - Getters
    func checkLoginStatus() -> Bool {
        return defaults.bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

    // MARK: - Clear Data
    func clearUserData() {
        defaults.removeObject(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
}
