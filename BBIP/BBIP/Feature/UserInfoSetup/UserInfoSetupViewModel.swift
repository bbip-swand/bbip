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
    @Published var isLoading: Bool = false
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
        isLoading = true
        
        if let selectedImage = selectedImage {
            // selectedImage가 nil이 아닐 경우에만 업로드 실행 (사용자가 사진 선택함)
            AWSS3Manager.shared.upload(image: selectedImage)
                .receive(on: DispatchQueue.main)
                .flatMap { [weak self] uploadedImageUrl -> AnyPublisher<Bool, Error> in
                    guard let self = self else {
                        return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
                    }
                    
                    // UserInfoVO 객체 생성
                    let vo = UserInfoVO(
                        selectedArea: self.selectedArea,
                        selectedInterestIndex: self.selectedInterestIndex,
                        userName: self.userName,
                        profileImageUrl: uploadedImageUrl,
                        birthYear: self.combinedYear,
                        selectedJobIndex: self.selectedJobIndex
                    )
                    
                    // 회원 정보를 생성
                    return self.createUserInfoUseCase.execute(userInfoVO: vo)
                }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        self.isLoading = false
                        print("회원가입 실패: \(error.localizedDescription)")
                    }
                } receiveValue: { isSuccess in
                    if isSuccess {
                        self.isLoading = false
                        self.showCompleteView = true
                        UserDefaultsManager.shared.setIsLoggedIn(true)
                    } else {
                        fatalError("회원가입 문제 발생")
                    }
                }
                .store(in: &cancellables)
        } else {
            // selectedImage가 nil일 경우 빈 데이터 보내기 (사용자가 사진 선택 안함)
            let vo = UserInfoVO(
                selectedArea: self.selectedArea,
                selectedInterestIndex: self.selectedInterestIndex,
                userName: self.userName,
                profileImageUrl: "",
                birthYear: self.combinedYear,
                selectedJobIndex: self.selectedJobIndex
            )
            
            // 회원 정보를 생성
            self.createUserInfoUseCase.execute(userInfoVO: vo)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished: break
                    case .failure(let error):
                        self.isLoading = false
                        print("회원가입 실패: \(error.localizedDescription)")
                    }
                } receiveValue: { isSuccess in
                    if isSuccess {
                        self.isLoading = false
                        self.showCompleteView = true
                        UserDefaultsManager.shared.setIsLoggedIn(true)
                    } else {
                        fatalError("회원가입 문제 발생")
                    }
                }
                .store(in: &cancellables)
        }
    }
}
