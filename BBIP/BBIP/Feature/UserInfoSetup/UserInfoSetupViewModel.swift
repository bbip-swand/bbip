//
//  UserInfoSetupViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/14/24.
//

import Foundation
import PhotosUI

class UserInfoSetupViewModel: ObservableObject {
    @Published var contentData: [UserInfoSetupContent]
    
    // MARK: - Profile Setting View
    @Published var userName: String = ""
    @Published var isNameValid: Bool = false
    @Published var selectedImage: UIImage? = nil
    @Published var showImagePicker: Bool = false
    @Published var hasStartedEditing: Bool = false
    
    
    // MARK: - Birth Setting View
    @Published var yearDigits: [String] = ["", "", "", ""]
    @Published var isYearValid: Bool = true
    @Published var combinedYear: String = ""

    
    init() {
        self.contentData = UserInfoSetupContent.generate()
    }
}
