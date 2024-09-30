//
//  AttendanceCertificationViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import Foundation
import Combine

final class AttendanceCertificationViewModel: ObservableObject {
    //MARK: - get attend record
    @Published var records: [getAttendRecordVO] = []
     var cancellables = Set<AnyCancellable>()
    
    @Published var formattedTime: String = "00:00"
    private var timer: AnyCancellable?
    
    //MARK: - apply code
    @Published var remainingTime:Int = 600
    @Published var getStatusData: GetStatusVO?
    
    // MARK: - Code
    @Published var codeDigits: [String] = ["", "", "", ""]
    @Published var showInvalidCodeWarning = false
    @Published var showAttendanceDone = false
    @Published var stringCode: String = ""
    @Published var combinedCode:Int = 0
    //TODO: -studyID식별
    @Published var studyId:String = "6e9d9656-62c4-4b81-acee-0edb1bc71b02"
    
    
    //UseCase
    private let getAttendRecordUseCase: GetAttendRecordUseCaseProtocol
    private let getStatusUseCase: GetStatusUseCaseProtocol
    private let enterCodeUseCase: EnterCodeUseCaseProtocol
    
    init(
        getAttendRecordUseCase: GetAttendRecordUseCaseProtocol,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        getStatusUseCase: GetStatusUseCaseProtocol,
        enterCodeUseCse: EnterCodeUseCaseProtocol
    ){
        self.cancellables = cancellables
        self.getAttendRecordUseCase = getAttendRecordUseCase
        self.getStatusUseCase = getStatusUseCase
        self.enterCodeUseCase = enterCodeUseCse
    }
    
    //MARK: -getAttendRecord
    func getAttendRecord(studyId: String){
        getAttendRecordUseCase.execute(studyId: "f1937080-0938-438b-aef5-2ae581bd8f42")
            .receive(on: DispatchQueue.main)
            .sink{completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    error.handleDecodingError()
                    print("fail load attendance records: \(error.localizedDescription)")
                }
            }receiveValue: { [weak self] records in
                guard let self = self else { return }
                self.records = records // 받은 상태 정보를 저장
                print("getAttendRecord: \(records)")
            }
            .store(in: &cancellables)
        
        
    }
    //MARK: -GET status
    func getStatusAttend() {
        getStatusUseCase.execute()
            .receive(on: DispatchQueue.main) // UI 업데이트를 위해 메인 스레드에서 받음
            .sink { completionStatus in
                switch completionStatus {
                case .finished:
                    break
                case .failure(let error):
                    error.handleDecodingError()
                    print("fail load attend status: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.getStatusData = response
                // remainingTime 계산
                let currentTime = Date()
                let expirationTime = response.startTime.addingTimeInterval(TimeInterval(response.ttl))
                self.remainingTime = max(0, Int(expirationTime.timeIntervalSince(currentTime)) - 9*60*60)
                print("currentTime: \(currentTime)")
                print("expirationTime: \(expirationTime)")
                print("Response ttl : \(response.ttl)")
                print("RemainingTime: \(self.remainingTime)")
            }
            .store(in: &cancellables)
    }
    
    //MARK: - PUT attend/apply
    func enterCode() {
        let attendVO = AttendVO(studyId: studyId, session: 1, code: combinedCode)
        
        enterCodeUseCase.execute(attendVO: attendVO)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.showAttendanceDone = true
                    self.showInvalidCodeWarning = false
                    break
                case .failure(let error):
                    self.showAttendanceDone = false
                    self.showInvalidCodeWarning = true
                    print("Failed to enter the code: \(error.localizedDescription)")
                }
            }, receiveValue: {
            
            })
            .store(in: &cancellables)
    }
    
    
    func handleTextFieldChange(index: Int, newValue: String) -> Int? {
        if newValue.isEmpty {
            return moveToPreviousField(index: index)
        } else {
            codeDigits[index] = String(newValue.prefix(1))
            updateCombinedCode()
            resetWarning() 
            if isComplete() {
                
            }
            return moveToNextField(index: index)
        }
    }
    
    
    func moveToNextField(index: Int) -> Int? {
        return (index < 3) ? index + 1 : nil
    }
    
    
    func moveToPreviousField(index: Int) -> Int? {
        return (index > 0) ? index - 1 : 0
    }
    
    func isComplete() -> Bool {
        return codeDigits.allSatisfy { $0.count == 1 }
    }
    
    func updateCombinedCode() {
        stringCode = codeDigits.joined()
        combinedCode = Int(stringCode) ?? 0
        print(combinedCode)
    }
    
    func resetWarning() {
            if codeDigits.contains(where: { $0.isEmpty }) {
                showInvalidCodeWarning = false
            }
        }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimer() {
        if timer == nil {
            formattedTime = formatTime(remainingTime)
            
            timer = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { [self] _ in
                    guard self.remainingTime > 0 else {
                        self.timer?.cancel()
                        self.timer = nil
                        return
                    }
                    self.remainingTime -= 1
                    formattedTime = self.formatTime(remainingTime)
                }
        }
    }
}
