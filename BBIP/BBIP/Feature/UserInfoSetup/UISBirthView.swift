//
//  UISbirthyear.swift
//  BBIP
//
//  Created by 조예린 on 8/25/24.
//

import Foundation
import SwiftUI

struct UISBirthView: View {
    
    @StateObject private var viewModel = UserInfoSetupViewModel()
    @FocusState private var focusedField: Int?
    

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            UISHeaderView(
                title: "태어난 연도를 입력해주세요"
            )
            .padding(.top, 72)
            .padding(.leading, 20)
            
            Spacer().frame(height: 120)
            
            HStack(spacing: 8) {
                Spacer(minLength: 40)
                ForEach(0..<4, id: \.self) { index in
                    TextField("", text: $viewModel.yearDigits[index])
                        .font(.bbip(family: .Regular, size: 48))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .focused($focusedField, equals:index)
                        .onChange(of: viewModel.yearDigits[index]) { oldValue,newValue in

                             if newValue.isEmpty{
                                moveToPreviousField(index: index)
                                
                            } else {
                                viewModel.yearDigits[index] = String(newValue.prefix(1))
                                moveToNextField(index: index)
                               
                            }
                            
                            updateCombinedYear()
                            if isYearComplete() {
                                validateYear()
                            }
                        }
                        .underlineView(isActive: !viewModel.yearDigits[index].isEmpty || focusedField == index, isError: !viewModel.isYearValid)
                }
                Spacer(minLength: 40)
            }
            .frame(maxWidth: .infinity)
            
            HStack{
                if isYearComplete(){
                    if !viewModel.isYearValid {
                        Text("유효한 년도를 입력해주세요.")
                            .foregroundColor(.red)
                            .font(.footnote)
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 23)
            .padding(.top, 23)
            
            Spacer()
        }
        .contentShape(Rectangle()) // Allows the whole VStack to be tappable
        .onTapGesture {
            focusedField = nil
        }
    }
    
    private func moveToNextField(index: Int) {
        if index <= 3 {
            focusedField = index+1
        } else {
            focusedField = nil
        }
        
    }
    
    private func moveToPreviousField(index: Int) {
        if index > 0 {
            focusedField = index-1
        } else {
            focusedField = 0
        }
        
    }
    
    private func isYearComplete() -> Bool {
        return viewModel.yearDigits.allSatisfy { $0.count == 1 }
    }
    
    private func validateYear() {
        let yearString = viewModel.yearDigits.joined()
        if let year = Int(yearString), (1950...Calendar.current.component(.year, from: Date())).contains(year) {
            viewModel.isYearValid = true
        } else {
            viewModel.isYearValid = false
        }
    }
    
    private func updateCombinedYear() {
        viewModel.combinedYear = viewModel.yearDigits.joined()
        print("CombinedYear: ",viewModel.combinedYear)
    }
}

extension View {
    func underlineView(isActive: Bool, isError: Bool) -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(isActive ? .red : .gray3),
                alignment: .bottom
            )
    }
}

#Preview{
    UISBirthView()
}

