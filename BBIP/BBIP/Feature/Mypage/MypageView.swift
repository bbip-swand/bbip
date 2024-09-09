//
//  MypageView.swift
//  BBIP
//
//  Created by 이건우 on 9/9/24.
//

import SwiftUI

struct MypageView: View {
    
    init() {
        setNavigationBarAppearance()
    }
    
    var body: some View {
        VStack {
            Text("This is Mypage View")
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.gray1)
        .navigationTitle("마이페이지")
        .backButtonStyle()
    }
}
