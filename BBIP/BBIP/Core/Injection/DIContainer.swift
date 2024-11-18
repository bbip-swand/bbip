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
    private lazy var getProfileUseCase: GetProfileUseCaseProtocol = GetProfileUseCase(
        repository: userRepository
    )
    
    
    // MARK: - Attendance
    private let attendanceDataSource = AttendanceDataSource()
    private let attendanceStatusMapper = AttendanceStatusMapper()
    private let attendanceRecordMapper = AttendanceRecordMapper()
    private lazy var attendanceRepository: AttendanceRepository = AttendanceRepositoryImpl(
        dataSource: attendanceDataSource,
        statusMapper: attendanceStatusMapper,
        recordMapper: attendanceRecordMapper
    )
    
    private lazy var getAttendanceStatusUseCase: GetAttendanceStatusUseCaseProtocol = GetAttendanceStatusUseCase(
        repository: attendanceRepository
    )
    private lazy var getAttendanceRecordsUseCase: GetAttendanceRecordsUseCaseProtocol = GetAttendanceRecordsUseCase(
        repository: attendanceRepository
    )
    private lazy var createAttendanceCodeUseCase: CreateAttendanceCodeUseCaseProtocol = CreateAttendanceCodeUseCase(
        repository: attendanceRepository
    )
    private lazy var submitAttendanceUseCase: SubmitAttendanceCodeUseCaseProtocol = SubmitAttendanceCodeUseCase(
        repository: attendanceRepository
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
    private lazy var getFinishedStudyInfoUseCase: GetFinishedStudyInfoUseCaseProtocol = GetFinishedStudyInfoUseCase(
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
    private lazy var getPostDetailUseCase: GetPostDetailUseCaseProtocol = GetPostDetailUseCase(
        repository: postingRepository
    )
    private lazy var createCommentUseCase: CreateCommentUseCaseProtocol = CreateCommentUseCase(
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
    
    // MARK: - Calendar
    private let calendarDataSource = CalendarDataSource()
    private let scheduleMapper = ScheduleMapper()
    private lazy var calendarRepository: CalendarRepository = CalendarRepositoryImpl(
        dataSource: calendarDataSource,
        mapper: scheduleMapper
    )
    
    private lazy var getMonthlyScheduleUseCase: GetMonthlyScheduleUseCaseProtocol = GetMonthlyScheduleUseCase(
        repository: calendarRepository
    )
    private lazy var createScheduleUseCase: CreateScheduleUseCaseProtocol = CreateScheduleUseCase(
        repository: calendarRepository
    )
    private lazy var updateScheduleUseCase: UpdateScheduleUseCaseProtocol = UpdateScheduleUseCase(
        repository: calendarRepository
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
    
    // Attendance Certification
    func makeAttendanceCertificationViewModel() -> AttendanceCertificationViewModel {
        return .init(
            getAttendanceStatusUseCase: getAttendanceStatusUseCase,
            submitAttendanceCodeUseCase: submitAttendanceUseCase,
            getAttendanceRecordsUseCase: getAttendanceRecordsUseCase
        )
    }
    
    // Create Code
    func makeCreateCodeViewModel() -> CreateCodeViewModel {
        return .init(
            getAttendanceStatusUseCase: getAttendanceStatusUseCase,
            createAttendanceCodeUseCase: createAttendanceCodeUseCase,
            getAttendanceRecordsUseCase: getAttendanceRecordsUseCase
        )
    }
    
    // Attendance Records
    func makeAttendanceRecordsViewModel() -> AttendanceRecordsViewModel {
        return .init(
            getAttendanceRecordsUseCase: getAttendanceRecordsUseCase
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
            getStudyPostingUseCase: getStudyPostingUseCase,
            getAttendanceStatusUseCase: getAttendanceStatusUseCase
        )
    }
    
    // Archive
    func makeArchiveViewModel() -> ArchiveViewModel {
        return ArchiveViewModel(
            getArchivedFileInfoUseCase: getArchivedFileInfoUseCase
        )
    }
    
    // Posting Detail
    func makePostingDetailViewModel() -> PostingDetailViewModel {
        return PostingDetailViewModel(
            getPostDetailUseCase: getPostDetailUseCase,
            createCommentUseCase: createCommentUseCase
        )
    }
    
    // MyPage
    func makeMyPageViewModel() -> MyPageViewModel {
        return MyPageViewModel(
            getProfileUseCase: getProfileUseCase,
            getFinishedStudyUseCase: getFinishedStudyInfoUseCase,
            getOngoingStudyUseCase: getOngoingStudyInfoUseCase
        )
    }
    
    // Calendar
    func makeCalendarViewModel() -> CalendarViewModel {
        return CalendarViewModel(
            getMonthlyScheduleUseCase: getMonthlyScheduleUseCase
        )
    }
    
    // Add Schedule (need fix), crud
    func makeAddScheduleViewModel() -> AddScheculeViewModel {
        return AddScheculeViewModel(
            createScheduleUseCase: createScheduleUseCase
        )
    }
}
