//
//  UserInfoSetupViewModel.swift
//  BBIP
//
//  Created by 이건우 on 8/14/24.
//

import Combine
import Foundation
import PhotosUI

class UserInfoSetupViewModel: ObservableObject {
    private let createUserInfoUseCase: CreateUserInfoUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(createUserInfoUseCase: CreateUserInfoUseCaseProtocol) {
        self.createUserInfoUseCase = createUserInfoUseCase
        self.contentData = UserInfoSetupContent.generate()
    }
    
    @Published var contentData: [UserInfoSetupContent]
    @Published var canGoNext: [Bool] = [
        false,  // 지역 설정
        false,  // 관심사 (스킵 가능)
        false,  // 프로필 사진
        false,  // 생년월일
        false   // 직업
    ]
    @Published var showCompleteView: Bool = false
    
    
    // MARK: - Active Area Setting View
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
    
    // MARK: - Interest Setting View
    @Published var selectedInterestIndex: [Int] = []
    
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
    
    // MARK: - Job Setting View
    @Published var selectedJobIndex: [Int] = []
    
    func createUserInfo() {
        AWSS3Manager.shared.upload(image: selectedImage ?? UIImage(named: "profile_default")!)
            .receive(on: DispatchQueue.main)
            .flatMap { [weak self] profileImageUrl -> AnyPublisher<Bool, Error> in
                guard let self = self else {
                    return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
                }
                // 생성된 profileImageUrl을 사용하여 UserInfoVO 객체 생성
                let vo = UserInfoVO(
                    selectedArea: self.selectedArea,
                    selectedInterestIndex: self.selectedInterestIndex,
                    userName: self.userName,
                    profileImageUrl: profileImageUrl,  // 업로드된 URL을 할당
                    birthYear: self.combinedYear,
                    selectedJobIndex: self.selectedJobIndex
                )
                
                // 회원 정보를 생성
                return self.createUserInfoUseCase.execute(userInfoVO: vo)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("회원가입 실패: \(error.localizedDescription)")
                }
            } receiveValue: { isSuccess in
                print(isSuccess ? "회원가입 완료!" : "회원가입 실패!")
                self.showCompleteView = isSuccess
            }
            .store(in: &cancellables)
    }
}
