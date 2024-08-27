//
//  GridButtonView.swift
//  BBIP
//
//  Created by 이건우 on 8/27/24.
//

import SwiftUI

enum GridButtonViewType {
    case interest, job
}

struct GridButtonView: View {
    @Binding var selectedIndex: Int
    
    private let type: GridButtonViewType
    private var contents: [GridButtonContent] {
        switch type {
        case .interest:
            GridButtonContent.generateInterestContent()
        case .job:
            GridButtonContent.generateJobContent()
        }
    }
    private var gridItems: [GridItem] {
        switch type {
        case .interest:
            Array(repeating: .init(.flexible(), spacing: 8), count: 3)
        case .job:
            Array(repeating: .init(.fixed(135), spacing: 16), count: 2)
        }
    }
    
    private var imageSize: CGFloat {
        switch type {
        case .interest:
            54
        case .job:
            60
        }
    }
    
    init(
        type: GridButtonViewType,
        selectedIndex: Binding<Int>
    ) {
        self.type = type
        self._selectedIndex = selectedIndex
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            var itemWidth: CGFloat {
                switch type {
                case .interest:
                    (geometry.size.width - 16) / 3
                case .job:
                    135
                }
            }
            
            LazyVGrid(columns: gridItems, spacing: type == .interest ? 8 : 16) {
                ForEach(contents.indices, id: \.self) { index in
                    let content = contents[index]
                    
                    Button {
                        selectedIndex = index
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    selectedIndex == index
                                    ? .primary1
                                    : .mainWhite
                                )
                            
                            VStack(spacing: 12) {
                                Image(content.imgName)
                                    .resizable()
                                    .frame(width: imageSize, height: imageSize)
                                
                                Text(content.text)
                                    .font(.bbip(.body1_m16))
                                    .foregroundStyle(.gray7)
                            }
                        }
                        .frame(width: itemWidth, height: itemWidth)
                    }
                    .radiusBorder(
                        cornerRadius: 12,
                        color: selectedIndex == index
                        ? .primary3
                        : .gray2,
                        lineWidth: selectedIndex == index
                        ? 2
                        : 1
                    )
                }
            }
        }
    }
}
