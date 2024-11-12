//
//  CalendarViewModel.swift
//  BBIP
//
//  Created by 이건우 on 9/14/24.
//

import SwiftUI
import Combine 

final class CalendarViewModel: ObservableObject {
    @Published var vo: [ScheduleVO]?
    @Published var selectedDate: Date = Date()
    @Published var isLoading: Bool = false
    
    private let getMonthlyScheduleUseCase: GetMonthlyScheduleUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(getMonthlyScheduleUseCase: GetMonthlyScheduleUseCaseProtocol) {
        self.getMonthlyScheduleUseCase = getMonthlyScheduleUseCase
    }
    
    func fetch(date: Date) {
        isLoading = true
        
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        getMonthlyScheduleUseCase.excute(year: year, month: month)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.vo = response
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
