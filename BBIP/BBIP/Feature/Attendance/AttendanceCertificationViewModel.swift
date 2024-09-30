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
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - apply code
    @Published var remainingTime:Int = 600
    @Published var getStatusData: GetStatusVO?
    
    // MARK: - Code
    @Published var codeDigits: [String] = ["", "", "", ""]
    @Published var isRight: Bool = true
    @Published var stringCode: String = ""
    @Published var combinedCode:Int = 0
   //TODO: -studyID식별
    @Published var studyId:String = "f1937080-0938-438b-aef5-2ae581bd8f42"

    
    //UseCase
    private let getAttendRecordUseCase: GetAttendRecordUseCaseProtocol
    private let getStatusUseCase: GetStatusUseCaseProtocol
    
    init(
        getAttendRecordUseCase: GetAttendRecordUseCaseProtocol,
        cancellables: Set<AnyCancellable> = Set<AnyCancellable>(),
        getStatusUseCase: GetStatusUseCaseProtocol
    ){
        self.cancellables = cancellables
        self.getAttendRecordUseCase = getAttendRecordUseCase
        self.getStatusUseCase = getStatusUseCase
    }
    
    //MARK: -getAttendRecord
    func getAttendRecord(studyId: String){
        getAttendRecordUseCase.execute(studyId: studyId)
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
    //TODO: 시간 계산을 여기서 하는 게 맞을까?
    func getStatusAttend() {
        getStatusUseCase.execute()
                .receive(on: DispatchQueue.main) // UI 업데이트를 위해 메인 스레드에서 받음
                .sink{completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        error.handleDecodingError()
                        print("fail load attend status: \(error.localizedDescription)")
                    }
                }receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    self.getStatusData = response
                    // remainingTime 계산
                    let currentTime = Date()
                    let expirationTime = response.startTime.addingTimeInterval(TimeInterval(response.ttl))
                    self.remainingTime = max(0, Int(expirationTime.timeIntervalSince(currentTime)))
                }
                .store(in: &cancellables)

    }
    
    func handleTextFieldChange(index: Int, newValue: String) -> Int? {
            if newValue.isEmpty {
                return moveToPreviousField(index: index)
            } else {
                codeDigits[index] = String(newValue.prefix(1))
                updateCombinedCode()
                
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
    
    
}
