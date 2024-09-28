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
    private let createStudyInfoMapper = CreateStudyInfoMapper()
    private let currentWeekStudyInfoMapper = CurrentWeekStudyInfoMapper()
    
    private lazy var studyRepository: StudyRepository = StudyRepositoryImpl(
        dataSource: studyDataSource,
        studyInfoMapper: studyInfoMapper,
        createStudyInfoMapper: createStudyInfoMapper,
        currentWeekStudyInfoMapper: currentWeekStudyInfoMapper
    )
    
    private lazy var createStudyUseCase: CreateStudyUseCaseProtocol = CreateStudyUseCase(
        repository: studyRepository
    )
    private lazy var getCurrentWeekStudyInfoUseCase: GetCurrentWeekStudyInfoUseCaseProtocol = GetCurrentWeekStudyInfoUseCase(
        repository: studyRepository
    )
    private lazy var getOngoingStudyInfoUseCase: GetOngoingStudyInfoUseCaseProtocol = GetOngoingStudyInfoUseCase(
        repository: studyRepository
    )
    private lazy var joinStudyUseCase: JoinStudyUseCaseProtocol = JoinStudyUseCase(
        repository: studyRepository
    )
    
    //MARK: - Attend
    private let attendDataSource = AttendDataSource()
    private let getStatusMapper = GetStatusMapper()
    private let createCodeMapper = CreateCodeMapper()
    private let getAttendRecordMapper = GetAttendRecordMapper()
    private let enterCodeMapper = EnterCodeMapper()
    
    private lazy var attendRepository: AttendRepository = AttendRepositoryImpl(
        dataSource: attendDataSource,
        createCodeMapper: createCodeMapper,
        enterCodeMapper: enterCodeMapper,
        getStatusMapper: getStatusMapper,
        getRecordMapper: getAttendRecordMapper
    )
    private lazy var createCodeUseCase: CreateCodeUseCaseProtocol = CreateCodeUseCase(repository: attendRepository)
    
    private lazy var enterCodeUseCase: EnterCodeUseCaseProtocol = EnterCodeUseCase(repository: attendRepository)
    
    private lazy var getStatusUseCase: GetStatusUseCaseProtocol = GetStatusUseCase(repository: attendRepository)
    
    private lazy var getAttendRecordUseCase: GetAttendRecordUseCaseProtocol = GetAttendRecordUseCase(repository: attendRepository)
    
    
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
            getCurrentWeekStudyInfoUseCase: getCurrentWeekStudyInfoUseCase,
            getOngoingStudyInfoUseCase: getOngoingStudyInfoUseCase,
            getStatusUseCase: getStatusUseCase
        )
    }
    
    // CreateStudy
    func makeCreateStudyViewModel() -> CreateStudyViewModel {
        return CreateStudyViewModel(createStudyInfoUseCase: createStudyUseCase)
    }
    
    // JoinStudy
    func makeJoinStudyViewModel() -> JoinStudyViewModel {
        return JoinStudyViewModel(joinStudyUseCase: joinStudyUseCase)
    }
}
