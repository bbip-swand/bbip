//
//  Font+Extension.swift
//  BBIP
//
//  Created by 이건우 on 8/10/24.
//

import SwiftUI

extension Font {
    enum FontFamily: String {
        case Regular = "Regular"
        case Medium = "Medium"
        case SemiBold = "SemiBold"
        case Bold = "Bold"
    }
    
    enum BBIPStyle {
        case title1_sb42
        case title1_sb28
        case title2_m42
        case title2_m28
        case title3_m30
        case title3_sb20
        case title3_m20
        case title4_sb24
        case title4_m24
        case body1_b16
        case body1_sb16
        case body1_m16
        case body2_b14
        case body2_m14
        case button1_m20
        case button2_m16
        case caption1_m16
        case caption2_m12
        case caption3_r12
        
        var size: CGFloat {
            switch self {
            case .title1_sb42: return 42
            case .title1_sb28: return 28
            case .title2_m42: return 42
            case .title2_m28: return 28
            case .title3_m30: return 30
            case .title3_sb20: return 20
            case .title3_m20: return 20
            case .title4_sb24: return 24
            case .title4_m24: return 24
            case .body1_b16: return 16
            case .body1_sb16: return 16
            case .body1_m16: return 16
            case .body2_b14: return 14
            case .body2_m14: return 14
            case .button1_m20: return 20
            case .button2_m16: return 16
            case .caption1_m16: return 16
            case .caption2_m12: return 12
            case .caption3_r12: return 12
            }
        }
        
        var family: FontFamily {
            switch self {
            case .title1_sb42, .title1_sb28, .title3_sb20, .title4_sb24, .body1_sb16:
                return .SemiBold
            case .title2_m42, .title2_m28, .title3_m30, .title3_m20, .title4_m24, .body1_m16, .body2_m14, .button1_m20, .button2_m16, .caption1_m16, .caption2_m12:
                return .Medium
            case .body1_b16, .body2_b14:
                return .Bold
            case .caption3_r12:
                return .Regular
            }
        }
    }
    
    static func bbip(_ style: BBIPStyle) -> Font {
        return Font.custom("WantedSans-\(style.family.rawValue)", size: style.size)
    }
    
    static func bbip(family: FontFamily, size: CGFloat) -> Font {
        return Font.custom("WantedSans-\(family.rawValue)", size: size)
    }
}
