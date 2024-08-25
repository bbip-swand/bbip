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
    @Published var canGoNext: [Bool] = [
        false, // 지역 설정
        true, // 관심 분야 (스킵 가능)
        false,
        false
    ]
    
    
    // MARK: - Active Area View
    // 지역 재 선택시 기존의 데이터 리셋
    @Published var showAreaSelectModal: Bool = false {
        didSet {
            if showAreaSelectModal {
                resetSelectedAreas()
            }
        }
    }
    @Published var selectedCity: String?
    @Published var selectedDistrict: String?
    @Published var selectedsubDistricts: String?
    @Published var noMoreAreaData: Bool = false
    
    private func resetSelectedAreas() {
        selectedCity = nil
        selectedDistrict = nil
        selectedsubDistricts = nil
    }
    
    var selectedArea: [String?] {
        [selectedCity, selectedDistrict, selectedsubDistricts]
    }
    
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
