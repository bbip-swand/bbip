//
//  Untitled.swift
//  BBIP
//
//  Created by 이건우 on 11/11/24.
//

import SwiftUI

enum ServiceInfoListRowType: Equatable, Hashable {
    case button
    case info(String)
}

struct ServiceInfo: Identifiable, Hashable {
    var title: String
    var info: ServiceInfoListRowType = .button
    var action: (() -> Void) = {}
    let id = UUID()
    
    static func == (lhs: ServiceInfo, rhs: ServiceInfo) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.info == rhs.info
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(info)
    }
    
    static func MypageSettingList() -> [ServiceInfo] {
        return [
            ServiceInfo(title: "약관 및 정책") {
                print("Show: 약관 및 정책")
            },
            ServiceInfo(title: "버전 정보", info: .info("1.0.0"))
        ]
    }
}

struct ServiceInfoListRow: View {
    private let data: ServiceInfo
    
    init(data: ServiceInfo) {
        self.data = data
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Text(data.title)
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray8)
            
            Spacer()
            
            switch data.info {
            case .button:
                Button(action: data.action) {
                    Image("info_open")
                }
            case .info(let description):
                Text(description)
                    .font(.bbip(.caption3_r12))
                    .foregroundStyle(.gray6)
            }
        }
    }
}
