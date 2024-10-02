//
//  UserStateManager.swift
//  BBIP
//
//  Created by 이건우 on 10/2/24.
//

import Foundation

final class UserStateManager {
    private let userDataSource = UserDataSource()
    
    /// 기존 유저인지 확인 후, 아니라면 userDefault를 업데이트
    func updateIsExistingUser(completion: @escaping () -> Void) {
        if UserDefaultsManager.shared.isExistingUser() {
            print("기존유저 이므로 체크는 스킵.")
            completion()
            return
        }
        
        userDataSource.checkIsNewUser { result in
            print("checking is new user...")
            UserDefaultsManager.shared.setIsExistingUser(!result)
            print(result ? "신규유저 입니다!" : "지금부터 기존유저 입니다!")
            completion()
        }
    }
}
