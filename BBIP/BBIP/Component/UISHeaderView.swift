//
//  UISHeaderView.swift
//  BBIP
//
//  Created by 이건우 on 8/25/24.
//

import SwiftUI

struct UISHeaderView: View {
    @State private var title: String
    @State private var subTitle: String
    
    init(
        title: String,
        subTitle: String = ""
    ) {
        self.title = title
        self.subTitle = subTitle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.bbip(family: .Regular, size: 24))
                .fontWeight(.bold)
            
            Text(subTitle)
                .font(.bbip(family: .Regular, size: 16))
                .foregroundStyle(.gray6)
                .padding(.top, 16)
        }
    }
}

#Preview {
    UISHeaderView(
        title: "This is Title",
        subTitle: "This is subTitle"
    )
}
