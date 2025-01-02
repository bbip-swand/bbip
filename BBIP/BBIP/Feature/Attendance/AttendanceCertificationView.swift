import SwiftUI
import Combine

struct AttendanceCertificationView: View {
    @ObservedObject private var viewModel: AttendanceCertificationViewModel = DIContainer.shared.makeAttendanceCertificationViewModel()
    @FocusState private var focusedIndex: Int?
    
    @State private var timer: AnyCancellable?
    @State private var formattedTime: String = "00:00"
    
    @State private var remainingTime: Int
    private var studyName: String
    private var studyId: String
    
    init(
        remainingTime: Int,
        studyId: String,
        studyName: String
    ) {
        self.remainingTime = remainingTime
        self.studyId = studyId
        self.studyName = studyName
    }
    
    private var submitButtonEnableState: Bool {
        viewModel.isAllEntered() && remainingTime != 0 ? true : false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            headerSection
            
            if remainingTime == 0 {
                expiredSessionView
            } else {
                activeSessionView
            }
            
            Spacer()
            
            if remainingTime == 0 {
                Text("라운드가 이미 시작되었습니다.")
                    .font(.bbip(.body1_m16))
                    .foregroundStyle(.gray6)
                    .padding(.bottom, 20)
            }
            
            MainButton(text: "파이트!", enable: submitButtonEnableState) {
                viewModel.submitCode(studyId: studyId)
            }
            .padding(.bottom, 22)
        }
        .backButtonStyle(isReversal: true)
        .background(.gray9)
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            focusedIndex = nil
        }
        .navigationDestination(isPresented: $viewModel.showDoneView) {
            AttendanceDoneView()
        }
        .onAppear {
            setNavigationBarAppearance(backgroundColor: .gray9)
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 12) {
            Image("glove")
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.top, 22)
            
            Text("출석 인증 코드 입력")
                .foregroundStyle(.mainWhite)
                .font(.bbip(.title4_sb24))
            
            Text("생성된 4자리 코드를 입력하세요")
                .foregroundStyle(.gray6)
                .font(.bbip(.caption1_m16))
                .padding(.bottom, remainingTime == 0 ? 41 : 48)
        }
    }
    
    private var expiredSessionView: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray8)
                
                Text(studyName)
                    .font(.bbip(.title3_sb20))
                    .foregroundColor(.mainWhite)
            }
            .frame(maxWidth: .infinity, maxHeight: 34)
            .padding(.horizontal, 38)
            
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 70)
                .foregroundStyle(.gray8)
                .overlay(
                    HStack(spacing: 15) {
                        Image("alarm")
                            .renderingMode(.template)
                            .foregroundColor(.primary3)
                        
                        Text(formattedTime)
                            .font(.bbip(.title1_sb42))
                            .foregroundStyle(.primary3)
                    }
                )
                .padding(.horizontal, 38)
        }
    }
    
    private var activeSessionView: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 70)
                .foregroundStyle(.gray8)
                .overlay(
                    HStack(spacing: 15) {
                        Image("alarm")
                            .renderingMode(.template)
                            .foregroundColor(.mainWhite)
                        
                        Text(formattedTime)
                            .font(.bbip(.title1_sb42))
                            .foregroundStyle(.mainWhite)
                    }
                )
                .padding(.horizontal, 38)
            
            codeInputSection
            
            if viewModel.isWrongCode || !viewModel.errorMessage.isEmpty {
                WarningLabel(errorText: "\(viewModel.errorMessage)")
                    .padding(.top, 4)
            }
        }
    }
    
    private var codeInputSection: some View {
        HStack(spacing: 12) {
            ForEach(0..<4, id: \.self) { index in
                AttendanceSubmitTextFeild(
                    text: $viewModel.codeDigits[index],
                    isWrongCode: $viewModel.isWrongCode,
                    focusedField: $focusedIndex,
                    index: index,
                    font: .bbip(.title1_sb42),
                    isFocused: focusedIndex == index,
                    isFilled: !viewModel.codeDigits[index].isEmpty,
                    onTextChange: { index, newValue in
                        let nextIndex = viewModel.handleTextFieldChange(index: index, newValue: newValue)
                        if viewModel.isAllEntered() {
                            focusedIndex = nil
                            return nil
                        } else {
                            focusedIndex = nextIndex
                            return nextIndex
                        }
                    }
                )
            }
        }
        .padding(.horizontal, 38)
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func startTimer() {
        formattedTime = formatTime(remainingTime)
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                guard remainingTime > 0 else {
                    formattedTime = "00:00"
                    timer?.cancel()
                    return
                }
                remainingTime -= 1
                formattedTime = formatTime(remainingTime)
            }
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}
