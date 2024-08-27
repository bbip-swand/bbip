//
//  MainStudyCell.swift
//  BBIP
//
//  Created by 조예린 on 8/27/24.
//

import Foundation
import SwiftUI

// 1. 카테고리 enum 정의
enum StudyCategory: String {
    case design = "디자인"
    case language = "어학"
    case science = "과학"
    case math = "수학"
    case history = "역사"
    case technology = "기술"
    case art = "예술"
    case sports = "스포츠"
    case music = "음악"
    
    var color: Color {
        switch self {
        case .design: return .accent3
        case .language: return .primary3
        case .science: return .green
        case .math: return .purple
        case .history: return .orange
        case .technology: return .indigo
        case .art: return .pink
        case .sports: return .black
        case .music: return .yellow
        }
    }
}

// 2. DurationText의 존재 여부를 나타내는 enum
enum DurationType {
    case haveDate(weekText: String, descriptionText: String)
    case nonDate
}

// 3. 메인 StudyCardView 정의
struct StudyCardView: View {
    var studyImage: String = "profile_default"
    var studyTitle: String
    var category: StudyCategory
    var durationType: DurationType
    var dateText: String
    var locationText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Image(studyImage)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(studyTitle)
                        .font(.bbip(.body1_sb16))
                        .foregroundColor(.gray8)
                }
                
                Spacer()
                
                Text(category.rawValue)
                    .font(.bbip(.caption2_m12))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundColor(category.color)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(category.color, lineWidth: 1)
                    )
            }
            .padding(.top, 14)
            
            // 4. DurationType에 따라 다른 뷰를 표시
            switch durationType {
            case .haveDate(let weekText, let descriptionText):
                HStack {
                    Text(weekText)
                        .font(.bbip(.body1_m16))
                        .foregroundColor(.primary3)
                        .fontWeight(.bold)
                    
                    Spacer().frame(width: 8)
                    
                    Text(descriptionText)
                        .font(.bbip(.body1_m16))
                        .foregroundColor(.gray8)
                        
                }
                .padding(.top, 8)
                .padding(.bottom, 6)
                
            case .nonDate:
                Spacer().frame(height: 10)
            }
            
            Divider().foregroundColor(.gray2) // underline 추가
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("study_calender")
                        .foregroundColor(.gray4)
                    
                    Text(dateText)
                        .font(.bbip(.caption2_m12))
                        .foregroundColor(.gray7)
                }
                
                HStack {
                    Image("study_home")
                        .foregroundColor(.gray4)
                    
                    Text(locationText)
                        .font(.bbip(.caption2_m12))
                        .foregroundColor(.gray7)
                }
                .padding(.top, 9)
            }
            .padding(.top, 12)
            .padding(.bottom, 12)
            
        }
        .padding(.horizontal, 18)
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// 5. sample
struct reContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            StudyCardView(
                studyImage: "profile_add",
                studyTitle: "포트폴리오 스터디",
                category: .design,
                durationType: .nonDate,
                dateText: "10주차, 주 1회 화요일 15:00",
                locationText: "비대면(디코)"
            )
            
            StudyCardView(
                studyTitle: "JLPT N2 청해 스터디",
                category: .language,
                durationType: .haveDate(weekText: "3주차", descriptionText: "Day 18 단어시험"),
                dateText: "8월 11일 / 12:00 ~ 15:00",
                locationText: "미정"
            )
        }
        .padding()
    }
}

#Preview{
    reContentView()
}
