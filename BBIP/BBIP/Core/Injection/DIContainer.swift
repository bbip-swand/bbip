//
//  DIContainer.swift
//  BBIP
//
//  Created by 이건우 on 9/21/24.
//

import Foundation

// Dependency Container
class DIContainer {
    static let shared = DIContainer()

    // MARK: - Auth
    private let authDataSource = AuthDataSource()
    private let loginResponseMapper = LoginResponseMapper()
    private lazy var authRepository: AuthRepository = AuthRepositoryImpl(
        dataSource: authDataSource,
        mapper: loginResponseMapper
    
    )
    
    private lazy var requestLoginUseCase: RequestLoginUseCaseProtocol = RequestLoginUseCase(
        repository: authRepository
    )
    
    
    // MARK: - User
    private let userDataSource = UserDataSource()
    private let userInfoMapper = UserInfoMapper()
    private lazy var userRepository: UserRepository = UserRepositoryImpl(
        dataSource: userDataSource,
        mapper: userInfoMapper
    )
    
    private lazy var signUpUseCase: SignUpUseCaseProtocol = SignUpUseCase(
        repository: userRepository
    )
    private lazy var createUserInfoUseCase: CreateUserInfoUseCaseProtocol = CreateUserInfoUseCase(
        repository: userRepository
    )
    
    
    // MARK: - Study
    private let studyDataSource = StudyDataSource()
    private let studyInfoMapper = StudyInfoMapper()
    private let currentWeekStudyInfoMapper = CurrentWeekStudyInfoMapper()
    private lazy var studyRepository: StudyRepository = StudyRepositoryImpl(
        dataSource: studyDataSource,
        studyInfoMapper: studyInfoMapper,
        currentWeekStudyInfoMapper: currentWeekStudyInfoMapper
    )
    
    private lazy var createStudyUseCase: CreateStudyUseCaseProtocol = CreateStudyUseCase(
        repository: studyRepository
    )
    private lazy var getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol = GetCurrentWeekStudyInfoUseCase(
        repository: studyRepository
    )
    
    
    // MARK: - Posting
    private let postingDataSource = PostingDataSource()
    private let currentWeekPostMapper = CurrentWeekPostMapper()
    private lazy var postingRepository: PostingRepository = PostingRepositoryImpl(
        dataSource: postingDataSource,
        mapper: currentWeekPostMapper
    )
    
    private lazy var getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol = GetCurrentWeekPostUseCase(
        repository: postingRepository
    )
    
    // MARK: - ViewModels
    // Login
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(
            requestLoginUseCase: requestLoginUseCase,
            signUpUseCase: signUpUseCase
        )
    }
    
    // UserInfoSetup
    func makeUserInfoSetupViewModel() -> UserInfoSetupViewModel {
        return UserInfoSetupViewModel(createUserInfoUseCase: createUserInfoUseCase)
    }
    
    // UserHome
    func makeMainHomeViewModel() -> MainHomeViewModel {
        return MainHomeViewModel(
            getCurrentWeekPostUseCase: getCurrentWeekPostUseCase, 
            getCurrentWeekStudyInfoUseCase: getCurrentWeekStudyInfoUseCase
        )
    }
    
    // CreateStudy
    func makeCreateStudyViewModel() -> CreateStudyViewModel {
        return CreateStudyViewModel(createStudyInfoUseCase: createStudyUseCase)
    }
}
