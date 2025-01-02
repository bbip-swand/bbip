//
//  UISActiveAreaView.swift
//  BBIP
//
//  Created by 이건우 on 8/25/24.
//

import SwiftUI
import SwiftUIIntrospect

struct UISActiveAreaView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    private let sheetModalHeight: CGFloat = 565
    
    private func showSheetAndReset() {
        viewModel.showAreaSelectModal = true
        viewModel.canGoNext[0] = false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SelectedAreaStatusView(viewModel: viewModel)
                .animation(nil)
                .onTapGesture {
                    showSheetAndReset()
                }
                .padding(.top, 180)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.showAreaSelectModal) {
            AreaSelectView(viewModel: viewModel)
                .presentationDetents([.height(sheetModalHeight)])
        }
    }
}

private struct SelectedAreaStatusView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    
    private var nonNilSelectedAreas: [String] {
        let filteredAreas = viewModel.selectedArea.compactMap { $0 }
        return filteredAreas.isEmpty ? Array(repeating: "선택", count: 3) : filteredAreas
    }
    
    private var areaForDisplay: [String] {
        viewModel.canGoNext[0]
            ? nonNilSelectedAreas
            : viewModel.selectedArea.compactMap { $0 ?? "선택" }
    }
    
    @ViewBuilder
    private func SpacerIfNeeded(for count: Int, condition: Int) -> some View {
        if count == condition {
            Spacer()
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(.gray2)
            .frame(height: 60)
            .padding(.horizontal, 20)
            .overlay {
                HStack {
                    SpacerIfNeeded(for: areaForDisplay.count, condition: 2)
                    
                    ForEach(areaForDisplay.indices, id: \.self) { index in
                        if index > 0 {
                            Spacer()
                            Image("UIS_rightArrow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                            Spacer()
                        }
                        
                        Text(areaForDisplay[index])
                            .foregroundStyle(areaForDisplay[index] == "선택" ? .gray6 : .mainBlack)
                    }
                    
                    SpacerIfNeeded(for: areaForDisplay.count, condition: 2)
                }
                .font(.bbip(.body1_m16))
                .foregroundStyle(.gray6)
                .padding(.horizontal, 66)
            }
    }
}

fileprivate struct AreaSelectView: View {
    @ObservedObject var viewModel: UserInfoSetupViewModel
    @State private var currentIndex: Int = 0
    @State private var selectedData: String?
    
    private func processSelection(_ data: String) {
        switch currentIndex {
        case 0:
            viewModel.selectedCity = data
            updateCurrentIndexIfNeeded(for: AreaDataManager.getDistricts(for: data), nextIndex: 1)
        case 1:
            viewModel.selectedDistrict = data
            updateCurrentIndexIfNeeded(for: AreaDataManager.getSubDistricts(for: viewModel.selectedCity!, district: data), nextIndex: 2)
        case 2:
            viewModel.selectedsubDistricts = data
            setDataComplete()
        default:
            break
        }
    }
    
    private func updateCurrentIndexIfNeeded(for data: [String], nextIndex: Int) {
        if data.isEmpty {
            setDataComplete()
        } else {
            currentIndex = nextIndex
        }
        selectedData = nil
    }
    
    private func setDataComplete() {
        viewModel.showAreaSelectModal = false
        viewModel.canGoNext[0] = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SelectedAreaStatusView(viewModel: viewModel)
                .padding(.top, 22)
                .padding(.bottom, 26)
            
            TabView(selection: $currentIndex) {
                AreaGridView(
                    data: AreaDataManager.getCities(),
                    selectedData: $selectedData
                )
                .tag(0)
                
                if let city = viewModel.selectedCity {
                    AreaGridView(
                        data: AreaDataManager.getDistricts(for: city),
                        selectedData: $selectedData
                    )
                    .tag(1)
                }
                
                if let city = viewModel.selectedCity,
                   let district = viewModel.selectedDistrict {
                    AreaGridView(
                        data: AreaDataManager.getSubDistricts(for: city, district: district),
                        selectedData: $selectedData
                    )
                    .tag(2)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .introspect(.tabView(style: .page), on: .iOS(.v17, .v18)) { tabView in
                tabView.isScrollEnabled = false
            }
            .padding(.bottom, 26)
            
            MainButton(text: "선택", enable: selectedData != nil) {
                if let data = selectedData {
                    withAnimation(.easeIn(duration: 0.1)) { processSelection(data) }
                }
            }
            .padding(.bottom, 22)
        }
    }
}

fileprivate struct AreaGridView: View {
    let data: [String]
    @Binding var selectedData: String?
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(data, id: \.self) { strData in
                    Text(strData)
                        .font(.bbip(.body2_m14))
                        .foregroundStyle(.gray7)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(selectedData == strData ? Color.primary1 : Color.mainWhite)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedData == strData ? Color.primary2 : Color.gray2, lineWidth: 1)
                        )
                        .onTapGesture {
                            selectedData = strData
                        }
                        .padding(.vertical, 3)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

