//
//  UserStateManager.swift
//  BBIP
//
//  Created by 이건우 on 10/2/24.
//

import Foundation

final class UserStateManager {
    private let userDataSource = UserDataSource()
    
    func checkIsNewUser(completion: @escaping (Bool) -> Void) {
        userDataSource.checkIsNewUser(completion: completion)
    }
}
