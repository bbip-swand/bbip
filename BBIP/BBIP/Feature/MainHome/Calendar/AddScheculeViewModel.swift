//
//  AddScheculeViewModel.swift
//  BBIP
//
//  Created by 이건우 on 11/14/24.
//

import Combine

class AddScheculeViewModel: ObservableObject {
    @Published var selectedStudyName: String?
    @Published var selectedStudyId: String = ""
    @Published var scheduleTitle: String = ""
}
