//
//  Binding+Extension.swift
//  BBIP
//
//  Created by 이건우 on 8/30/24.
//

import SwiftUI

extension Binding where Value == Double {
    
    /// Binding<Double>타입의 전체값에서 현재 값의 percentage를 0...1까지의 수로 계산한 값
    /// TabViewProgressBar에 값을 Binding할 때 사용됩니다
    static func calculateProgress(currentValue: Binding<Int>, totalCount: Int) -> Binding<Double> {
        return Binding<Double>(
            get: {
                guard currentValue.wrappedValue > 0 else { return 0.2 }
                return Double(currentValue.wrappedValue + 1) / Double(totalCount)
            },
            set: { _ in }
        )
    }
}
