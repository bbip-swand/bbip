//
//  StudyHomeView.swift
//  BBIP
//
//  Created by 이건우 on 9/24/24.
//

import SwiftUI

struct StudyHomeView: View {
    private let studyId: String
    
    init(studyId: String) {
        self.studyId = studyId
    }
    
    var body: some View {
        Text(studyId)
    }
}

#Preview {
    StudyHomeView(studyId: "a")
}
