//
//  UserInfoSetupViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/14/24.
//

import Foundation

class UserInfoSetupViewModel: ObservableObject {
    @Published var contentData: [UserInfoSetupContent]
    
    init() {
        self.contentData = UserInfoSetupContent.generate()
    }
}
