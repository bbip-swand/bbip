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
    private let fullStudyInfoMapper = FullStudyInfoMapper()
    
    private lazy var studyRepository: StudyRepository = StudyRepositoryImpl(
        dataSource: studyDataSource,
        studyInfoMapper: studyInfoMapper, 
        createStudyInfoMapper: createStudyInfoMapper,
        currentWeekStudyInfoMapper: currentWeekStudyInfoMapper, 
        fullStudyInfoMapper: fullStudyInfoMapper
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
    private lazy var getFullStudyInfoUseCase: GetFullStudyInfoUseCaseProtocol = GetFullStudyInfoUseCase(
        repository: studyRepository
    )
    
    
    // MARK: - Posting
    private let postingDataSource = PostingDataSource()
    private let recentPostMapper = RecentPostMapper()
    private let postDetailMapper = PostDetailMapper()
    private lazy var postingRepository: PostingRepository = PostingRepositoryImpl(
        dataSource: postingDataSource,
        recentPostMapper: recentPostMapper,
        postDetailMapper: postDetailMapper
    )
    
    private lazy var getCurrentWeekPostUseCase: GetCurrentWeekPostUseCaseProtocol = GetCurrentWeekPostUseCase(
        repository: postingRepository
    )
    private lazy var getStudyPostingUseCase: GetStudyPostingUseCaseProtocol = GetStudyPostingUseCase(
        repository: postingRepository
    )
    
    // MARK: - Archive
    private let archiveDataSource = ArchiveDataSource()
    private let archivedFileInfoMapper = ArchivedFileInfoMapper()
    private lazy var archiveRepository: ArchiveRepository = ArchiveRepositoryImpl(
        dataSource: archiveDataSource,
        mapper: archivedFileInfoMapper
    )
    
    private lazy var getArchivedFileInfoUseCase: GetArchivedFileInfoUseCaseProtocol = GetArchivedFileInfoUseCase(
        repository: archiveRepository
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
            getOngoingStudyInfoUseCase: getOngoingStudyInfoUseCase
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
    
    // StudyHome
    func makeStudyHomeViewModel() -> StudyHomeViewModel {
        return StudyHomeViewModel(
            getFullStudyInfoUseCase: getFullStudyInfoUseCase,
            getStudyPostingUseCase: getStudyPostingUseCase
        )
    }
    
    // Archive
    func makeArchiveViewModel() -> ArchiveViewModel {
        return ArchiveViewModel(
            getArchivedFileInfoUseCase: getArchivedFileInfoUseCase
        )
    }
}
